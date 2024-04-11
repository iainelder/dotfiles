function login {
  aws-sso-util login
}

function use-profile {
  export AWS_PROFILE="$(aws configure list-profiles | fzf)"
  printf "%s\n" "$AWS_PROFILE"
}


function install-profiles {
  # I use assume for containerization of console sessions. assume ignores the
  # AWS_CONFIG_FILE variable. See https://github.com/common-fate/granted/issues/229
  # When that is fixed, this install function will probably be redundant.
  ln --symbolic --force "$AWS_CONFIG_FILE" ~/.aws/config
}


function rebuild-profiles {
  "$AWS_PROFILE_RESOLVER"
  merge-aliases
}


function merge-aliases {
  for alias in "${!AWS_ALIASES[@]}"; do
    alias-profile "$alias" "${AWS_ALIASES["$alias"]}"
  done
}


function init-profiles-from-identity-center {

  mkdir --parents "$(dirname "$AWS_CONFIG_FILE")"
  rm --force "$AWS_CONFIG_FILE"

  AWS_MAX_ATTEMPTS=100 \
  aws-sso-util configure populate \
  --sso-start-url "$AWS_SSO_START_URL" \
  --sso-region "$AWS_SSO_REGION" \
  --region "$AWS_DEFAULT_REGION" \
  --components "$AWS_PROFILE_COMPONENTS"
}


function alias-profile {
  alias="$1"
  source="$2"

  crudini --merge "$AWS_CONFIG_FILE" "profile $alias" < <(
    crudini --get --format=sh "$AWS_CONFIG_FILE" "profile $source"
  )
}


function assert_command {
  name="$1"
  if  ! command -v "$name" > /dev/null; then
    echo "Command \`$name\` not found." >&2
    return 1
  fi
}

function empty-config-file {
  mkdir --parents "$(dirname "$AWS_CONFIG_FILE")"
  rm --force "$AWS_CONFIG_FILE"
}


function init-profiles-from-iam-admin-in-management-account {
  empty-config-file
  process="aws-vault export --format=json --no-session --region=$AWS_DEFAULT_REGION $AWS_VAULT_PROFILE"
  aws configure set credential_process "$process" --profile mgmt
  print-profiles-for-organization | crudini --merge "$AWS_CONFIG_FILE"
}

function print-profiles-for-organization {
  source_account=$(
    aws sts get-caller-identity --profile "$AWS_CONFIG_SOURCE_PROFILE" \
    | jq -j '.Account'
  )

  aws organizations list-accounts --profile "$AWS_CONFIG_SOURCE_PROFILE" \
  | jq \
  --arg SourceAccount "$source_account" \
  '.Accounts |= [.[] | select(.Id != $SourceAccount)]' \
  | jq \
  --arg OrgName "$AWS_ORGANIZATION_NAME" \
  --arg DefaultRegion eu-central-1 \
  --arg RoleToAssume OrganizationAccountAccessRole \
  --arg SourceProfile "$AWS_CONFIG_SOURCE_PROFILE" \
  --raw-output \
  '
  def parse($OrgName; $DefaultRegion; $RoleToAssume):
    .
    | .OrgName = $OrgName
    | .SanitizedAccountName = (.Name | split(" ") | join("_"))
    | .ProfileName = "\(OrgName).\(.SanitizedAccountName).\(.Id)"
    | .SourceProfile = $SourceProfile
    | .RoleArn = "arn:aws:iam::\(.Id):role/\($RoleToAssume)"
  ;

  def format:
    [
      "[profile \(.ProfileName)]",
      "source_profile = \(.SourceProfile)",
      "role_arn = \(.RoleArn)"
    ] | join("\n")
  ;

  [.Accounts[] | parse($OrgName; $DefaultRegion; $RoleToAssume) | format] | join("\n\n")
  '
}


for cmd in crudini aws-sso-util fzf aws jq; do
  assert_command "$cmd" || return 1
done

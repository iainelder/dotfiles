# https://www.terraform.io/docs/cli/config/config-file.html#provider-plugin-cache
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

# Concise diff hides important identifying information in some complex nested
# data structures. Uncomment this if important info is missing.
# https://www.terraform.io/upgrade-guides/0-14.html
# https://github.com/hashicorp/terraform/issues/27139
# export TF_X_CONCISE_DIFF=0

alias tfplan='terraform plan --out ~/tmp/$$.tfout'

alias tfapply='terraform apply ~/tmp/$$.tfout'
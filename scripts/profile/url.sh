# https://unix.stackexchange.com/questions/159253/decoding-url-encoding-percent-encoding#comment424350_159254
alias urldecode='python3 -c "import sys, urllib.parse as ul; [sys.stdout.write(ul.unquote_plus(l)) for l in sys.stdin]"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; [sys.stdout.write(ul.quote_plus(l)) for l in sys.stdin]"'

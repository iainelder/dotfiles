# Disable caps lock.
# https://askubuntu.com/questions/574208/deactivate-caps-lock-in-14-04
#
# FIXME: this should run once at startup, not per shell session.
# Try moving this to /etc/profile.d. 
#
# Somehow this can actually set the caps lock to be stuck in ON. Maybe because I
# press the caps lock key between logging in and opening a terminal.
# 
# If that happens, use `setxkbmap -option` to undo it.
setxkbmap -option caps:none

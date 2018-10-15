# Make sure the SSH agent is available in every login shell
if [ -x /usr/bin/gnome-keyring-daemon ]; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
fi
export SSH_AUTH_SOCK

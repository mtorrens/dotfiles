# Always clear the terminal
clear

if [ `uname -o` = "Cygwin" ]; then
  # Deactivate ssh agent
  if [ -x /usr/local/bin/ssh-pageant -a ! -z "$SSH_PAGEANT_PID" ]; then
    eval $(/usr/local/bin/ssh-pageant -qk 2>/dev/null)
  fi
fi

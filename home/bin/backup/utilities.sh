#!/bin/bash
# Get and remove 7z-encrypted private data files, doing our best
# to trap signals and not leave anything orphaned in ${HOME}.

# Encrypt files with:
# 7z a -mhe=on <file>.7z -p <file>
# shred -u <file>

# Manually decrypt with
# 7z x <file>.7z

function get_private_file {

	# Decrypt the file with a safe umask
  umask 077 && 7z x ${HOME}/.private/$1.7z -o${HOME}
  mv ${HOME}/$1 ${HOME}/$2

	# Delete the file if the script fails
	trap "shred -u ${HOME}/$2; exit" INT TERM EXIT
}

function release_private_file {

	# Delete the file
	shred -u ${HOME}/$1

	# Release our trap
	trap - INT TERM EXIT
}

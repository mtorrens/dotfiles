#!/bin/bash
# Get and remove GPG-encrypted private data files, doing our best
# to trap signals and not leave anything orphaned in ${HOME}.

GPG=/usr/bin/gpg

# Encrypt files with:
# gpg --encrypt -r charles@charlespence.net <file>

# Manually decrypt with
# gpg --output <out> --decrypt <file>.gpg

function get_private_file {

	# Decrypt the file with a safe umask
	umask 077 && $GPG --output ${HOME}/$2 --decrypt ${HOME}/.private/$1.gpg

	# Delete the file if the script fails
	trap "rm -f ${HOME}/$2; exit" INT TERM EXIT
}

function release_private_file {

	# Delete the file
	rm ${HOME}/$1

	# Release our trap
	trap - INT TERM EXIT
}



#!/bin/bash
# Get and remove private data files, doing our best to trap signals
# and not leave anything orphaned in ${HOME}.

function get_private_file {
	
	# Copy in the file
	cp ${HOME}/.private/$1 ${HOME}/$2
	
	# Delete the file if the script fails
	trap "rm -f ${HOME}/$2; exit" INT TERM EXIT
}

function release_private_file {
	
	# Delete the file
	rm ${HOME}/$1
	
	# Release our trap
	trap - INT TERM EXIT
}



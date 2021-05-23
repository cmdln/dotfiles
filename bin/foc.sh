#!/usr/bin/env bash

# This script works with a Firefox add on that configures a pseudo protocol
# handler so that scripts and external links can be opened directly in a
# specific browser contianer.
#
# https://addons.mozilla.org/en-US/firefox/addon/open-url-in-container/
#
# A case sensitive container name is required as the first argument.
#
# An optional second argument specifies the URL to open. If unset, this script
# will use the clipboard contents. This behavior supports the use case of
# copying a link location from an email message or chat then using this script
# to open that link in a specific container.

# Invoke Firefox with a constructed URL that the Open URL in Container add on
# can handle
firefox_open_container() {
        firefox "ext+container:name=$1&url=$2"
}

# Validate the arguments, computing the default value for the second argument if
# it is absent
main() {
        local container
        if [ -z "$1" ]
        then
                echo "Must supply container name!"
                exit 1
        fi
        container="$1"

        local url
        if [ -z "$2" ]
        then
                url="$(xclip -o)"
        else
                url="$2"
        fi

        firefox_open_container "$container" "$url"
}

main "$@"

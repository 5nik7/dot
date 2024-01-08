function extend_path() {
	[[ -d "$1" ]] || return

	if ! echo "$PATH" | tr ":" "\n" | grep -qx "$1"; then
		export PATH="$PATH:$1"
	fi
}

function prepend_path() {
	[[ -d "$1" ]] || return

	if ! echo "$PATH" | tr ":" "\n" | grep -qx "$1"; then
		export PATH="$1:$PATH"
	fi
}

function fixpath() {
	PATH=$(echo $(sed 's/:/\n/g' <<<$PATH | sort | uniq) | sed -e 's/\s/':'/g')
}

function source_file() {
  if [ -f "$1" ]; then
    source "$1"
  fi
}

function link() {
    orig_file="$DOTFILES/$1"
    if [ -n "$2" ]; then
        dest_file="$HOME/$2"
    else
        dest_file="$HOME/$1"
    fi

    mkdir -p "$(dirname "$orig_file")"
    mkdir -p "$(dirname "$dest_file")"

    rm -rf "$dest_file"
    ln -s "$orig_file" "$dest_file"
    echo "$dest_file -> $orig_file"
}


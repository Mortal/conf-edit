# SPDX-License-Identifier: MIT
conf-commit() {
	# Check arguments and environment
	case "x$1" in
		x|x-*)
			echo "Usage: conf-commit FILE"
			echo "Copy FILE to \$CONF_REPO and commit it with Git."
			echo "\$CONF_REPO = $CONF_REPO"
			return 1
			;;
	esac
	if [ "x$CONF_REPO" == "x" ]; then
		echo "conf-commit: Please set \$CONF_REPO in your .bashrc file or similar."
		return 1
	fi
	if ! [ -e "$CONF_REPO/.git" ]; then
		echo "conf-commit: \$CONF_REPO does not appear to be a git repository."
		echo "\$CONF_REPO = $CONF_REPO"
		return 1
	fi

	# Arguments and environment ok; commit file to repo
	path=`realpath -se "$1"` || return 1
	mkdir -p "`dirname "$CONF_REPO$path"`"
	cp -a "$path" "$CONF_REPO$path"
	(
		cd "$CONF_REPO"
		git add ."$path"
		git commit -qm "Update $path" ."$path"
	)
	return 0
}

conf-edit() {
	# Check arguments and environment
	case "x$1" in
		x|x-*)
			echo "Usage: conf-edit FILE"
			echo "Edit FILE with \$EDITOR and record changes in \$CONF_REPO."
			echo "\$EDITOR = $EDITOR"
			echo "\$CONF_REPO = $CONF_REPO"
			return 1
			;;
	esac
	if [ "x$EDITOR" == "x" ]; then
		echo "conf-edit: Please set \$EDITOR in your .bashrc file or similar."
		return 1
	fi
	case "x$CONF_REPO" in
		x)
			echo "conf-edit: Please set \$CONF_REPO in your .bashrc file or similar."
			return 1
			;;
		*/)
			echo "conf-edit: \$CONF_REPO must not end with trailing slash. Aborting."
			return 1
			;;
	esac
	if ! [ -e "$CONF_REPO/.git" ]; then
		echo "conf-edit: \$CONF_REPO does not appear to be a git repository."
		echo "\$CONF_REPO = $CONF_REPO"
		return 1
	fi

	# Arguments and environment ok; commit, edit, and commit the file
	if [ -e "$1" ]; then conf-commit "$1" || return; fi
	if [ -w "$1" -o -w "`dirname "$1"`" ]; then "$EDITOR" "$1"; else sudo "$EDITOR" "$1"; fi || return
	[ -e "$1" ] && conf-commit "$1"
}

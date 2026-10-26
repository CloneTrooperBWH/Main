file="banlist.txt"

format() {
	file="$1"
	sed -i '/^11_Steve_11 /d' "$file"
	sort -u "$file" -o "$file"
}

add() {
	line=""
	if [ $# -eq 1 ]; then
		line="$1"
	elif [ $# -eq 3 ]; then
		line="$1 $2 $3"
	fi

	if grep -q "^$(echo "$line" | cut -d' ' -f1) " "$file"; then
		echo "NAAAAH! Player already banned"
		return 1
	else
		echo "$line" >> "$file"
	fi
}

info(){
	line="$1"
	if grep -q "^$line " "$file"; then
		grep "^$line " "$file"
	else 
		echo "NAAAAAAAAAAH! No such player"
	fi
}

remove(){
	line="$1"
	sed -i "/^$line /d" "$file"
}

sorta() {
	mode="$1"
	to="$2"
	case "$mode" in
		--name)
			sort -k1,1 "$file" -o "$to"
			;;
		--time)
			sort -k2,2 "$file" -o "$to"
			;;
	esac
}

case "$1" in
	format)
		format "$2"
		;;
	add)
		shift
		add "$@"
		;;
	info)
		info "$2"
		;;
	remove)
		remove "$2"
		;;
	sort)
		sorta "$2" "$3"
		;;
esac















#this is fun, but painful

lockfile="report.lock"
outfile="report.txt"

help(){
	echo "General script info:"
	echo "Daily server report"
	echo "Script options:"
	echo "-p file_name | --players filename | List of registered players"
	echo "-b file_name | --banlist filename | List of banned players"
	echo "-t file_name | --transactions filename | The most popular trade item"
}

while [[ $# -gt 0 ]]; do
	case "$1" in
		-h|--help) help; exit 0;;
		-p|--players) playerfile="$2"; shift 2;;
		-b|--banlist) banfile="$2"; shift 2;;
		-t|--transactions) transfile="$2"; shift 2;;
		esac
done

if ! ( set -o noclobber; > "$lockfile" ) 2>/dev/null; then
    echo "Report in progress" >&2
    exit 1
fi

interrupted(){
	echo
        echo "Reporting was interrupted" >&2
        rm -f "$lockfile" "$outfile"
        exit 1
}
trap interrupted SIGINT SIGTERM

sleep 5

players=$(grep -cve '^[[:space:]]*$' "$playerfile")
bans=$(grep -cve '^[[:space:]]*$' "$banfile")
trans=$(grep -cve '^[[:space:]]*$' "$transfile")

bestitem=$(awk '{print $3}' "$transfile" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')
cat <<EOF > "$outfile"
StarCraft server report

Players: $players
Bans: $bans
Transactions: $trans
Top item: ${bestitem:-N/A}
EOF

trap - SIGINT SIGTERM
rm -f "$lockfile"
exit 0

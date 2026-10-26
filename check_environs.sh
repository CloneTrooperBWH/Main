file="server.conf"

if [ -z "$SERVER_NAME" ]; then
	SERVER_NAME="StarCraft"
fi


if [ -z "$MAX_PLAYERS" ]; then
	MAX_PLAYERS="125"
fi


if [ -z "$SPAWN_COORDS" ]; then
	SPAWN_COORDS="274 67 -249"
fi
echo "SERVER_NAME=\"$SERVER_NAME\"" > "$file"
echo "MAX_PLAYERS=$MAX_PLAYERS" >> "$file"
echo "SPAWN_COORDS=\"$SPAWN_COORDS\"" >> "$file"

cat $file
#Созрел вопрос, тут опечатка или реально надо COORDS писать...

#!/bin/sh

FILE=${1?no filename given}
MIME_TYPE=${2:-application/octet-stream}
PORT=${PORT:-9999}
FILENAME=$(basename "$FILE")
FILESIZE=$(ls -l "$FILE"  | awk '{print $5}')

echo "serving file '$FILE' with mimetype '$MIME_TYPE' on port $PORT..."

cat - "$FILE" <<END_HEADER |  nc -l -p $PORT
HTTP/1.1 200 OK
Content-Type: $MIME_TYPE
Content-Disposition: attachment; filename=$FILENAME
Content-Length: $FILESIZE

END_HEADER


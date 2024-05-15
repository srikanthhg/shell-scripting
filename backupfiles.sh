#!/bin/bash

TIMESTAMP=$(date +%F-%H-%M-%S)
SOURCE_DIR="/tmp/shellscript-logs/"
DEST_DIR=/tmp/backup

if [ -z "$(ls -A $SOURCE_DIR)" ]
then
echo "Directory: $SOURCE_DIR is empty"
exit 1
else
tar -cvzf "$DEST_DIR/backup-$TIMESTAMP.tar.gz" $SOURCE_DIR
fi

echo
echo "Backup has been completed"
echo
echo "Thank you!"



# -c : Create a new archive.
# -v : Verbose output.
# -f file.tar.gz : Use archive file.
# -z : Filter the archive through gzip.

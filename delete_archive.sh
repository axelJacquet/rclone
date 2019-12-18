#!/bin/sh
set -x
set -e
dest="$3"




usage () {
        echo "$0 --folders-to-backup <folder1>[,folder2,folder3,...]"
        exit 1
}
for i in $@ ; do
        case "${1}" in
        "--folders-to-backup"|"-f")
        echo $1
                if [ -z "${2}" ] ; then
                        echo "No parameter defining the --folder-to-backup parameter"
                        usage
                fi
                FOLDER_TO_BACKUP="${2}"
                shift
                shift
        ;;
        *)
        ;;
        esac
done

FOLDERS_TO_BACKUP=$(echo ${FOLDER_TO_BACKUP} | tr -d  ' ' )

FOLDERS_TO_BACKUP=$(echo ${FOLDER_TO_BACKUP} | tr  ',' ' ' )
for i in ${FOLDERS_TO_BACKUP}"" ; do





  eval "/usr/bin/rclone purge $dest:archive/$(hostname -a)\_$i/"


done

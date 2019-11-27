#!/bin/sh
set -e
dest="$3"

move_old_files_to="$4"

new="last_snapshot"
timestamp="$(date +%F_%T)"

usage () {
        echo "$0 --folders-to-backup <folder1>[,folder2,folder3,...]"
        exit 1
}
for i in $@ ; do
        case "${1}" in
        "--folders-to-backup"|"-f ")
                if [ -z "${2}" ] ; then
                        echo "No parameter defining the --folder-to-backup parameter"
                        usage
                fi
                FOLDER_TO_BACKUP=${2}
                shift
                shift
        ;;
        *)
        ;;
        esac
done


if [ "$move_old_files_to" = "dated_directory" ]; then
    # move deleted or changed files to archive/$(date +%Y)/$timestamp directory
    backup_dir="--backup-dir=$dest/archive/$(date +%Y)/$timestamp"
elif [ "$move_old_files_to" = "dated_files" ]; then
    # move deleted or changed files to old directory, and append _$timestamp to file name
    backup_dir="--backup-dir=$dest/old_files --suffix=_$timestamp"
elif [ "$move_old_files_to" != "" ]; then
    print_message "WARNING" "Parameter move_old_files_to=$move_old_files_to, but should be dated_directory or dated_files.\
  Moving old data to dated_directory."
    backup_dir="--backup-dir=$dest/$timestamp"
fi


FOLDERS_TO_BACKUP=$(echo ${FOLDER_TO_BACKUP} | tr ',' ' ')
for i in ${FOLDERS_TO_BACKUP}"" ; do



        echo "dddddddddddddddddddddd"
        eval "/usr/bin/rclone sync $i $dest/$new $backup_dir"

        #echo "$cmd"
done

#echo $dest
#echo $move_old_files_to

#!/bin/sh
set -x
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
#sudo rm -rf /test/backups/*
#sudo rm -rf /test/

#sudo mkdir /test/
#sudo mkdir /test/backups/

FOLDERS_TO_BACKUP=$(echo ${FOLDER_TO_BACKUP} | tr  ',' ' ' )
for i in ${FOLDERS_TO_BACKUP}"" ; do


  if [ "$move_old_files_to" = "dated_directory" ]; then
      # move deleted or changed files to archive/$(date +%Y)/$timestamp directory
      backup_dir="--backup-dir=$dest/archive/$(hostname -a)\_$i/$(date +%Y)/$timestamp"
  elif [ "$move_old_files_to" = "dated_files" ]; then
      # move deleted or changed files to old directory, and append _$timestamp to file name
      backup_dir="--backup-dir=$dest/old_files --suffix=_$timestamp"
  elif [ "$move_old_files_to" != "" ]; then
      print_message "WARNING" "Parameter move_old_files_to=$move_old_files_to, but should be dated_directory or dated_files.\
    Moving old data to dated_directory."
      backup_dir="--backup-dir=$dest/$timestamp"
  fi


  #sudo cp -r $i /test/backups/
  #ls= ls -la /pika/
  #echo $ls
  #eval "rclone sync /test/ $dest/$new $backup_dir --size-only"
  #eval "rclone copy /pika/ $dest/$new $backup_dir"
  #eval "rclone sync /pika/ $dest"




  eval "/usr/bin/rclone sync $i $dest/$(hostname -a)/$new\_$i $backup_dir"

        #echo "$cmd"
done

#echo $dest
#echo $move_old_files_to

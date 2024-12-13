function archive-folder
    set -l folder_name $argv[1]
    if test -z $folder_name
        echo "Missing folder to archive"
        return
    end
    
    set -l gzip_file "$folder_name-$(date +%Y-%m-%d).tar.gz"
    echo "gziping folder"
    tar -czf "$gzip_file" "$folder_name"
    read -ln1 --prompt-str "Delete folder $folder_name? [y/n] " delete_response

    if test $delete_response = "y" || test $delete_response = "Y"
        echo "Deleting $folder_name..."
        sleep 5
        rm -r "$folder_name"
    else
        echo "Skipping folder deletion"
        return
    end
end
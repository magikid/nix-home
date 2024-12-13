function add_old_gpg_key
    set -l url $argv[1]
    set -l key_name $argv[2]
    if test -z url
        echo "No url provided"
        return
    end

    if test -z key_name
        echo "No key name provided"
        return
    end
    
    curl $url | gpg --dearmor | sudo tee /usr/share/keyrings/$key_name.gpg > /dev/null
end
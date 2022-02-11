# Create a self-signed cert and key pem file
# By Mr.Red

read -r -p "Do you want to add a password on the private key? [y/N] " qdes
qdes=${qdes:-N}
case "$response" in
    [yY][eE][sS]|[yY]) 
	des=""
        ;;
    *)
	des="-nodes"
esac
read -p "How many bits should the keys have? [4096]" bits
bits=${bits:-4096}
read -p "Would you like to name the private key file? [key]" key_name
key_name=${key_name:-key}
read -p "Would you like to name the cert file? [cert]" cert_name
cert_name=${cert_name:-cert}
read -p "What duration should the lifetime be? [365]" lifetime
lifetime=${lifetime:-365}

openssl req $des -x509 -newkey rsa:$bits -keyout $key_name.pem -out $cert_name.pem -sha256 -days $lifetime

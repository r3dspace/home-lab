# Powershell script which creates a public and private key pair
# By r3dspace
# ---

$folder = "$env:USERPROFILE/.ssh"

# Checking if directory exists
# ---
Write-Host "Checking for .ssh folder in user profile..."
if (Test-Path -Path $folder) {
    Write-Host "Folder found!" -ForegroundColor Green
} else {
    # Create new directory if not found
    # ---
    Write-Host "Folder NOT found!"-ForegroundColor Red
    Write-Host "Creating .ssh folder in user profile..."
    New-Item -Path $env:USERPROFILE -Name ".ssh" -ItemType "directory"
    if (Test-Path -Path $folder) {
        Write-Host "Successfully created directory .ssh!" -ForegroundColor Green
    } else {
        Write-Host "Unable to create directory .ssh!" -ForegroundColor Red
        exit
    }
}

# Generate key pair
# ---
Write-Warning "Please save the key pair in the folder '.ssh' found in your user directory! (E.g: c:\users\mustermann)"
ssh-keygen -b 4096

# Uploads .pub file to target using scp
# ---
$fname = Read-Host "Enter the name of the public key file you have just created. (E.g: id_rsa.pub)"
$sshhost= Read-Host "Enter the ssh login adress for the target. (E.g: root@192.168.0.101)"
scp $folder/$fname ${sshhost}:~/.ssh/authorized_keys
pause
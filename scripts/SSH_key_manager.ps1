# Powershell script to manage your ssh keys.
# It can create generic or service compatible keys, aswell as manipulate existing ones.
# Other features include upload of public ssh key to hosts.
# By r3dspace
# ---

# Checking for .ssh directory in user folder
# ---
Write-Host "Checking for .ssh directory in user folder"
$folder = "$env:USERPROFILE/.ssh"

if (Test-Path -Path $folder) {
    Write-Host "SSH directory structure found"
} else {
    # Create new .ssh directory if not found
    # ---
    Write-Host "Unable to .ssh directory in user's home directory"
    Write-Host "Creating .ssh folder in user's home directory"
    New-Item -Path $env:USERPROFILE -Name ".ssh" -ItemType "directory"
    # Checking if .ssh directory was created successfully
    # ---
    if (Test-Path -Path $folder) {
        Write-Host "SSH directory structure created successfully"
    } else {
        Write-Host "Unable to create SSH directory structure" -ForegroundColor Red
        exit
    }
}

# Main menu Visuals
# ---
function Get-mainMenuVis {
    cls
    Write-Host " ___ ___ _  _   _  __                                                " -ForegroundColor Cyan
    Write-Host "/ __/ __| || | | |/ /___ _  _   _ __  __ _ _ _  __ _ __ _ ___ _ _ " -ForegroundColor Cyan
    Write-Host "\__ \__ \ __ | | ' </ -_) || \ | '  \/ _`  | ' \/ _`  / _`  / -_) '_|" -ForegroundColor Cyan
    Write-Host "|___/___/_||_| |_|\_\___|\_, / |_|_|_\__,_|_||_\__,_\__, \___|_|  " -ForegroundColor Cyan
    Write-Host "                         |__/                       |___/             " -ForegroundColor Cyan
    Write-Host "By r3dspace" -ForegroundColor DarkCyan
    Write-Host "Version: 1.0.0" -ForegroundColor DarkCyan
    Write-Host ""
    Write-Host "1. Generate generic ssh keys"
    Write-Host "2. Generate GitHub ssh keys"
    Write-Host "3. Upload public key to host"
    Write-Host "4. Change private key password"
    Write-Host ""
    Write-Host "q. Quit"
    Write-Host ""
}

# Main menu
# ---
function Get-mainMenu {
    cls
    Get-mainMenuVis

    while (($input = Read-Host "Choose an option") -notmatch "^1$|^2$|^3$|^4$|^Q$") {
        Write-Host "Input not recognised" -ForegroundColor Red
        Start-Sleep -Milliseconds 1300
        Get-mainMenu
    }
    if ($input -match "[qQ]") {
        exit
    } elseif ($input -eq 1) {
        Get-sshKeyGen
    } elseif ($input -eq 2) {
        Get-sshGitKey
    } elseif ($input -eq 3) {
        Get-sshKeyUpl
    } elseif ($input -eq 4) {
        Get-sshKeyPW
    } else {
        Write-Host "Error" -ForegroundColor Red
    }
}

# Generate ssh key pair
# ---
function Get-sshKeyGen {
    cls
    Write-Host "# Creating a ssh key pair" -ForegroundColor Cyan
    Write-Host "# ---" -ForegroundColor Cyan
    $keyName = Read-Host "Key name (default id_rsa)"
    $keyPW = Read-Host "Key password (leave empty for no password)"
    $folder = Read-Host "Key location (default C:\Users\USERNAME\.ssh)"

    if ($keyName -eq "" -and $keyName -eq [String]::Empty) {
        $keyName = "id_rsa"
    }
    if ($keyPW -eq "" -and $keyPW -eq [String]::Empty) {
        $keyPW = '""'
    }
    if ($folder -eq "" -and $folder -eq [String]::Empty) {
        $folder = "$env:USERPROFILE\.ssh"
    }

    # Check input data, before creating ssh key pair
    # ---
    Write-Host "# Key summary" -ForegroundColor Cyan
    Write-Host "# ---" -ForegroundColor Cyan
    Write-Host "Key name: $keyName" -ForegroundColor Magenta
    Write-Host "Key password: $keyPW" -ForegroundColor Magenta
    Write-Host "Key location: $folder" -ForegroundColor Magenta

    while (($input = Read-Host "Is the data above correct? [y/n]") -notmatch "^Y$|^N$") {
        Write-Host "Input not recognised" -ForegroundColor Red
    }
    if ($input -match "[nN]") {
        Get-mainMenu
    }

    # Generating ssh key pair
    # ---
    ssh-keygen -f $folder\$keyName -t rsa -N $keyPW -b 4096

    # Double check if ssh keys where generated
    # ---
    if (Test-Path -Path $folder\$keyName -PathType Leaf) {
        Write-Host ""
        Write-Host "Creation completed" -ForegroundColor Green
        Start-Sleep -Milliseconds 3
        Get-mainMenu
    } else {
        Write-Host "Error! Unable to locat ssh keys, after creation"
        Pause
        Get-mainMenu
    }
}

# Generate GitHub compatible ssh keys
# ---
function Get-sshGitKey {
    cls
    Write-Host "# Creating a GitHub compatible ssh key pair" -ForegroundColor Cyan
    Write-Host "# ---" -ForegroundColor Cyan
    $keyName = Read-Host "Key name (default id_rsa)"
    $keyPW = Read-Host "Key password (leave empty for no password)"
    $gitMail = Read-Host "GitHub mail (required)"
    $folder = Read-Host "Key location (default C:\Users\USERNAME\.ssh)"


    if ($keyName -eq "" -and $keyName -eq [String]::Empty) {
        $keyName = "id_rsa"
    }
    if ($keyPW -eq "" -and $keyPW -eq [String]::Empty) {
        $keyPW = '""'
    }
    if ($folder -eq "" -and $folder -eq [String]::Empty) {
        $folder = "$env:USERPROFILE\.ssh"
    }

    # Check input data, before generating ssh key pair
    # ---
    Write-Host "# Upload summary" -ForegroundColor Cyan
    Write-Host "# ---" -ForegroundColor Cyan
    Write-Host "Key name: $keyName" -ForegroundColor Magenta
    Write-Host "Key password: $keyPW" -ForegroundColor Magenta
    Write-Host "GitHub: $gitMail" -ForegroundColor Magenta
    Write-Host "Key location: $folder" -ForegroundColor Magenta

    while (($input = Read-Host "Is the data above correct? [y/n]") -notmatch "^Y$|^N$") {
        Write-Host "Input not recognised" -ForegroundColor Red
    }
    if ($input -match "[nN]") {
        Get-mainMenu
    }

    # Create GitHub compatible ssh key pair
    # ---
    ssh-keygen -f $folder\$keyName -t rsa -N $keyPW -b 4096 -C $gitMail

    # Double check if ssh keys where generated
    # ---
    if (Test-Path -Path $folder\$keyName -PathType Leaf) {
        Write-Host ""
        Write-Host "Creation completed" -ForegroundColor Green
        Start-Sleep -Milliseconds 3
        Get-mainMenu
    } else {
        Write-Host "Error! Unable to locat ssh keys, after creation"
        Pause
        Get-mainMenu
    }
}

# Uploads .pub file to target using scp
# ---
function Get-sshKeyUpl {
    cls
    Write-Host "# Upload public ssh key" -ForegroundColor Cyan
    Write-Host "# ---" -ForegroundColor Cyan
    $hostUname = Read-Host "Host username (default root)"
    $hostIP = Read-Host "Host IP"
    $hostPort = Read-Host "Host Port (default 22)"
    $keyName = Read-Host "Key name (default id_rsa.pub)"
    $folder = Read-Host "Key location (default C:\Users\USERNAME\.ssh)"

    if ($hostUname -eq "" -and $hostUname -eq [String]::Empty) {
        $hostUname = "root"
    }
    if ($hostPort -eq "" -and $hostPort -eq [String]::Empty) {
        $hostPort = "22"
    }
    if ($keyName -eq "" -and $keyName -eq [String]::Empty) {
        $keyName = "id_rsa.pub"
    }
    if ($folder -eq "" -and $folder -eq [String]::Empty) {
        $folder = "$env:USERPROFILE\.ssh"
    }

    # Check input data, before public ssh key upload
    # ---
    Write-Host "# Upload summary" -ForegroundColor Cyan
    Write-Host "# ---" -ForegroundColor Cyan
    Write-Host "Host username: $hostUname" -ForegroundColor Magenta
    Write-Host "Host IP: $hostIP" -ForegroundColor Magenta
    Write-Host "Host Port: $hostPort" -ForegroundColor Magenta
    Write-Host "Key name: $keyName" -ForegroundColor Magenta
    Write-Host "Key location: $folder" -ForegroundColor Magenta

    while (($input = Read-Host "Is the data above correct? [y/n]") -notmatch "^Y$|^N$") {
        Write-Host "Input not recognised" -ForegroundColor Red
    }
    if ($input -match "[nN]") {
        Get-mainMenu
    }

    # Upload public ssh key
    # ---
    scp -P $hostPort $folder/$keyName ${hostUname}@${hostIP}:~/.ssh/authorized_keys

    Write-Host ""
    Write-Host "Upload completed" -ForegroundColor Green
    Start-Sleep -Milliseconds 3
    Get-mainMenu
}

# Changing private ssh key passphrase
# ---
function Get-sshKeyPW {
    cls
    Write-Host "# Change private key password" -ForegroundColor Cyan
    Write-Host "# ---" -ForegroundColor Cyan
    $keyName = Read-Host "Key name (default id_rsa)"
    $folder = Read-Host "Key location (default C:\Users\USERNAME\.ssh)"

    if ($keyName -eq "" -and $keyName -eq [String]::Empty) {
        $keyName = "id_rsa"
    }
    if ($folder -eq "" -and $folder -eq [String]::Empty) {
        $folder = "$env:USERPROFILE\.ssh"
    }

    # Check input data, before changing private ssh key passphrase
    # ---
    Write-Host "# Upload summary" -ForegroundColor Cyan
    Write-Host "# ---" -ForegroundColor Cyan
    Write-Host "Key name: $keyName" -ForegroundColor Magenta
    Write-Host "Key location: $folder" -ForegroundColor Magenta

    while (($input = Read-Host "Is the data above correct? [y/n]") -notmatch "^Y$|^N$") {
        Write-Host "Input not recognised" -ForegroundColor Red
    }
    if ($input -match "[nN]") {
        Get-mainMenu
    }

    # Convertion of private ssh key passphrase
    # ---
    ssh-keygen -f "$folder\$keyName" -p

    Write-Host ""
    Write-Host "Convertion completed" -ForegroundColor Green
    Start-Sleep -Milliseconds 3
    Get-mainMenu
}

# Start main script
# ---
Get-mainMenu
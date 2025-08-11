# VirtualBox CLI Commands

## VBoxManage - Main Command Line Interface

### Virtual Machine Management

```bash
# List all virtual machines
VBoxManage list vms                    # List all VMs
VBoxManage list runningvms             # List only running VMs
VBoxManage list ostypes                # List supported guest OS types

# Create new virtual machine
VBoxManage createvm --name "VM_Name" --ostype "Ubuntu_64" --register
VBoxManage createvm --name "Windows10" --ostype "Windows10_64" --register

# Start virtual machine
VBoxManage startvm "VM_Name"           # Start with GUI
VBoxManage startvm "VM_Name" --type headless  # Start without GUI
VBoxManage startvm "VM_Name" --type gui       # Start with GUI (explicit)

# Control running virtual machine
VBoxManage controlvm "VM_Name" pause          # Pause VM
VBoxManage controlvm "VM_Name" resume         # Resume VM
VBoxManage controlvm "VM_Name" reset          # Reset VM
VBoxManage controlvm "VM_Name" poweroff       # Power off VM
VBoxManage controlvm "VM_Name" savestate      # Save state and stop
VBoxManage controlvm "VM_Name" acpipowerbutton # Send ACPI shutdown

# Delete virtual machine
VBoxManage unregistervm "VM_Name" --delete    # Remove VM and delete files
VBoxManage unregistervm "VM_Name"             # Remove VM but keep files
```

### VM Configuration

```bash
# Modify VM settings
VBoxManage modifyvm "VM_Name" --memory 2048           # Set RAM to 2GB
VBoxManage modifyvm "VM_Name" --cpus 2                # Set CPU count
VBoxManage modifyvm "VM_Name" --vram 128              # Set video memory
VBoxManage modifyvm "VM_Name" --boot1 dvd --boot2 disk # Set boot order

# Network settings
VBoxManage modifyvm "VM_Name" --nic1 nat              # NAT network
VBoxManage modifyvm "VM_Name" --nic1 bridged --bridgeadapter1 eth0
VBoxManage modifyvm "VM_Name" --nic1 hostonly --hostonlyadapter1 vboxnet0
VBoxManage modifyvm "VM_Name" --nic1 intnet --intnet1 "internal_network"

# Enable/disable features
VBoxManage modifyvm "VM_Name" --ioapic on             # Enable IOAPIC
VBoxManage modifyvm "VM_Name" --pae on                # Enable PAE
VBoxManage modifyvm "VM_Name" --hwvirtex on           # Enable hardware virtualization
VBoxManage modifyvm "VM_Name" --nestedpaging on       # Enable nested paging
VBoxManage modifyvm "VM_Name" --clipboard bidirectional # Enable clipboard sharing
VBoxManage modifyvm "VM_Name" --draganddrop bidirectional # Enable drag & drop
```

### Storage Management

```bash
# Create hard disk
VBoxManage createhd --filename "/path/to/disk.vdi" --size 20480  # 20GB VDI
VBoxManage createhd --filename "/path/to/disk.vmdk" --size 20480 --format VMDK
VBoxManage createhd --filename "/path/to/disk.vhd" --size 20480 --format VHD

# Attach storage to VM
VBoxManage storagectl "VM_Name" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "VM_Name" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "/path/to/disk.vdi"

# Attach ISO/DVD
VBoxManage storageattach "VM_Name" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "/path/to/iso/file.iso"
VBoxManage storageattach "VM_Name" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium emptydrive

# List attached media
VBoxManage showvminfo "VM_Name" --machinereadable | grep -i storage
VBoxManage list hdds                   # List all hard disks
VBoxManage list dvds                   # List all DVD images
```

### Snapshot Management

```bash
# Create snapshot
VBoxManage snapshot "VM_Name" take "Snapshot_Name" --description "Snapshot description"

# List snapshots
VBoxManage snapshot "VM_Name" list

# Restore snapshot
VBoxManage snapshot "VM_Name" restore "Snapshot_Name"

# Delete snapshot
VBoxManage snapshot "VM_Name" delete "Snapshot_Name"

# Show snapshot information
VBoxManage snapshot "VM_Name" showvminfo "Snapshot_Name"
```

### VM Information and Monitoring

```bash
# Show VM information
VBoxManage showvminfo "VM_Name"               # Detailed VM info
VBoxManage showvminfo "VM_Name" --machinereadable  # Machine-readable format

# Monitor VM metrics
VBoxManage metrics list                       # List available metrics
VBoxManage metrics query "VM_Name" CPU/Load/User,CPU/Load/Kernel
VBoxManage metrics collect --period 1 --samples 5 "VM_Name" CPU/Load/User

# Get VM properties
VBoxManage getextradata "VM_Name" enumerate   # List all extra data
VBoxManage getextradata "VM_Name" "property_name"
VBoxManage setextradata "VM_Name" "property_name" "value"
```

### Guest Additions and Guest Control

```bash
# Insert Guest Additions CD
VBoxManage storageattach "VM_Name" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium additions

# Guest control (requires Guest Additions)
VBoxManage guestcontrol "VM_Name" run --exe "/bin/ls" --username user --password pass
VBoxManage guestcontrol "VM_Name" copyto --source "/host/file" --target "/guest/file" --username user --password pass
VBoxManage guestcontrol "VM_Name" copyfrom --source "/guest/file" --target "/host/file" --username user --password pass

# Guest properties
VBoxManage guestproperty get "VM_Name" "/VirtualBox/GuestInfo/OS/Product"
VBoxManage guestproperty set "VM_Name" "property_name" "value"
VBoxManage guestproperty enumerate "VM_Name"
```

### Host-Only Network Management

```bash
# Create host-only network
VBoxManage hostonlyif create               # Creates vboxnet0, vboxnet1, etc.

# Configure host-only network
VBoxManage hostonlyif ipconfig vboxnet0 --ip 192.168.56.1 --netmask 255.255.255.0

# Remove host-only network
VBoxManage hostonlyif remove vboxnet0

# List host-only networks
VBoxManage list hostonlyifs
```

### Extension Pack Management

```bash
# Install extension pack
VBoxManage extpack install "/path/to/Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack"

# List installed extension packs
VBoxManage list extpacks

# Uninstall extension pack
VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"

# Update extension pack
VBoxManage extpack install "/path/to/new_extension_pack.vbox-extpack" --replace
```

### Import/Export VMs

```bash
# Export VM to OVF/OVA
VBoxManage export "VM_Name" --output "/path/to/export.ova"
VBoxManage export "VM_Name" --output "/path/to/export.ovf" --vsys 0 --product "Product Name"

# Import VM from OVF/OVA
VBoxManage import "/path/to/file.ova"
VBoxManage import "/path/to/file.ovf" --vsys 0 --vmname "New_VM_Name"

# List import options
VBoxManage import "/path/to/file.ova" --dry-run
```

### Cloning VMs

```bash
# Clone VM
VBoxManage clonevm "Source_VM" --name "Cloned_VM" --register
VBoxManage clonevm "Source_VM" --name "Cloned_VM" --mode machine --register  # Clone everything
VBoxManage clonevm "Source_VM" --name "Cloned_VM" --mode machineandchildren --register  # Include snapshots

# Linked clone (requires snapshot)
VBoxManage clonevm "Source_VM" --snapshot "Snapshot_Name" --name "Linked_Clone" --options link --register
```

## VirtualBox GUI Application

```bash
# Start VirtualBox Manager GUI
virtualbox                             # Start GUI
VirtualBox                             # Alternative command

# Start specific VM with GUI
virtualbox --startvm "VM_Name"

# Start VM in fullscreen
virtualbox --startvm "VM_Name" --fullscreen

# Start with specific display resolution
virtualbox --startvm "VM_Name" --separate
```

## VirtualBox Web Service

```bash
# Start VirtualBox web service
vboxwebsrv --host 0.0.0.0 --port 18083 --authentication null

# Start as daemon
vboxwebsrv --background --pid /var/run/vboxwebsrv.pid

# Stop web service
kill $(cat /var/run/vboxwebsrv.pid)
```

## Useful VirtualBox Aliases

```bash
# Add to .zshrc or .bashrc
alias vbox='virtualbox'
alias vbm='VBoxManage'
alias vblist='VBoxManage list vms'
alias vbrunning='VBoxManage list runningvms'
alias vbstart='VBoxManage startvm'
alias vbstop='VBoxManage controlvm'
alias vbinfo='VBoxManage showvminfo'

# Functions for common tasks
vbcreate() {
    VBoxManage createvm --name "$1" --ostype "Ubuntu_64" --register
    VBoxManage modifyvm "$1" --memory 2048 --cpus 2 --vram 128
    VBoxManage createhd --filename "$HOME/VirtualBox VMs/$1/$1.vdi" --size 20480
    VBoxManage storagectl "$1" --name "SATA Controller" --add sata --controller IntelAhci
    VBoxManage storageattach "$1" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$1/$1.vdi"
}

vbquickstart() {
    VBoxManage startvm "$1" --type headless
}
```

## Common VM Templates

```bash
# Ubuntu Server template
create_ubuntu_server() {
    VM_NAME="$1"
    VBoxManage createvm --name "$VM_NAME" --ostype "Ubuntu_64" --register
    VBoxManage modifyvm "$VM_NAME" --memory 2048 --cpus 2 --vram 16
    VBoxManage modifyvm "$VM_NAME" --nic1 nat --nictype1 82540EM
    VBoxManage modifyvm "$VM_NAME" --boot1 dvd --boot2 disk --boot3 none --boot4 none
    VBoxManage createhd --filename "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi" --size 20480
    VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
    VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi"
    VBoxManage storagectl "$VM_NAME" --name "IDE Controller" --add ide
}

# Windows template
create_windows_vm() {
    VM_NAME="$1"
    VBoxManage createvm --name "$VM_NAME" --ostype "Windows10_64" --register
    VBoxManage modifyvm "$VM_NAME" --memory 4096 --cpus 2 --vram 128
    VBoxManage modifyvm "$VM_NAME" --nic1 nat --nictype1 82540EM
    VBoxManage modifyvm "$VM_NAME" --clipboard bidirectional --draganddrop bidirectional
    VBoxManage createhd --filename "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi" --size 51200
    VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
    VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi"
    VBoxManage storagectl "$VM_NAME" --name "IDE Controller" --add ide
}
```

## Troubleshooting Commands

```bash
# Check VirtualBox installation
VBoxManage --version                   # Check version
VBoxManage list systemproperties       # System properties

# Debug VM issues
VBoxManage debugvm "VM_Name" info      # Debug information
VBoxManage debugvm "VM_Name" log --release  # Get debug logs

# Check host information
VBoxManage list hostinfo               # Host system info
VBoxManage list hostcpuids             # Host CPU information

# Network troubleshooting
VBoxManage list natnets                # List NAT networks
VBoxManage list dhcpservers            # List DHCP servers

# Fix common issues
VBoxManage controlvm "VM_Name" poweroff  # Force stop unresponsive VM
sudo /sbin/vboxconfig                     # Reconfigure VirtualBox kernel modules
sudo usermod -aG vboxusers $USER         # Add user to vboxusers group
```
$env:VAGRANT_EXPERIMENTAL="disks"
$env:ARCHI3_VM_NAME="arch-i3"
$env:ARCHI3_VM_VERSION="1.4"

vagrant up
vagrant package

vagrant cloud publish -r --no-private adisadi/$env:ARCHI3_VM_NAME $env:ARCHI3_VM_VERSION virtualbox .\package.box

vagrant destroy -f
rm ./package.box
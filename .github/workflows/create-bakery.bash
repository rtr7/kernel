#!/bin/bash

set -eu

mkdir -p ~/gokrazy
mkdir ~/gokrazy/bakery || { echo 'bakery already exists' >&2; exit 1; }
cat > ~/gokrazy/bakery/config.json <<EOT
{
    "Hostname": "gokr-boot-will-inject-the-hostname",
    "Update": {
        "HTTPPassword": "${GOKRAZY_BAKERY_PASSWORD}"
    },
    "Packages": [
        "github.com/gokrazy/breakglass",
        "github.com/gokrazy/bakery/cmd/bake",
        "github.com/gokrazy/timestamps",
        "github.com/gokrazy/serial-busybox",
        "github.com/gokrazy/wifi"
    ],
    "PackageConfig": {
        "github.com/gokrazy/breakglass": {
            "CommandLineFlags": [
                "-authorized_keys=/etc/breakglass.authorized_keys"
            ],
            "ExtraFileContents": {
                "/etc/breakglass.authorized_keys": "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGSGdjns3/K3vwrQvwtvEMruFIqDtV//CHWVLUm4XNt michael@midna"
            }
        }
    },
    "SerialConsole": "ttyS0,115200n8",
    "KernelPackage": "github.com/rtr7/kernel",
    "FirmwarePackage": "github.com/rtr7/kernel",
    "EEPROMPackage": ""
}
EOT

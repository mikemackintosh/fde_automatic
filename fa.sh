#!/bin/bash

# Clear Out User Array
USERARRAY='';

# Grab The Last REAL User
LAST_USER=$(dscl . list /Users |tail -1)

# Create our User Array Loop for All Local Accounts
for i in $(dscl . list /Users GeneratedUID | grep -v FFFFEEEE |grep -v $LAST_USER | awk '{print $1}'); do 
  USERARRAY="${USERARRAY} -adduser $i"; 
done; 

# Sync FDE Setup
fdesetup sync

# Enable For All Discovered Users
fdesetup enable \
    -user $LAST_USER \
    $USERARRAY \
    -keychain /Library/Keychains/FileVaultMaster.keychain \
    -verbose \
    -norecoverykey \
    -defer /var/root/fdesetup_output.plist \
    -forcerestart

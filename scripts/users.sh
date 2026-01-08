#!/usr/bin/env bash

# Install sudo first
chroot /mnt/gentoo emerge app-admin/sudo

echo "-------------------------------------"
echo "Set ROOT password:"
chroot /mnt/gentoo passwd

echo "-------------------------------------"
read -p "Enter new username: " NEWUSER

if [[ -n "$NEWUSER" ]]; then
    chroot /mnt/gentoo useradd -m -G users,wheel,audio,video,input -s /bin/bash "$NEWUSER"
    
    echo "Set password for $NEWUSER:"
    chroot /mnt/gentoo passwd "$NEWUSER"
    
    # Uncomment %wheel in sudoers
    chroot /mnt/gentoo sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
    
    echo "User $NEWUSER created and added to sudoers."
else
    echo "No username provided. Skipping user creation."
fi

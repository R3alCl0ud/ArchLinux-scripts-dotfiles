import archinstall

archdrives = archinstall.all_disks()
print(f"Please select a drive: 0 - {len(archdrives)}")
i = 0
drives = []
for drive in archdrives:
    print(f"{i}: {drive}")
    drives.append(drive)
    i += 1
selected_drive = drives[int(input())]
print(f"Installing on the drive \"{selected_drive}\"")

mode = archinstall.GPT
fs = archinstall.Filesystem(selected_drive, mode)
make

qemu-system-i386 -fda build/main_floppy.img

echo
echo "------------------------------------------------------------------------------------------------------------------"
printf "\nPrinting from the C Program after quitting qemu\n\n"
./build/tools/fat build/main_floppy.img "TEST    TXT"
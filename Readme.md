# Alohomora OS — Unlocking the World of Operating Systems

Alohomora OS is a from-scratch operating system project built to deeply understand how operating systems function at the lowest level — from bootloading to file system interaction.

This project focuses on core OS fundamentals including bootloader implementation, interrupt handling, memory mapping, and direct interaction with the FAT file system.

---

## Project Objective

The purpose of this project was not just to build a minimal OS, but to thoroughly understand:

- How a system boots from real mode
- How BIOS transfers control to a bootloader
- How interrupts are handled at the hardware level
- How physical memory is mapped into accessible address space
- How file systems communicate directly with hardware
- How high-level C integrates with low-level Assembly

---

## Tech Stack & Tools

- x86 Assembly  
- C (for FAT driver development)  
- Makefile  
- Shell Scripting  
- QEMU (virtualization and testing)  
- FAT12 File System  

---

## What This Project Demonstrates

- Strong understanding of Operating System fundamentals  
- Low-level systems programming expertise  
- Practical Assembly programming skills  
- In-depth knowledge of FAT file systems  
- Understanding of hardware-software interaction  
- Experience debugging and testing system-level software using virtualization  

---

## Core Concepts Implemented

### Bootloader Development
- Implemented a custom bootloader in Assembly.
- Understood the complete boot sequence and execution flow from BIOS to OS.
- Explored how additional drives are mounted during the boot process.
- Gained a thorough understanding of OS fundamentals required during boot initialization.

### Interrupt Handling
- Worked with system interrupts at the hardware level.
- Understood interrupt vectors and low-level control transfer mechanisms.
- Learned how data is passed and functions are handled in Assembly.

### Memory Mapping
- Studied how physical memory is mapped into virtual memory space.
- Understood real-mode memory addressing and layout.
- Explored how the system manages memory at the hardware level.

### FAT File System Internals
- Analyzed FAT headers and file allocation table structures.
- Worked directly with FAT systems to perform read operations.
- Built a FAT driver in C to read data from a mounted floppy disk.
- Understood how the OS communicates with physical storage devices.
- Explored how file system metadata and cluster chains are structured and accessed.

### Low-Level & High-Level Integration
- Integrated Assembly and C to build functional OS components.
- Understood how high-level C functions are translated and executed at the low-level.
- Gained hands-on experience bridging high-level logic with direct hardware operations.


---

## Running the OS

Build the project:

### Using Shell command
```bash
./run.sh
```

### Regular commands (if shell throws errors)

Run the Make file:
```bash
make
```

Run using QEMU:

```bash
qemu-system-i386 -fda build/floppy.img
```

Run the Image with C Driver:
s
```bash
./build/tools/fat build/main_floppy.img "TEST    TXT"
````


---

## Final Reflection

Developing Alohomora OS provided an intuitive and practical understanding of how an operating system is structured internally. From bootloader execution to mounting drives and interacting directly with the FAT file system, the project required a deep understanding of OS fundamentals.

This project represents not just implementation, but a comprehensive exploration of how software communicates with hardware at the lowest level.

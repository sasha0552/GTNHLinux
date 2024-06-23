# GTNHLinux

Ansible:
```yml
- name: Configure GTNH Client
  become: yes
  hosts: client

  tasks:
    - name: Create swap in zram
      shell:
        creates: /tmp/.zram_swap_created

        cmd: |
          # Exit on error
          set -e

          # Load module
          modprobe zram

          # Allocate ram
          zramctl /dev/zram0 --algorithm zstd --size 2G

          # Create swap
          mkswap -U clear /dev/zram0

          # Enable swap
          swapon --priority 100 /dev/zram0

          # Create state file
          touch /tmp/.zram_swap_created

    - name: Wait for X server
      wait_for:
        path: /tmp/.X11-unix/X0

    - name: Change display mode of output
      shell: DISPLAY=:0 xrandr --output Virtual-1 --mode 1920x1080
```

# GTNHLinux

Login/password: `user:user`

Ansible:
```yml
- name: Configure GTNH Client
  become: yes
  hosts: client

  tasks:
    - name: Create directory
      file:
        path: /home/user/.local/share/PrismLauncher
        state: directory

    - name: Mount partition
      mount:
        fstype: ext4
        path: /home/user/.local/share/PrismLauncher
        src: /dev/vda1
        state: mounted

    - name: Wait for X server
      wait_for:
        path: /tmp/.X11-unix/X0
        
    - name: Change display mode of output
      shell: DISPLAY=:0 xrandr --output Virtual-1 --mode 1920x1080
```

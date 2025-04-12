// Famicom Disk System Disk Card Shell
shell_width = 76;
shell_height = 71;
shell_thickness = 3;

module fds_shell() {
    // Main shell
    cube([shell_width, shell_height, shell_thickness], center = false);
    
    // Optional: Add features like the central hub hole or label recesses here
}

fds_shell();

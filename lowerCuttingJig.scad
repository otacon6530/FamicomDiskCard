// Famicom Disk Cutting Jig (2.8" disk)
// All dimensions in millimeters

disk_diameter = 71;
hub_hole_diameter = 11;
jig_thickness = 5;
jig_border = 10;
alignment_hole_diameter = 3;
alignment_hole_offset = 40;

// Lower half of the jig
module lower_jig() {
    difference() {
        // Outer block
        cube([disk_diameter + 2 * jig_border, disk_diameter + 2 * jig_border, jig_thickness], center=true);
        
        // Circular cutout for disk
        translate([0, 0, 0.5])
            cylinder(h = jig_thickness + 1, d = disk_diameter, center=true);
        
        // Center hole for hub
        translate([0, 0, 0.5])
            cylinder(h = jig_thickness + 1, d = hub_hole_diameter, center=true);

        // Peg alignment holes
        for (angle = [0, 90, 180, 270]) {
            translate([alignment_hole_offset * cos(angle), alignment_hole_offset * sin(angle), 0])
                cylinder(h = jig_thickness + 1, d = alignment_hole_diameter, center=true);
        }
    }
}

// Upper half (presses down, with holes for pegs)
module upper_jig() {
    difference() {
        cube([disk_diameter + 2 * jig_border, disk_diameter + 2 * jig_border, jig_thickness], center=true);

        // Optional shallow recess to prevent slipping
        translate([0, 0, -0.25])
            cylinder(h = 1, d = disk_diameter - 2, center=true);

        // Alignment peg holes
        for (angle = [0, 90, 180, 270]) {
            translate([alignment_hole_offset * cos(angle), alignment_hole_offset * sin(angle), 0])
                cylinder(h = jig_thickness + 1, d = alignment_hole_diameter, center=true);
        }
    }
}

// Render both
translate([0, 0, -jig_thickness - 1]) lower_jig();

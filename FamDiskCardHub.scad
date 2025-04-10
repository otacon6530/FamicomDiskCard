// Famicom Disk System - Accurate Circular Hub Insert

hub_radius = 6.8;     // 13.5 mm diameter
hub_thickness = 1;    // 1.5 thickness of insert

notch_radius = 1.75;    // radius of the rounded notch (7 mm diameter)
notch_offset_y = 5.2;  // vertical offset from center of hub to notch center

center_hole_radius = 2.8; // small center hole (3 mm diameter)

$fn = 100; // smoothness of round shapes

module hub_insert() {
    difference(){
    translate([0, 0, .45 ]) //hub_thickness]/2)
     cylinder(h = hub_thickness/10, r = 14.5, center = true);
    
        // Small round center hole
        cylinder(h = hub_thickness*3 + 1, r = center_hole_radius, center = true);
        translate([0, notch_offset_y, 0])
            cube([notch_radius,notch_radius,hub_thickness*3 + 1], center = true);
        translate([0, notch_offset_y-.2, 0])
            cylinder(h = hub_thickness + 1, r = notch_radius/2, center = true);
        translate([0, notch_offset_y+.2, 0])
            cylinder(h = hub_thickness + 1, r = notch_radius/2, center = true);    
    }
   
    difference() {
    translate([0, 0, hub_thickness])
    cylinder(h = hub_thickness, r = center_hole_radius+1, center = true);
        // Small round center hole
        cylinder(h = hub_thickness*3 + 1, r = center_hole_radius, center = true);
        // Upper bevel
        translate([0, 0, hub_thickness+.5])
        cylinder(h = hub_thickness + 1, r1 = 2, r2 = 5, center = true);
    }
    translate([0, -center_hole_radius-1.2, hub_thickness])
    cube([1,1,hub_thickness], center = true);
 
    difference() {
        // Main circular hub
        cylinder(h = hub_thickness, r = hub_radius, center = true);        

        // Rounded notch (cylinder cut into side)
        translate([0, notch_offset_y, 0])
            cube([notch_radius,notch_radius,hub_thickness + 1], center = true);
        translate([0, notch_offset_y-.2, 0])
            cylinder(h = hub_thickness + 1, r = notch_radius/2, center = true);
        translate([0, notch_offset_y+.2, 0])
            cylinder(h = hub_thickness + 1, r = notch_radius/2, center = true);

        // Small round center hole
        cylinder(h = hub_thickness + 1, r = center_hole_radius, center = true);
        
        // lower bevel
        translate([0, 0, -1.12])
        cylinder(h = hub_thickness + 1, r1 =5, r2 = 2, center = true);

    }
}

module sideA() {
    translate([0, 0, .45 ]) //hub_thickness]/2)
    cylinder(h = hub_thickness/10, r = 14.5, center = true);
    translate([50, 0, 0]){ 
    difference() {
        // Main circular hub
        cylinder(h = hub_thickness, r = hub_radius, center = true); 
 
        //Alignment notch
        translate([0, -center_hole_radius-1.2,0])
            cube([1.15,1.15,hub_thickness+1.15], center = true);
        // Rounded notch (cylinder cut into side)
        translate([0, notch_offset_y, 0])
            cube([notch_radius,notch_radius,hub_thickness + 1], center = true);
        translate([0, notch_offset_y-.2, 0])
            cylinder(h = hub_thickness + 1, r = notch_radius/2, center = true);
        translate([0, notch_offset_y+.2, 0])
            cylinder(h = hub_thickness + 1, r = notch_radius/2, center = true);
        
        //Center hole
        translate([0,0, 1])
        cylinder(h = hub_thickness*5, r = center_hole_radius+1.25, center = true);

        }
    }
}

// Render it
hub_insert();
sideA();

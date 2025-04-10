// Famicom Disk System - Accurate Circular Hub Insert

hub_radius = 6.8;
hub_thickness = 1;

notch_radius = 1.75;    // radius of the rounded notch
notch_offset_y = 5.2;  // vertical offset from center of hub to notch center

center_hole_radius = 2.8; // small center hole
$fn = 100; // smoothness of round shapes

module spacer(){
    translate([0, 30, -.2]){
    difference(){
        cylinder(h = 0.2, r = 14.5, center = true);
        hole();
        cylinder(h = hub_thickness*5, r = center_hole_radius+1.25, center = true);
    translate([0, -center_hole_radius-1.2, hub_thickness-1])
    cube([1.25,1.25,1], center = true);
        
    }
    
}
    
}

module hole(){
    // Rounded notch (cylinder cut into side)
        translate([0, notch_offset_y, 0])
            cube([notch_radius,notch_radius,hub_thickness + 1], center = true);
        translate([0, notch_offset_y-.2, 0])
            cylinder(h = hub_thickness + 1, r = notch_radius/2, center = true);
        translate([0, notch_offset_y+.2, 0])
            cylinder(h = hub_thickness + 1, r = notch_radius/2, center = true);

        // Small round center hole
        cylinder(h = hub_thickness + 1, r = center_hole_radius, center = true);
}

module sideB() {
    difference() {
        // Main circular hub
        cylinder(h = hub_thickness, r = hub_radius, center = true);  
        hole(); 
        
        translate([0, 0, -1.12])
        cylinder(h = hub_thickness + 1, r1 =5, r2 = 2, center = true);
        // lower bevel
        translate([0, 0, -2.25])
        cylinder(h = hub_thickness*5, r1 = 10, r2 = 2, center = true);
    }
   
    //Cylinder sticking out of top
    difference() {
    translate([0, 0, hub_thickness])
    cylinder(h = hub_thickness, r = center_hole_radius+1, center = true);
        // Small round center hole
        cylinder(h = hub_thickness*3 + 1, r = center_hole_radius, center = true);
        // Upper bevel
        translate([0, 0, hub_thickness+1.175])
        cylinder(h = hub_thickness + 1, r1 = 2, r2 = 10, center = true); 
    }
    translate([0, -center_hole_radius-1.2, hub_thickness])
    cube([1,1,hub_thickness], center = true);        
   
}

module sideA() {
    translate([25, 0, 0]){ 
    translate([0, 0, -.5])
    difference(){
        cylinder(h = 0.2, r = 14.5, center = true);
        hole();
        translate([0, 0, -hub_thickness])
        sideB();
        //Center hole
        translate([0,0, 1])
        cylinder(h = hub_thickness*5, r = center_hole_radius+1.25, center = true);
        translate([0,0, -1])
            sideB();
    }
    difference() {
        // Main circular hub
        cylinder(h = hub_thickness, r = hub_radius, center = true); 
        hole();
        
        //Center hole
        translate([0,0, 1])
        cylinder(h = hub_thickness*5, r = center_hole_radius+1.25, center = true);
        translate([0,0, -1])
            sideB();
        }
    
    }
}

spacer();

// Famicom Disk System - Accurate Circular Hub Insert

hub_radius = 6.8;
hub_thickness = 1.5;
baseHeight = 1.3;
filler_thickness = 0.5;
filler_radius = 14.5;
filler_guide_offset=2.25;
filler_guide=5.5;
squarekey = 1;

notch_radius = .9;    // radius of the rounded notch
notch_offset_y = 5.4;  // vertical offset from center of hub to notch center

cylinderHeight = 1.7;
cylinderInnerHole = 2.8;
cylinderThickness = 1;
clearance = 0.3;
$fn = 100; // smoothness of round shapes

//Make squareKey adjustable for when it is used as a hole versus fill
module squareKey(offset,clr){
    OuterCylinderRadius = cylinderInnerHole+cylinderThickness+clr;
    width=squarekey+offset;
    translate([0, -OuterCylinderRadius-squarekey/2, 0])
    cube([width,width,cylinderHeight+offset], center = true);
}

module guidingHole(){
    translate([0, notch_offset_y, 0])
    scale([1, 1.25, 1]) cylinder(h = hub_thickness + 1, r = notch_radius, center = true);
}

//SideB

module sideBFill(){
    //base
    cylinder(h = baseHeight, r = hub_radius, center = true);  
    
    //male cylinder
    translate([0, 0, baseHeight])
    cylinder(h = cylinderHeight, r = cylinderInnerHole+cylinderThickness, center = true);
    
    //SquareKey
    translate([0,0, baseHeight])
    squareKey(0,0); 
}
module sideB(){
    difference(){
        sideBFill();
        guidingHole();
        //Small round center hole
        cylinder(h = baseHeight*5, r = cylinderInnerHole, center = true);
    
        // Upper bevel
        translate([0, 0, cylinderHeight+baseHeight])
        cylinder(h = (cylinderHeight+baseHeight)/2 + 1, r1 = 2, r2 = 10, center = true); 
        // lower bevel
        translate([0, 0, -baseHeight-0.15])
        cylinder(h = hub_thickness + 1, r1 = 10, r2 = 2, center = true); 
    }
       
    
}

//Start Side A

//Create solid parts
module sideAFill(){
    cylinder(h = hub_thickness, r = hub_radius, center = true); 
    translate([0, 0, hub_thickness/2-filler_thickness/2])
    cylinder(h = filler_thickness, r = filler_radius, center = true);
    translate([0, 0, -filler_thickness ])
    fillerGuide();
}

module sideA() { 
    difference(){
        sideAFill();
        //Center hole
        cylinder(h = hub_thickness*5, r = cylinderInnerHole+cylinderThickness+clearance, center = true);
        //SquareKey
        squareKey(clearance*3,clearance); 
        //GuidingHole
        guidingHole();
    }
    
} 
module fillerGuide(){
    translate([0, 0, hub_thickness/2-filler_thickness/2]){
        difference(){
            cylinder(h = filler_thickness*3, r = filler_radius-filler_guide_offset, center = true);
            cylinder(h = filler_thickness*3, r = filler_radius-filler_guide_offset-filler_guide, center = true);
        }
    }
}

// Render it
//sideB();
sideA();


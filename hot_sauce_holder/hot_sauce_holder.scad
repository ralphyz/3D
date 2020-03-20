
// The width of the entire bracket
bracket_width = 55;

// The thickness of the back part of the bracket
bracket_thickness = 13;

// The diameter of the circle where the hot sauce sits
holder_diameter = 55;

// The overall height of the bracket
stand_height = 55;

// How tall (thick) the arms are that hold the bottle
holder_thickness = 25;

// The gap in the front of the holder
holder_gap_width = holder_diameter * 0.6;

// The thickenss of the arms that hold the hotsauce
holder_arm_thickness=4;

// Diameter of the screw you plan to use
screw_diam=4;

// Diameter of screw-head
screw_head=9;


// These screw dimenions fit standard pocket hole screws
// Screw-head height (deepness for screw-head hole)
screw_head_h=3;

// The depth of the platform that holds the hot sauce
stand_width = 50;

// The thickness of this stand
stand_thickness = 3;

// The number of facets used to generate an arc (higher is smoother, but takes more time to render)
fn=128;


// The arms that hold the bottle in place
module holder ()
{
    translate([0, holder_diameter/4, holder_thickness/2 + stand_height])
    {
        difference ()
        {
            // base cube
            cube ([bracket_width,holder_diameter/2,holder_thickness], center=true);

            // half-cylindric hole
            translate ([0,holder_diameter/4,0])
            cylinder (r=holder_diameter/2, h=holder_thickness+0.1, center=true, $fn=fn);

        }
        
        difference()
        {
            translate ([0,holder_diameter/4,0])cylinder (r=bracket_width/2, h=holder_thickness, center=true, $fn=fn);
            translate ([0,holder_diameter/4,0])cylinder (r=(bracket_width-holder_arm_thickness)/2, h=holder_thickness, center=true, $fn=fn);
            translate([-holder_gap_width/2, holder_diameter/2, -(holder_thickness)/2])cube([holder_gap_width, holder_thickness, holder_thickness]);
            translate([holder_gap_width/2,holder_diameter/2,-(holder_thickness)/2])rotate([0,0,60])cube([holder_arm_thickness*3, holder_arm_thickness*2, holder_thickness]);
            translate([-holder_gap_width/2, holder_diameter/2, -(holder_thickness)/2])rotate([0,0,30])cube([holder_arm_thickness*2, holder_arm_thickness*3, holder_thickness]);
        }

        

    }
    
}

// The platform to hold the bottle
module stand()
{
    hull()
    {
        translate([-bracket_width/2, 0, 0])cube([5, 5, stand_thickness]);
        translate([-5+bracket_width/2, 0, 0])cube([5, 5, stand_thickness]);
        translate([2.5-bracket_width/2, -2.5+stand_width, 0])cylinder(d=5, h=stand_thickness, $fn=fn);
        translate([-2.5+bracket_width/2, -2.5+stand_width, 0])cylinder(d=5, h=stand_thickness, $fn=fn);
    }
}

// The back portion of the bracket.
module back()
{
    difference()
    {
    hull()
    {
        translate([-bracket_width/2,-bracket_thickness,0])cube([stand_thickness, stand_thickness, stand_thickness]); 
        translate([bracket_width/2-stand_thickness,-bracket_thickness,0])cube([stand_thickness, stand_thickness, stand_thickness]);
        translate([-bracket_width/2,-stand_thickness,0])cube([stand_thickness, stand_thickness, stand_thickness]); 
        translate([bracket_width/2-stand_thickness,-stand_thickness,0])cube([stand_thickness, stand_thickness, stand_thickness]);
        translate([-bracket_width/2,-stand_thickness,stand_height+holder_thickness-stand_thickness])cube([stand_thickness, stand_thickness, stand_thickness]);
        translate([bracket_width/2-stand_thickness,-stand_thickness,stand_height+holder_thickness-stand_thickness])cube([stand_thickness, stand_thickness, stand_thickness]);
        translate([-bracket_width/2,-bracket_thickness+stand_thickness/2,stand_height+holder_thickness-stand_thickness/2])rotate([0,90,0])cylinder(d=stand_thickness, h=stand_thickness, $fn=fn);
        translate([bracket_width/2-stand_thickness,-bracket_thickness+stand_thickness/2,stand_height+holder_thickness-stand_thickness/2])rotate([0,90,0])cylinder(d=stand_thickness, h=stand_thickness, $fn=fn);
    }
    screw_hole(position=[0,0,stand_height/4]);
    screw_hole(position=[0,0,stand_height*2/3]);
}
}

// generate a screw model (should be differenced to remove the model and create a hole)
module screw_hole(position=[0,0,0])
{
    translate(position)
    {
        translate([0,0,screw_head/2])
        rotate([90,0,0])
        {
            cylinder(d=screw_head, h=screw_head_h, $fn=fn);
            translate([0,0,screw_head_h])cylinder(d=screw_diam, h=bracket_thickness-screw_head_h, $fn=fn);
        }
    }
}

//Create the hot sauce holder, and rotate it to sit in a printable manner
translate([0, (holder_thickness + stand_height)/2, bracket_thickness])
rotate([90, 0, 0])
{
    color ("Crimson")holder();
    color ("Blue")stand();
    color ("Orange")back();
}
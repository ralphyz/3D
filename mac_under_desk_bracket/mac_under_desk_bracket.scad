/*
Created By: RalphyZ
Source: https://github.com/ralphyz/3D
License: Apache License 2.0
License Link: https://github.com/ralphyz/3D/blob/master/LICENSE
*/

// the overall length of the bracket 
// macbook pro is approximately 340mm
// you can print two pieces, one without the end_stop, and place them end to end.
bracket_length = 250;

// the overall width of each bracket arm
bracket_width = 50;

// the thickness of the lip that holds the laptop
lip_height = 7;

// The macbook pro requires approximately 20.5mm to comfortably slide in and out
bracket_height = 20.5 + lip_height;

// the width of the part that holds the laptop
lip_width = 25;

// put a stop on the end?
end_stop = true;

// how thick to make the end stop?
end_stop_thickness = 3;

// for the cable clip, how thick is your cable? Standard Apple usb-c cable is ~4mm
cable_diameter = 5.5;

// how thick is the clip?
cable_clip_thickness = 2;

// how wide is the clip?
cable_clip_width = 6;

// These screw dimenions fit standard pocket hole screws
// Diameter of the screw you plan to use
screw_diam=4;

// Diameter of screw-head
screw_head=9;

// Screw-head height (deepness for screw-head hole)
screw_head_h=3;

// The depth of the platform that holds the hot sauce
stand_width = 50;

// The thickness of this stand
stand_thickness = 3;

// The number of facets used to generate an arc (higher is smoother, but takes more time to render)
fn=128;

// constants that do not need adjusting
LEFT_BRACKET = 1;
RIGHT_BRACKET = 2;
MINI_SIZE = 3;


// generate a screw model (should be differenced to remove the model and create a hole)
module screw_hole(position=[0,0,0], spin=[0,0,0])
{
    translate(position)
    {
        rotate(spin)
        {
            cylinder(d=screw_head, h=screw_head_h, $fn=fn);
            translate([0,0,screw_head_h])cylinder(d=screw_diam, h=bracket_height-screw_head_h, $fn=fn);
        }
    }
}

module bracket(side, position=[0,0,0], clip = false, spin=[0,0,0])
{   
    echo(spin);
    
    translate(position)
    rotate(spin)
    
    {
        difference()
        {
            hull()
            {
                
                //these four points don't change from left to right
                translate([0, 0, bracket_height-MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([bracket_length, 0, bracket_height-MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([0, bracket_width - lip_width, bracket_height-MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([bracket_length, bracket_width - lip_width, bracket_height-MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                
                if( side == LEFT_BRACKET)
                {
                    cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                    translate([bracket_length, 0, 0])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                    translate([0,bracket_width - lip_width + MINI_SIZE/2,MINI_SIZE/2])rotate([0, 90, 0])cylinder(d=MINI_SIZE, h=MINI_SIZE, $fn=fn);
                    translate([bracket_length, bracket_width - lip_width + MINI_SIZE/2, MINI_SIZE/2])rotate([0, 90, 0])cylinder(d=MINI_SIZE, h=MINI_SIZE, $fn=fn);                    
                }
                else
                {
                    translate([0, MINI_SIZE/2, MINI_SIZE/2])rotate([0, 90, 0])cylinder(d=MINI_SIZE, h=MINI_SIZE, $fn=fn);
                    translate([bracket_length, MINI_SIZE/2, MINI_SIZE/2])rotate([0, 90, 0])cylinder(d=MINI_SIZE, h=MINI_SIZE, $fn=fn);
                    translate([0,bracket_width - lip_width,0])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                    translate([bracket_length, bracket_width - lip_width, 0])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                }
            }
            
            // screw holes are not dependent upon left/right.
            screw_hole(position=[bracket_length/5+screw_head/4, (bracket_width - lip_width)/2+screw_head/4, bracket_height], spin=[180,0,0]);
            screw_hole(position=[bracket_length/2+screw_head/4, (bracket_width - lip_width)/2+screw_head/4, bracket_height], spin=[180,0,0]);
            screw_hole(position=[bracket_length*4/5+screw_head/4, (bracket_width - lip_width)/2+screw_head/4, bracket_height], spin=[180,0,0]);
            
            
        }
        if( side == LEFT_BRACKET)
        {
            hull()
            {
                translate([0, bracket_width - MINI_SIZE, bracket_height-MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([0, bracket_width - lip_width - MINI_SIZE, bracket_height-MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([0, bracket_width - lip_width - MINI_SIZE, bracket_height-lip_height])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([0, bracket_width + MINI_SIZE/2 - MINI_SIZE, bracket_height+MINI_SIZE/2-lip_height])rotate([0,90,0])cylinder(d=MINI_SIZE, h=MINI_SIZE, $fn=fn);
                
                translate([bracket_length, bracket_width - MINI_SIZE, bracket_height - MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([bracket_length, bracket_width - lip_width - MINI_SIZE, bracket_height - MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([bracket_length, bracket_width - lip_width - MINI_SIZE, bracket_height-lip_height])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([bracket_length, bracket_width + MINI_SIZE/2 - MINI_SIZE, bracket_height+MINI_SIZE/2-lip_height])rotate([0,90,0])cylinder(d=MINI_SIZE, h=MINI_SIZE, $fn=fn);
            }
            
            if(end_stop)
            {
                translate([bracket_length, 0, 0])cube([end_stop_thickness, bracket_width, bracket_height]);
            }
            
            if(clip)
            {
                echo("CLIP");
                cable_clip(position=[10, bracket_width/2, bracket_height+0.3]);
            }
        }
        else
        {
            hull()
            {
                translate([0, -lip_width + MINI_SIZE, bracket_height-MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([0, -MINI_SIZE, bracket_height-MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([0, -MINI_SIZE, bracket_height-lip_height])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([0, -lip_width + MINI_SIZE + MINI_SIZE/2, bracket_height+MINI_SIZE/2-lip_height])rotate([0,90,0])cylinder(d=MINI_SIZE, h=MINI_SIZE, $fn=fn);
                
                translate([bracket_length, -lip_width + MINI_SIZE, bracket_height - MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([bracket_length, -MINI_SIZE, bracket_height-MINI_SIZE])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([bracket_length, -MINI_SIZE, bracket_height-lip_height])cube([MINI_SIZE, MINI_SIZE, MINI_SIZE]);
                translate([bracket_length, -lip_width + MINI_SIZE + MINI_SIZE/2, bracket_height+MINI_SIZE/2-lip_height])rotate([0,90,0])cylinder(d=MINI_SIZE, h=MINI_SIZE, $fn=fn);
            }
            
            if(end_stop)
            {
                translate([bracket_length, -lip_width+MINI_SIZE, 0])cube([end_stop_thickness, bracket_width, bracket_height]);
            }
            
            if(clip)
            {
                echo("CLIP");
                cable_clip(position=[10 + cable_clip_thickness+cable_diameter, 0, bracket_height+0.3], spin=180);
            }
        }
    }    
}
module cable_clip(position=[0,0,0], spin=0)
{
    
    translate(position)
    {   
        translate([0,0,-(cable_diameter+cable_clip_thickness)/2])
        rotate([0,0,spin])
        rotate([90, 0, 90])
        {
            difference()
            {
                translate([(cable_diameter+cable_clip_thickness)/2, (cable_diameter+cable_clip_thickness)/2, 0])
                {
                    difference()
                    {
                        cylinder(d=cable_diameter+cable_clip_thickness, h=cable_clip_width, $fn=fn);
                        cylinder(d=cable_diameter, h=cable_clip_width, $fn=fn);            
                    }
                    
                }
                cube([cable_diameter+cable_clip_thickness, (cable_diameter+cable_clip_thickness)/2, cable_clip_width]);
            }
        }
        rotate([0,0,spin])
        rotate([-5,0,0])translate([0, (cable_diameter+1), 0])cube([cable_clip_width, cable_diameter/2, cable_clip_thickness]);
    }
}

bracket(side=LEFT_BRACKET, position=[0, 0, 0], spin=[90,0,0], clip=false);
bracket(side=RIGHT_BRACKET, position=[0, bracket_height, bracket_width - lip_width+MINI_SIZE], spin=[270,0,0], clip=false);

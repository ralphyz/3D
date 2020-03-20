/*
Created By: RalphyZ
Source: https://github.com/ralphyz/3D
License: Apache License 2.0
License Link: https://github.com/ralphyz/3D/blob/master/LICENSE
*/

// make smooth circles
fn=128;

// wall thickness ~4mm, including the base and top of the lid
thickness = 4;


// the size of the inside diameter
inner_diameter = 60;

// height of the cup and the lid
cup_height = 79 + thickness;
cap_height = 52 + thickness;


// should text be printed on the lid?
print_text = false;

// what text do you want to engrave?
cap_text = "A";

// how big is the font for the text?
text_size = 40;

// how wide is the text? this is used to center the design on the lid
text_width = 40;

// how deep should the text be engraved? Should not be > (thickness + 1)
text_height = 2;

// create an air hole in the lid?
air_lid = true;

// create an air hole in the cup?
air_cup = true;

// air hole diameter?
air_hole_size = 2;



// this module creates the cup.  by default, it is positioned out of the way of the lid
module cup(position=[0, inner_diameter+thickness*4, 0])
{
    translate(position)
    difference()
    {
        cylinder(d=inner_diameter+thickness*2, h=cup_height+thickness, $fn=fn);
        translate([0,0,thickness])cylinder(d=inner_diameter, h=cup_height, $fn=fn);
        translate([0,0,cup_height-thickness*2])
        difference()
        {
            cylinder(d=inner_diameter+thickness*2, h=thickness*3, $fn=fn);
            cylinder(d=inner_diameter+thickness+0.6, h=thickness*3, $fn=fn);
        }
        
        if(air_cup)
        {
            cylinder(d=air_hole_size, h=thickness);
        }
    }
}

// this module creates the lid.  it is centered.
module lid()
{
    difference()
    {
        cylinder(d=inner_diameter+thickness*2, h=cap_height+thickness, $fn=fn);
        translate([0,0,thickness])cylinder(d=inner_diameter, h=cap_height, $fn=fn);
        translate([0,0,cap_height-thickness*2])
        cylinder(d=inner_diameter+thickness, h=thickness*3, $fn=fn);
        
        if(air_lid)
        {
            cylinder(d=air_hole_size, h=thickness);
        }
        
        if(print_text)
        {
            translate([-text_width/2,text_width/2,2])rotate([180,0,0])linear_extrude(height=text_height)text(cap_text, size=text_size);
        }
    }
}


// Real Work goes here!

// draw the cup
cup();

// draw the lid
lid();

/*
Created By: RalphyZ
Source: https://github.com/ralphyz/3D
License: Apache License 2.0
License Link: https://github.com/ralphyz/3D/blob/master/LICENSE
*/

//constants:
NONE = -1;
BOTH = 0;

// LEFT and TOP are the same value
// parts_side can be NONE|LEFT|RIGHT|FULL|BOTH
// wing_xx_screws can be TOP|BOTTOM|BOTH
LEFT = 1;
TOP = 1;

// RIGHT and BOTTOM are the same value
// parts_side can be NONE|LEFT|RIGHT|FULL|BOTH
// wing_xx_screws can be TOP|BOTTOM|BOTH
RIGHT = 2;
BOTTOM = 2;

// parts_side can be NONE|LEFT|RIGHT|FULL|BOTH
FULL = 3;

// adjust this section to fit your drill (if not DeWalt DCD991)
big_ring_diameter = 50;
big_ring_height = 14;
small_ring_diameter = 44;
small_ring_height = 53;
wall_thickness = 4;
base_thickness=2;


// wings are for the screws into the wall.  
wing_width = big_ring_diameter;
wing_depth = wall_thickness * 2;
wing_height = wing_width / 3;

// show the top wing?
wing_top = true;
// wing_xx_screws can be TOP|BOTTOM|BOTH
wing_top_screws = NONE;

// show the left wing?
wing_left = true;
// wing_xx_screws can be TOP|BOTTOM|BOTH
wing_left_screws = BOTH;

// show the right wing?
wing_right = true;
// wing_xx_screws can be TOP|BOTTOM|BOTH
wing_right_screws = BOTH;

// show the bottom wing?
wing_bottom = true;
// wing_xx_screws can be TOP|BOTTOM|BOTH
wing_bottom_screws = BOTH;


// parts_side can be NONE|LEFT|RIGHT|FULL|BOTH
// BOTH = one on the left, one on the right
// FULL = expands to the run across the front
parts_side = FULL;

parts_holder_width = 75;
parts_holder_height = 20;
parts_holder_thickness = 2;
parts_holder_depth = big_ring_diameter - parts_holder_thickness;

// add up the heights
total_height = big_ring_height + small_ring_height;

// These screw dimenions fit standard pocket hole screws
// Diameter of the screw you plan to use
screw_diam=4;

// Diameter of screw-head
screw_head=9;

// Screw-head height (deepness for screw-head hole)
screw_head_h=3;

// The width of the platform
stand_width = 50;

// The thickness of this stand
stand_thickness = 3;

// The number of facets used to generate an arc (higher is smoother, but takes more time to render)
fn=128;

if(parts_side == BOTH || parts_side == FULL)
{
    wing_right = true;
    wing_left = true;
    
    if(wing_left_screws == BOTTOM)
    {
        wing_left_screws = NONE;
    }
    else if(wing_left_screws == BOTH)
    {
        wing_left_screws = TOP;
    }
    
    if(wing_right_screws == BOTTOM)
    {
        wing_right_screws = NONE;
    }
    else if(wing_right_screws == BOTH)
    {
        wing_right_screws = TOP;
    }
}
else if(parts_side == LEFT)
{
    if(wing_left == false)
    {
        echo("NONE");
        wing_left_screws = NONE;
    }
    
    wing_left = true;
    if(wing_left_screws == BOTTOM)
    {
        wing_left_screws = NONE;
    }
    else if(wing_left_screws == BOTH)
    {
        wing_left_screws = TOP;
    }
}
else if(parts_side == RIGHT)
{
    if(wing_right == false)
    {
        wing_right_screws = NONE;
    }
    
    wing_right = true;
    if(wing_right_screws == BOTTOM)
    {
        wing_right_screws = NONE;
    }
    else if(wing_right_screws == BOTH)
    {
        wing_right_screws = TOP;
    }
}
else if (parts_side == BOTH)
{
    
}

/**
 * Simple triangles library
 *
 * Authors:
 *   - Eero 'rambo' af Heurlin 2010-
 *
 * License: LGPL 2.1
 */


/**
 * Standard right-angled triangle
 *
 * @param number  o_len  Length of the opposite side
 * @param number  a_len  Length of the adjacent side
 * @param number  depth  How wide/deep the triangle is in the 3rd dimension
 * @param boolean center Whether to center the triangle on the origin
 * @todo a better way ?
 */
module triangle(o_len, a_len, depth, center=false)
{
    centroid = center ? [-a_len/3, -o_len/3, -depth/2] : [0, 0, 0];
    translate(centroid) linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}

/**
 *  END Simple triangles library
 */

// generate a screw model (should be differenced to remove the model and create a hole)
module screw_hole(position=[0,0,0], spin=[0,0,0])
{
    translate(position)
    {
        rotate(spin)
        {
            cylinder(d=screw_head, h=screw_head_h, $fn=fn);
            translate([0,0,screw_head_h])cylinder(d=screw_diam, h=wing_depth-screw_head_h, $fn=fn);
        }
    }
}

module create_wing(position=[0,0,0], spin=[0,0,0], screws=BOTH)
{
    translate(position)
    rotate(spin)
    difference()
    {                
        translate([0, -wing_depth/2, wing_height/2])cube([wing_width, wing_depth, wing_height], center=true);
        
        if(screws == BOTH || screws == TOP || screws == LEFT)
            screw_hole(position=[wing_width/4, -wing_depth, wing_height/2], spin=[-90,0,0]);
        
        if(screws == BOTH || screws == BOTTOM || screws == RIGHT)
        screw_hole(position=[-wing_width/4, -wing_depth, wing_height/2], spin=[-90,0,0]);
    }
}

module add_wings(position=[0,0,0], spin=[0,0,0], blank=false, side=BOTH)
{
    if(blank)
    {
        if(side == BOTH || side == LEFT)
        {
            if(wing_top)
            {
                translate([-big_ring_diameter/2, -wing_depth, big_ring_diameter])rotate([90,0,180])triangle(wing_height, wing_height, wing_depth);
            }
            if(wing_bottom)
            {
                translate([-big_ring_diameter/2, -wing_depth, 0])rotate([270,90,0])triangle(wing_height, wing_height, wing_depth);
            }
        }
        if(side == BOTH || side == RIGHT)
        {
            if(wing_top)
            {
                translate([big_ring_diameter/2, 0, big_ring_diameter])rotate([90,0,00])triangle(wing_height, wing_height, wing_depth);
            }
            if(wing_bottom)
            {
                translate([big_ring_diameter/2, -wing_depth, 0])rotate([270,0,00])triangle(wing_height, wing_height, wing_depth);
            }
        }
    }
    else
    {
        if(wing_top)
        {
            create_wing(position=[0,0,big_ring_diameter], screws=wing_top_screws);
            
            if(wing_left)
            {
                translate([-big_ring_diameter/2, -wing_depth, big_ring_diameter])rotate([90,0,180])triangle(wing_height, wing_height, wing_depth);
            }
            if(wing_right)
            {
                translate([big_ring_diameter/2, 0, big_ring_diameter])rotate([90,0,00])triangle(wing_height, wing_height, wing_depth);
            }
        }
        if(wing_right)
            create_wing(position=[big_ring_diameter/2,0,big_ring_diameter/2], spin=[0,90,0], screws=wing_right_screws);
        
        if(wing_left)
            create_wing(position=[-big_ring_diameter/2,0,big_ring_diameter/2], spin=[0,-90,0], screws=wing_left_screws);
        
        if(wing_bottom)
        {
            create_wing(position=[0,0,0], spin=[0,180,0], screws=wing_bottom_screws);
            
             if(wing_left)
            {
            translate([-big_ring_diameter/2, -wing_depth, 0])rotate([270,90,0])triangle(wing_height, wing_height, wing_depth);
            }
            
            if(wing_right)
            {
                translate([big_ring_diameter/2, -wing_depth, 0])rotate([270,0,00])triangle(wing_height, wing_height, wing_depth);
            }        
        }
    }
}

module build_holder(position=[0,0,0], spin=[0,0,0])
{

    translate(position)
    rotate(spin)
    {   
        translate([0,wing_depth-parts_holder_thickness, 0])
        {
            if(parts_side == BOTH || parts_side == LEFT)
            {
                if(wing_left)
                translate([-big_ring_diameter/2,-wing_depth+parts_holder_thickness,big_ring_diameter/2])
                rotate([0,-90,0])screw_hole(position=[-wing_width/4, -wing_depth, wing_height/2], spin=[-90,0,0]);
              
                
                translate([-parts_holder_width-big_ring_diameter/2, -parts_holder_depth-wing_depth, 0])cube([parts_holder_width, parts_holder_depth, parts_holder_thickness]);
                translate([-parts_holder_width-big_ring_diameter/2, -wing_depth, 0])cube([parts_holder_width, parts_holder_thickness, parts_holder_height]);
                translate([-parts_holder_width-big_ring_diameter/2, -wing_depth-parts_holder_depth-parts_holder_thickness, 0])cube([parts_holder_width, parts_holder_thickness, parts_holder_height]);
                translate([-parts_holder_width-big_ring_diameter/2, -parts_holder_depth-wing_depth, 0])cube([parts_holder_thickness, parts_holder_depth, parts_holder_height]);
                
            }
            if(parts_side == BOTH || parts_side == RIGHT)
            {

                if(wing_right)
                translate([big_ring_diameter/2,-wing_depth+parts_holder_thickness,big_ring_diameter/2])
                rotate([0,90,0])screw_hole(position=[wing_width/4, -wing_depth, wing_height/2], spin=[-90,0,0]);
                
                translate([big_ring_diameter/2, -parts_holder_depth-wing_depth, 0])cube([parts_holder_width, parts_holder_depth, parts_holder_thickness]);
                translate([big_ring_diameter/2, -wing_depth, 0])cube([parts_holder_width, parts_holder_thickness, parts_holder_height]);
                translate([big_ring_diameter/2, -wing_depth-parts_holder_depth-parts_holder_thickness, 0])cube([parts_holder_width, parts_holder_thickness, parts_holder_height]);
                translate([big_ring_diameter/2+parts_holder_width-parts_holder_thickness, -parts_holder_depth-wing_depth, 0])cube([parts_holder_thickness, parts_holder_depth, parts_holder_height]);
            }
            if(parts_side == FULL)
            {
                if(wing_left)
                translate([-big_ring_diameter/2,-wing_depth+parts_holder_thickness,big_ring_diameter/2])
                rotate([0,-90,0])screw_hole(position=[-wing_width/4, -wing_depth, wing_height/2], spin=[-90,0,0]);
                
                if(wing_right)
                translate([big_ring_diameter/2,-wing_depth+parts_holder_thickness,big_ring_diameter/2])
                rotate([0,90,0])screw_hole(position=[wing_width/4, -wing_depth, wing_height/2], spin=[-90,0,0]);
                
               
                translate([-parts_holder_width-big_ring_diameter/2, -parts_holder_depth-wing_depth-big_ring_diameter, 0])cube([parts_holder_width * 2 + big_ring_diameter, parts_holder_depth+big_ring_diameter, parts_holder_thickness]);
                translate([-parts_holder_width-big_ring_diameter/2, -wing_depth, 0])cube([parts_holder_width, parts_holder_thickness, parts_holder_height]);
                translate([big_ring_diameter/2, -wing_depth, 0])cube([parts_holder_width, parts_holder_thickness, parts_holder_height]);
                translate([-parts_holder_width-big_ring_diameter/2, -wing_depth-parts_holder_depth-parts_holder_thickness-big_ring_diameter, 0])cube([parts_holder_width*2+big_ring_diameter, parts_holder_thickness, parts_holder_height]);
                
                translate([-parts_holder_width-big_ring_diameter/2, -parts_holder_depth-wing_depth-big_ring_diameter, 0])cube([parts_holder_thickness, parts_holder_depth+big_ring_diameter, parts_holder_height]);
                translate([big_ring_diameter/2+parts_holder_width-parts_holder_thickness, -parts_holder_depth-wing_depth-big_ring_diameter, 0])cube([parts_holder_thickness, parts_holder_depth+big_ring_diameter, parts_holder_height]);
            }
        }
    }
}

module strong_tube(position=[0,0,0], spin=[45,0,0], height_offset=(big_ring_diameter+wall_thickness)/2)
{   
    
    translate(position)    
    difference()
    {
        union()
        {
            //big cylinder
            rotate(spin)
            translate([0, -base_thickness, height_offset+base_thickness])
            cylinder(d=big_ring_diameter+wall_thickness, h=total_height, $fn=fn);
            
            // horizontal supports
            translate([0,-big_ring_diameter/2,base_thickness/2])cube([big_ring_diameter, big_ring_diameter, base_thickness], center=true);        
            translate([0,-big_ring_diameter/2,base_thickness/2+big_ring_diameter/2])cube([big_ring_diameter, big_ring_diameter, base_thickness], center=true);
            translate([0,-big_ring_diameter/2,base_thickness/2+big_ring_diameter*3/4])cube([big_ring_diameter, big_ring_diameter, base_thickness], center=true);
            translate([0,-big_ring_diameter/2,base_thickness/2+big_ring_diameter-base_thickness])cube([big_ring_diameter, big_ring_diameter, base_thickness], center=true);
            translate([0,-big_ring_diameter/2,base_thickness/2+big_ring_diameter/4])cube([big_ring_diameter, big_ring_diameter, base_thickness], center=true);
            
            // back to front, vertical supports
            translate([0,-base_thickness/2, big_ring_diameter/2])cube([big_ring_diameter, base_thickness, big_ring_diameter], center=true);       
            translate([0,-base_thickness/2-big_ring_diameter/2, big_ring_diameter/2])cube([big_ring_diameter, base_thickness, big_ring_diameter], center=true);
            translate([0,-base_thickness/2-big_ring_diameter*3/4, big_ring_diameter/2])cube([big_ring_diameter, base_thickness, big_ring_diameter], center=true);
            translate([0,-base_thickness/2-big_ring_diameter, big_ring_diameter/2])cube([big_ring_diameter, base_thickness, big_ring_diameter], center=true);
            translate([0,-base_thickness/2-big_ring_diameter/4, big_ring_diameter/2])cube([big_ring_diameter, base_thickness, big_ring_diameter], center=true);
            
            // side to side, vertical supports
            translate([0,-big_ring_diameter/2, big_ring_diameter/2])cube([base_thickness, big_ring_diameter, big_ring_diameter], center=true);
            translate([big_ring_diameter/4-base_thickness/2,-big_ring_diameter/2, big_ring_diameter/2])cube([base_thickness, big_ring_diameter, big_ring_diameter], center=true);
            translate([big_ring_diameter/2-base_thickness/2,-big_ring_diameter/2, big_ring_diameter/2])cube([base_thickness, big_ring_diameter, big_ring_diameter], center=true);
            translate([-big_ring_diameter/4+base_thickness/2,-big_ring_diameter/2, big_ring_diameter/2])cube([base_thickness, big_ring_diameter, big_ring_diameter], center=true);
            translate([-big_ring_diameter/2+base_thickness/2,-big_ring_diameter/2, big_ring_diameter/2])cube([base_thickness, big_ring_diameter, big_ring_diameter], center=true);
            
            
            // base plate inside
            rotate(spin)
            translate([0, -base_thickness, height_offset])
            {
                cylinder(d=small_ring_diameter, h = wall_thickness, $fn=fn);
               
            }
        }

        // hollow out the holder
        rotate(spin)
        {
            translate([0, -base_thickness, height_offset + base_thickness])
            {
                translate([0,0,0])cylinder(d=small_ring_diameter, h = small_ring_height, $fn=fn);
                translate([0,0,small_ring_height])cylinder(d=big_ring_diameter, h=big_ring_height, $fn=fn);
            }
        }
    }


}

rotate([-90,0,0])
{
    strong_tube();
    build_holder();
    add_wings();

}

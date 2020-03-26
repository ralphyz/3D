// intermediate shapes

// numbers used for size are interpreted by most printers as millimeters
thickness = 2; // variable to create 3mm thick pieces
diameter = 20; // 20mm circles
height = 25; // 45mm

// $fn is the variable for circles that determine how many 'facets' 
// are displayed.  Default is 10. 128 makes smoother circles
fn = 128;

// intersection keeps only the area where the items overlap
// create a hexagon
intersection()
{
    cube([diameter, diameter, thickness], center=true);
    
    // rotate spins the object on the [x,y,z] planes
    // easier to rotate before translate....e.g. translate-->rotate-->object
    // functions get called from the inside-out.
    rotate([0,0,45])cube([diameter, diameter, thickness], center=true);
}


// difference keeps only the first item with the overlap part of the second item removed
// create a tub
difference()
{
    cylinder(d=diameter*.60, h=height, $fn=fn);
    cylinder(d=diameter*.60-thickness, h=height, $fn=fn);
}

// hull wraps all areas with material (but does not increase the height)
// think of it like shrinkwrap
hull()
{
    //add color to objects.  Objects inside another object may not
    //show their color.
    color("red")
    translate([diameter, diameter, 0])
    cylinder(d=thickness, h=thickness, $fn=fn);
    
    color("yellow")
    translate([diameter*2, diameter, 0])
    cylinder(d=thickness, h=thickness, $fn=fn);
    
    color("green")
    translate([diameter*2, diameter*2, 0])
    cylinder(d=thickness, h=thickness, $fn=fn);
    
    color("purple")
    translate([diameter, diameter*2, 0])
    cylinder(d=thickness, h=thickness, $fn=fn);
}

//try wrapping the code above in hull, and you will get a duck foot :)

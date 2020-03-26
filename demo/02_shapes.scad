// basic shapes

// numbers used for size are interpreted by most printers as millimeters
thickness = 3; // variable to create 3mm thick pieces
diameter = 20; // 20mm circles

// $fn is the variable for circles that determine how many 'facets' 
// are displayed.  Default is 10. 128 makes smoother circles
fn = 128;


// default $fn - circle is not super smooth
cylinder(d=20, h=thickness);


// higher $fn - increases rendering time
// translate is used to reposition items on the grid [x,y,z] cordinates
translate([diameter + 5, 0, 0])cylinder(d=20, h=thickness, $fn=fn);


// create an equilateral triangle
translate([-diameter - 5, 0, 0])cylinder(d=20, h=thickness, $fn=3);

// create a square
translate([-diameter/2, diameter/2 + 5, thickness/2])cube([diameter, diameter, thickness]);

// create a square
translate([-diameter, diameter/2 + 5, thickness/2])cube([thickness, diameter, diameter]);

// create a square - with a different orientation
translate([diameter/2 + 5, diameter/2 + 5, thickness/2])cube([diameter, thickness, diameter]);


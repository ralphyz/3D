// advanced

thickness = 2;
depth = 10; 
width = 20; 
height = 5; 

// $fn is the variable for circles that determine how many 'facets' 
// are displayed.  Default is 10. 128 makes smoother circles
fn = 128;


//if statements
if(thickness <=2)
{
    // echo statements print things to the console - good for debugging
    echo("Thickness is &lt;= 2!");
}
else
{
    echo("Thickness is too high!");
}


// for loops
// count 1-10
for(i=[1:10])
{
    echo(i);
}

// count 1-10, odd numbers
for(i=[1:2:10])
{
    echo(i);
}

// create stairs
for(i=[1:5])
{
  translate([0, (i-1)*depth, 0])cube([width, depth, (i-1)*height]);
}


// for loop with let
// let creates variables that are applicable for that iteration only

for (i = [10:20])
{
    let (angle = i*360/20, r= i*1.5, distance = r*4)
    {
        rotate(angle, [0, 0, 1])
        translate([0, distance, 0])
        sphere(r = r, $fn=fn);
    }
}

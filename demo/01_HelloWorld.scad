//single line comment
/*
multi line comment
*/
//OpenSCAD is written in C++

//variables can only be assigned once
x = 3;  //line 18 writes to x again, so 7 is used, not 3
echo(x);

// let statements allow you to get around this
let(x = 5)
{
  echo(x);
}

// second assignment: the last assignment is used.
x = 7;
echo(x);

// hw assigned outside of the function, that is okay.
hw = "ABC";
echo(hw);

//function
module HelloWorld()
{
    // hw assigned inside of a function, doesn't overwrite other value
    hw = "Hello, World!";
    echo(hw);
    linear_extrude(height=x)text(hw);
}

// function call
HelloWorld();

echo(hw);echo(x);// whitespace is ignored
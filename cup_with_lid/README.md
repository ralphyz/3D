# Cup with Lid

This is a simple cup with a friction-fit lid.  I made this to fit crayon-pencils for my daughter.  Depending on the accuracy of the print, you may need to sand the lip on the cup or the inside rim of the lid.  I have found that adding parafin wax around both areas helps lubricate the plastic and makes the lid easy to remove.

If you would like to add a letter (or other text) to the top of the lid, change `print_text = false;` to `print_text = true;` and adjust the text you would like to add.  

The defaults:
```
// make smooth circles
fn=128;

// wall thickness ~4mm, including the base and top of the lid
thickness = 4;

// the size of the inside diameter
inner_diameter = 60;

// height of the cup and the lid
cup_height = 79 + thickness;
cap_height = 52 + thickness;

// create an air hole in the lid?
air_lid = true;

// create an air hole in the cup?
air_cup = true;

// air hole diameter?
air_hole_size = 2;
```

![cup with a lid](../img/cup_with_lid_small.png)


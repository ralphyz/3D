# OpenSCAD Lightning Talk

This is a quick introduction to OpenSCAD: a programmatic way to generate solid 3D models.  The intention is to introduce you to 3D Printing, and how I design prints using OpenSCAD!

# Topics

 - My Setup
 - 3D Printing Intro
 - OpenSCAD Quick Links
 - OpenSCAD Intro: Hello, World!
 - Basic Shapes
 - Intermediate Operations
 - Advanced Techniques
 - Q&A

### My Setup
 - MacBook Pro
 - Qidi 3D X-Plus Printer
 - Qidi-Print Slicing Software

### 3D Printing Intro
To generate a 3D model for printing, a design is first created in a CAD program.  The design is exported as a stereolithographic file format, known as STL.  This exported file format is common to CAD programs like AutoCAD, Blender, MeshLab, and OpenSCAD.  STL is an interpretation of the geometry of the object.  Because of that, most programs cannot work with STL files like they can (their own) CAD files.  Basic transformations (scale, rotate, etc.) are possible, but not editing the individual components.  Think about STL like a lego object that has been superglied together.  You see the shape and can add on to it, but you cannot "edit" individual components.  

Ok, so first CAD then export to STL.  Now I can print from an STL, right?  Well, 3D printers read G-CODE.  Think about how extrusion-printing works.  You take 0.2mm slice of the bottom of the object, extrude that onto a flat surface.  Then repeat the process with the next 0.2mm slice on top of the first layer.  Those "slices" are stored in a file that has [x,y,z] coordinates for the printer (among other things), telling it where to extrude molten plastic.  To generate this G-CODE file, a slicer is used.  Slicer's read STL files and produce G-CODE.  There are plenty of free slicers, and some printers come with software that is configured to slice better for that printer.  

**CAD to STL to G-CODE.  Now you are a 3D printing expert!**

### OpenSCAD Quick Links
* [OpenSCAD](https://www.openscad.org/) Website
* [Download](https://www.openscad.org/downloads.html) OpenSCAD
* [Documentation](https://www.openscad.org/documentation.html)
* [OpenSCAD Forum](http://forum.openscad.org/)


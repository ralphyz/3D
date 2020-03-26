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
To print a 3D model, a design is first created in a CAD system.  The design is exported as a stereolithographic file format, known as STL.  This file format is common to CAD programs like AutoCAD, Blender, MeshLab, and OpenSCAD.  STL is an interpretation of the geometry of the object.  Because of that, most programs cannot work with STL files like they can CAD files.  Basic transofmrations (scale, rotate, etc) are possible, but not editing the individual components.  Think about the people who superglue legos together.  When done, you see the shape, but you cannot "edit" individual components.  

CAD to STL.  Then what?  3D printers read G-CODE.  Think about how extrusion-printing works.  You take 0.2mm slice of the bottom of the object, extrude that onto a flat surface.  Then repeat the process with the next 0.2mm slice on top of the first layer.  Those "slices" are stored in a file that has [x,y,z] coordinates for the printer, telling it where to extrude molten plastic.  To generate this G-CODE file, a slicer is used.  Slicer's read STL files and produce G-CODE.  There are plenty of free slicers, and some printers come with software that is configured for the device.  

**CAD to STL to G-CODE.  Now you are a 3D printing expert!**

### OpenSCAD Quick Links
* [OpenSCAD](https://www.openscad.org/) Website
* [Download](https://www.openscad.org/downloads.html) OpenSCAD
* [Documentation](https://www.openscad.org/documentation.html)
* [OpenSCAD Forum](http://forum.openscad.org/)


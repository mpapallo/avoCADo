# avoCADo
##### by CADtherine and MiCADla
##### Team aCADemic dishonesty

###Description 
CADKey in Processing<br>
The love child of the CS and drafting departments has been birthed! In typical CS fashion it has some nice features; in typical drafting fashion it mainly will make you want to die. This uses the [ControlP5 Library](http://www.sojamo.de/libraries/controlP5/) so be sure to download that before getting started.<br>
(**We are not responsible for any bugs that the cp5 guy never fixed, e.g. if a menu item stay highlighted even when it's not active**) <-- actually we took care of that one, but there may be others<br>
(**Also, as juniors, we had little to no time to work on this in the final week because of SATs and various finals, which is why our commits are mainly concentrated into one night of sadness**)

###How to Use
Working V1 (June 1st): https://github.com/mpapallo/avoCADo/tree/eee70c9b42fec6a53991a2e1114316673a7f7077 <br>
- You can create Rectangles or Circles in any of the 3 views; creating lines vaguely works.
- You can also clear the screen of all shapes.

Working V2 (June 8th): https://github.com/mpapallo/avoCADo/tree/demo1 <br>
- You can create lines.
- You can no longer create stuff in weird places.
- You can delete individual shapes.
- You can save a file and then open it later.
- You can cry because you're not sleeping tonight.
- See V1.

Working V3 (June 15th): <br>
- Upon running CAD, you can choose to either open an existing file or create a new one.
- You can create shapes by selecting either Rectangle, Circle, or Line from the Create menu and following the instructions on the side. We have error handling for incorrect inputs, including numbers that are out of bounds.
    Circles: select a center, input a radius<br>
    Lines: you can either use the cursor to select a point, or you can "end ent" to an existing line (i.e. connect to one of its endpoints)<br>
    Rectangles: select a top left corner, input a width, input a radius
- You can delete shapes by selecting the Delete Button and then choosing a shape from the Rectangles, Lines, or Circles menu  (when you hover over the shape's name, it turns white).
- You can move or copy shapes from the XForm menu. Input the change in x, change in y, and change in z.
- At any time during creating, deleting, moving, or copying a shape, you can select the Abort button to cancel.
- At any time, you can select the Menu Screen button to go back to the title screen and select a file to load.
- You can select the 3D View button to view the isometric shape in a new window.
- You can either Save to an existing file or Save As a new file.

###To Do
- everything

###DevLog
<b>5/22/15</b>
- background done

<b>Memorial Day Weekend:</b>
- Shapes abstract class
- Shape subclasses started
- menu buttons started

<b>5/26/15</b>
- messing around with text input

<b>5/26/15</b>
- can get input but can't prompt again

<b>5/28/15</b>
- text input issue fixed, can actually wait for input
- user can create a circle from top or front view, and a rectangle from top view
- a merge conflict e<i>merge</i>d after finishing rectangle, but it was <i>rect</i>ified

<b>5/31/15</b>
- circle views work but boundary issues
- rect views work
- lines work!

<b>6/1/15</b>
- fixed boundary issues so now the creation of shapes actually works

<b>6/5/15</b>
- started delete/planned

<b>6/6/15</b>
- created title screen

<b>6/7/15</b>
- you can now delete any shape you create c:
- save file/open file

<b>6/9/15</b>
- starting xform: you can move rects and circles

<b>6/10/15</b>
- fixed some bugs in move
- after applying <i>copy</i>-ous amounts of effort, did copy

<b>6/11/15</b>
- started end ent

<b>6/12/15</b>
- created master menu of shapes

<b>6/13/15</b>
- 3D window
- End ent for lines

<b>6/14/15</b>
- fixing end ent issues
- move
- 3D work
- much crying
- lots of bug fixing and error handling

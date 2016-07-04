#version 3.7;

global_settings {
    assumed_gamma 1
    charset utf8
}

#include "Chair.pov"
#include "ReservedTableSign.pov"
#include "RoundTable.pov"
#include "TrashCan.pov"
#include "Window.pov"

//#local winHeightRow1 = 0.2;
//#local winHeightRow2 = 0.7;
//#local winHeightRow3 = 0.5;
//#local winBorderRadius = 0.02;
#local winHeightRow1 = 1.5;
#local winHeightRow2 = 4;
#local winHeightRow3 = 2.8;
#local winWidth = 2.5;
#local winBorderRadius = 0.1;
#local numWindows = 12;
#local chairScaling = 1.5;
#local offsetZ = -100;

camera {
    //location <0, 1, -1.5>
    //look_at <0, 1, 1>
    location <-3.8, 1, offsetZ>
    look_at <9, 0, 1>
}

background { White * 0.5 }

light_source { <0, 2, offsetZ> color White }

// Floor
plane {
    y, -1
    texture {
        pigment { checker rgb<0.8, 0.8, 0.8> White }
    }
}

// Window
union {
    // Outside world
    box {
        <-100, 0, 2 * winBorderRadius>,
        <100, 2 * (winHeightRow1 + winHeightRow2 + winHeightRow3), 2 * winBorderRadius + 1>
        texture {
            pigment { rgb<0, 0.5, 1> }
        }
    }

    object {
        Window(winWidth, winHeightRow1, winBorderRadius, numWindows)
        translate y * (winHeightRow2 + winHeightRow3)
    }

    object {
        Window(winWidth, winHeightRow2, winBorderRadius, numWindows)
        translate y * winHeightRow3
    }

    object {
        Window(winWidth, winHeightRow3, winBorderRadius, numWindows)
    }

    pigment { Gray }
    translate <0, -1, 20 + offsetZ>
}

// Ceiling
plane {
    y, winHeightRow2 + winHeightRow3
    texture {
        pigment { Gray }
    }
}

// Chairs
object {
    Chair
    scale chairScaling
    rotate y * -120
    translate <-3.5, -1, 5 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * 150
    translate <-2.5, -1, 5 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * -30
    translate <-3.2, -1, 6 + offsetZ>
}

// Tables
object {
    RoundTable(0.8, 0.6, 0.02)
    pigment { White }
    rotate y * 10
    scale 1.2
    // -0.55
    translate <-3, -0.46, 5 + offsetZ>
}

// Sign
object {
    Sign
    rotate y * -15
    scale 0.8
    translate <-3, 0.02, 5 + offsetZ>
}

// Trash Can
object {
    TrashCan(0.8, 0.5, 0.3, 0.035, 0.02, 35, 4)
    pigment { Orange }
    scale 0.7
    translate <-4.2, -1, 9 + offsetZ>
}
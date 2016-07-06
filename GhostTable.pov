#version 3.7;

#include "colors.inc"
#include "shapes.inc"
#include "Utils.pov"

#local debugMode = 1;
#if (debugMode)
    global_settings {
        assumed_gamma 1
        charset utf8
    }
#end

// ----------------------------------------
// GhostTable
// ----------------------------------------
#macro GhostTable(tWidth, tHeight, tThickness, absHeight)
    #local yTop = absHeight - tThickness;
    #local sOffset = 0.001 * tWidth;
    #local spThickness = 0.05 * absHeight;
    union {
        RoundedSquare(tWidth - 2*sOffset, tHeight, tThickness)
        translate <0, yTop, 0>

        //cylinder {
            //<0, >
        }
    }
#end

#macro RoundedSquare(tWidth, tHeight, tThickness)
    #local radio = tThickness * 0.8;
    #local radioOffset = tThickness * 0.2;
    union {
        box {
            <-tWidth/2, 0, -tHeight/2>,
            <tWidth/2, tThickness, tHeight/2>
        }
        difference {
            union {
                cylinder {
                    <-tWidth/2, radioOffset, -tHeight/2>,
                    <tWidth/2, radioOffset, -tHeight/2>,
                    radio
                }
                cylinder {
                    <-tWidth/2, radioOffset, tHeight/2>,
                    <tWidth/2, radioOffset, tHeight/2>,
                    radio
                }
            }
            box {
                <-tWidth, 0, -tHeight>,
                <tWidth, -tThickness, tHeight>
            }
        }
    }
#end

// ----------------------------------------
// Scene
// ----------------------------------------

#if (debugMode)
    camera {
      location <0, 0, -1.5>
      look_at <0, 0, 1>
    }

    background { White * 0.5 }

    light_source { <-1, 2, -2> color White }

    plane {
        y, -1
        texture {
            pigment { checker rgb<0.3, 0.3, 0.3> White }
        }
    }

    #local h = 2;
    union {
        object {
            GhostTable(1.5, 0.7, 0.03, 0.8)
            rotate y * 20
        }

        /*box {
            <-1.2, 0, -0.2>,
            <-0.8, h, 0.2>
        }*/
        translate <0, -1, 1>
    }
#end

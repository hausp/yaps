#version 3.7;

#include "colors.inc"
#include "textures.inc"

#local debugMode = 1;
#if (debugMode)
    global_settings {
        assumed_gamma 1
        charset utf8
    }
#end

// ----------------------------------------
// SquareTable
// ----------------------------------------

#macro SquareTable(tWidth, tHeight, tThickness, absHeight)
    #local yTop = absHeight/2 - tThickness;
    #local sOffset = 0.001 * tWidth;
    merge {
        merge {
            RoundedSquare(tWidth - 2*sOffset, tHeight, tThickness)
            BlackDetails(tWidth, tHeight, tThickness, sOffset)
            translate yTop * y
        }
    }
#end

#macro RoundedSquare(tWidth, tHeight, tThickness)
    #local radio = tThickness * 0.8;
    #local radioOffset = tThickness * 0.2;
    merge {
        box {
            <-tWidth/2, 0, -tHeight/2>,
            <tWidth/2, tThickness, tHeight/2>
        }
        difference {
            merge {
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

#macro BlackDetails(tWidth, tHeight, tThickness, sOffset)
    intersection {
        merge {
            box {
                <-tWidth/2, 0, -tHeight>,
                <-tWidth/2 + sOffset, tThickness, tHeight>
            }
            box {
                <tWidth/2, 0, -tHeight>,
                <tWidth/2 - sOffset, tThickness, tHeight>
            }
        }
        RoundedSquare(tWidth, tHeight, tThickness)
        texture {
            pigment { Black }
        }
    }
#end

/*
#macro AnnoyingDetail(tWidth, tHeight, tThickness, sThickness)
    intersection {
        box {
            <-tWidth/2, 0, -tHeight>,
            <-tWidth/2 + sThickness, tThickness, tHeight>
        }
        RoundedSquare(tWidth, tHeight, tThickness)
        texture {
            pigment { Black }
        }
        translate (tWidth/2 - sThickness/2) * x
    }
#end
*/

// ----------------------------------------
// Scene
// ----------------------------------------

#if (debugMode)
    camera {
      location <0, 1, -1.5>
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

    object {
        SquareTable(1.5, 0.5, 0.02, 0.9)
        texture {
            pigment { White }
        }
    }
#end
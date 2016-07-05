#version 3.7;

#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "utils.pov"

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
    #local yTop = absHeight - tThickness;
    #local sOffset = 0.001 * tWidth;
    #local spHeight = 0.7 * tHeight;
    #local spWidth = 0.1 * absHeight;
    #local spThickness = 0.05 * absHeight;
    #local lTop = yTop - spThickness;
    #local lRadio = spWidth/2;
    #local fHeight = 0.6 * tHeight;
    merge {
        merge {
            RoundedSquare(tWidth - 2*sOffset, tHeight, tThickness)
            BlackDetails(tWidth, tHeight, tThickness, sOffset)
            translate yTop * y
        }
        object {
            Support(spWidth, spHeight, spThickness, lTop, lRadio, fHeight)
            translate (tWidth/2 - spWidth) * x
        }
        object {
            Support(spWidth, spHeight, spThickness, lTop, lRadio, fHeight)
            translate -(tWidth/2 - spWidth) * x
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
        texture { BlackMetal }
    }
#end


#macro Support(spWidth, spHeight, spThickness, lTop, lRadio, fHeight)
    #local fRadio = 1.15 * lRadio;
    merge {
        box {
            <-spWidth/2, -spThickness/2, -spHeight/2>,
            <spWidth/2, spThickness/2, spHeight/2>
            translate (lTop + spThickness/2) * y
        }

        cylinder {
            <0, lTop, 0>,
            <0, 0, 0>,
            lRadio
            translate -(0.2 * spHeight) * z
        }

        difference {
            merge {
                sphere {
                    <0, 0, spHeight/2>, fRadio
                }
                sphere {
                    <0, 0, -spHeight/2>, fRadio
                }
                Connect_Spheres(<0, 0, spHeight/2>, fRadio,
                                <0, 0, -spHeight/2>, fRadio)
            }
            box {
                <-spHeight, 0, fHeight>,
                <spHeight, -lTop, -fHeight>
            }
        }
        texture { BlackMetal }
    }
#end

#macro SupportBoard(bWidth, bHeight, bThickness)

#end

#macro BlackBorders(bWidth, bHeight, bThickness)

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
        SquareTable(1.5, 0.7, 0.02, 0.8)
        texture {
            pigment { White }
        }
        //translate 0.2 * y
        //rotate 90 * y
        //rotate 30 * x
    }
#end
#version 3.7;

#include "colors.inc"
#include "Utils.pov"

#local debugMode = 0;
#if (debugMode)
    global_settings {
        assumed_gamma 1
        charset utf8
    }
#end

// ----------------------------------------
// RoundTable
// ----------------------------------------

#macro RoundTable(tHeight, tRadio, tThickness)
    #local yTop = tHeight / 2;
    #local fLength = 0.9 * tRadio;
    #local fHeight = 0.1 * tHeight;
    #local fThickness = 0.05 * tHeight;
    #local sRadio = tRadio * 0.06;
    #local baseSlope = 5;
    #local offsetHeight = fLength * sin(baseSlope * pi / 180);
    merge {
        cylinder {
            <0, yTop - tThickness, 0>, <0, yTop, 0>, tRadio
        }
        torus {
            tRadio, tThickness / 2
            pigment { Black }
            translate <0, yTop - tThickness/2, 0>
        }
        cylinder {
            <0, yTop - tThickness, 0>, <0, -yTop + offsetHeight, 0>, sRadio
            texture { BlackMetal }
        }
        #for (I, 0, 3)
            box {
                <-fLength/2, -fHeight/2, -fThickness/2>,
                <fLength/2, fHeight/2, fThickness/2>
                texture { BlackMetal }
                rotate baseSlope * z
                translate <-fLength/2 + sRadio, -yTop + offsetHeight, 0>
                rotate (-20 - (I * 90)) * y
            }
        #end
        translate <0, yTop, 0>
    }
#end

// ----------------------------------------
// Scene
// ----------------------------------------

#if (debugMode)
    camera {
      //location <0, 0.38, -4.5>
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

    #local h = 0.8;
    union {
        object {
            RoundTable(h, 0.6, 0.02)
            texture {
                pigment { White }
            }
        }

        box {
            <-0.6, 0, -0.2>,
            <-0.2, h, 0.2>
        }
        translate <0, -1, 1>
    }
#end

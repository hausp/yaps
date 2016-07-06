#version 3.7;

#include "colors.inc"

#local debugMode = 0;
#if (debugMode)
    global_settings {
        assumed_gamma 1
        charset utf8
    }
#end

// ----------------------------------------
// FlyingFourthOfATable
// ----------------------------------------

#macro FlyingFourthOfATable(tHeight, tRadio, tThickness)
    #local totalRadius = tRadio + tThickness;
    difference {
        merge {
            cylinder {
                <0, tHeight - tThickness, 0>, <0, tHeight, 0>, tRadio
            }
            torus {
                tRadio, tThickness / 2
                pigment { Black }
                translate <0, tHeight - tThickness/2, 0>
            }
        }

        box {
            <-totalRadius, tHeight - tThickness - 0.01, -totalRadius>,
            <0, tHeight + tThickness + 0.01, totalRadius>
        }

        box {
            <0, tHeight - tThickness - 0.01, 0>,
            <totalRadius, tHeight + tThickness + 0.01, totalRadius>
        }
    }
#end

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

    #local h = 0.8;
    union {
        object {
            FlyingFourthOfATable(h, 0.6, 0.02)
            texture {
                pigment { White }
            }
        }

        box {
            <-0.2, 0, -0.2>,
            <0.2, h, 0.2>
        }
        translate <0, -1, 1>
    }
#end

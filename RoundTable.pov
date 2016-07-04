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
// Table
// ----------------------------------------
#macro RoundTable(height, radio, thick)
    #local yTop = height / 2;
    #local fHeight = 0.08;
    #local fLength = 0.8 * radio;
    #local fThickness = 0.03;
    #local sRadio = radio * 0.055;
    union {
        cylinder {
            <0, yTop - thick, 0>, <0, yTop, 0>, radio
        }
        torus {
            radio, thick / 2
            texture {
                pigment { Black }
            }
            translate y*(yTop - thick/2)
        }
        cylinder {
            <0, yTop - thick, 0>, <0, -yTop, 0>, sRadio
            texture {
                pigment { Black }
            }
        }
        #for (I, 0, 3)
            box {
                <-fLength/2, -fHeight/2, -fThickness/2>,
                <fLength/2, fHeight/2, fThickness/2>
                texture {
                    pigment { Black }
                }
                rotate 5 * z
                translate (-fLength/2 + sRadio)*x
                translate (-yTop)*y
                rotate (-20 - (I * 90))*y
            }
        #end
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

    object {
        RoundTable(0.8, 0.6, 0.02)
        texture {
            pigment { White }
        }
    }
#end
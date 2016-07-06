#version 3.7;

#include "colors.inc"
#include "textures.inc"

#local debugMode = 0;
#if (debugMode)
    global_settings {
        assumed_gamma 1
        charset utf8
    }
#end

// ----------------------------------------
// Vase
// ----------------------------------------

#macro Vase(vHeight, vRadio, bendOffset, vThickness, vEmptyness)
    #local yt = vHeight / 2;
    #local yb = -yt + bendOffset;
    #local innerRadio = vRadio - vThickness;
    merge {
        difference {
            merge {
                cylinder {
                    <0, yt, 0>, <0, yb, 0>, vRadio
                }
                difference {
                    sphere { <0, yb, 0>, vRadio }
                    box { <-vRadio, -vHeight, -vRadio>, <vRadio, -yt, vRadio> }
                }
            }
            cylinder {
                <0, vHeight, 0>,
                <0, -yt, 0>,
                innerRadio
            }
        }
        cylinder {
            <0, yt - vEmptyness, 0>, <0, yb, 0>, innerRadio
            texture {
                pigment { VeryDarkBrown }
            }
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

    object {
        Vase(0.6, 0.5, 0.2, 0.05, 0.1)
        texture {
            //Brown_Agate scale 0.1
            pigment { DarkBrown }
            normal { bumps 0.4 scale 0.05 }
            finish { phong 1 }
        }
    }
#end

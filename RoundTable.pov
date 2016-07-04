#version 3.7;

#include "colors.inc"
#include "textures.inc"
#include "finish.inc"

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
    #local fLength = 0.8 * tRadio;
    #local fHeight = 0.1 * tHeight;
    #local fThickness = 0.05 * tHeight;
    #local sRadio = tRadio * 0.06;
    merge {
        cylinder {
            <0, yTop - tThickness, 0>, <0, yTop, 0>, tRadio
        }
        torus {
            tRadio, tThickness / 2
            texture {
                pigment { Black }
            }
            translate y*(yTop - tThickness/2)
        }
        cylinder {
            <0, yTop - tThickness, 0>, <0, -yTop, 0>, sRadio
            texture {
                pigment { Black }
                finish {
                    specular 0.7
                    roughness 0.02
                    metallic
                }
            }
        }
        #for (I, 0, 3)
            box {
                <-fLength/2, -fHeight/2, -fThickness/2>,
                <fLength/2, fHeight/2, fThickness/2>
                texture {
                    pigment { Black }
                    finish { 
                        specular 0.7
                        roughness 0.02
                        metallic
                    }
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
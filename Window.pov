#version 3.7;

#include "colors.inc"
#include "shapes.inc"
#include "Utils.pov"

#local debugMode = 0;
#if (debugMode)
    global_settings {
        assumed_gamma 1
    }
#end

#declare WindowGlass =
texture{
    pigment {
        rgbf<0.90,0.90,0.90,0.8>
    }
    finish {
        diffuse 0.1
        reflection 0.02
        specular 0.8
        roughness 0.0003
        phong 1
        phong_size 400
    }
}

// ----------------------------------------
// Window
// ----------------------------------------

#macro Window(winWidth, winHeight, thick, numWindows)
    #local offsetX = numWindows * winWidth / 2;
    union {
        #for (I, 0, numWindows - 1)
            union {
                Frame(
                    <I * winWidth - offsetX, 0, 0>,
                    <(I + 1) * winWidth - offsetX, winHeight, thick>,
                    thick,
                    z
                )
                box {
                    <I * winWidth, 0, thick/3>,
                    <(I + 1) * winWidth, winHeight, 2*thick/3>
                    texture { WindowGlass }
                }
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

    union {
        object {
            Window(0.5, 0.6, 0.02, 4)
            translate y * 0.5
        }

        object {
            Window(0.5, 0.5, 0.02, 4)
        }

        pigment { Gray }
        rotate y * 10
    }
#end

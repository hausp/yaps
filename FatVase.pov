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

#macro Base(vHeight, bRadio, sRadio)`
    sor { 7,
        <0.000000, 0.000000>
        <0.100000, 0.000000>
        <0.200000, 0.540084>
        <0.210970, 0.827004>
        <0.194093, 0.962025>
        <0.286920, 1.000000>
        <0.468354, 1.033755>
    }
#end

// ----------------------------------------
// FatVase
// ----------------------------------------

#macro FatVase(vHeight, bRadio, sRadio, vThickness, vEmptyness)
    #local yTop = vHeight/2;
    #local tsRadio = 0.07 * bRadio;
    merge {
        difference {
            torus {
                bRadio, tsRadio
                translate yTop * y
            }
            box {
                <-(bRadio + tsRadio), yTop + 0.2*tsRadio, -(bRadio + tsRadio)>
                <bRadio + tsRadio, yTop + 0.2*tsRadio + 1, bRadio + tsRadio>
            }
        }
        torus {
            sRadio, bRadio/2
            translate (yTop * 0.7)/2 * y
        }
        cone {
            <0, yTop/16, 0>, bRadio*1.065
            <0, -yTop, 0>, sRadio
        }
        //threshold .65
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
        FatVase(0.6, 0.5, 0.3, 0.05, 0.1)
        //Vase
        texture {
            //Brown_Agate scale 0.1
            pigment { DarkBrown }
            normal { bumps 0.4 scale 0.05 }
            finish { phong 1 }
        }
        //rotate 30*x
    }
#end

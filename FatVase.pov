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
// FatVase
// ----------------------------------------

#macro FatVase(vHeight, bRadio, sRadio)
    #local dx = (bRadio - sRadio)/5;
    #local dy = vHeight/10;
    #local mRadio = bRadio * 0.05;
    merge {
        lathe {
            cubic_spline
            17,
            <0.0000, 0.0000>
            <sRadio+0.0*dx, 0.0000>
            <sRadio+0.5*dx, 0.3*dy>
            <sRadio+1.0*dx, 0.5*dy>
            <sRadio+2.0*dx, 1.0*dy>
            <sRadio+3.0*dx, 1.5*dy>
            <sRadio+3.5*dx, 2.0*dy>
            <sRadio+4.0*dx, 2.5*dy>
            <sRadio+4.5*dx, 3.0*dy>
            <sRadio+5.0*dx, 3.5*dy>
            <sRadio+5.5*dx, 4.0*dy>
            <sRadio+6.0*dx, 4.5*dy>
            <sRadio+6.5*dx, 5.5*dy>
            <sRadio+6.5*dx, 6.5*dy>
            <sRadio+6.0*dx, 7.5*dy>
            <sRadio+4.5*dx, 9.0*dy>
            <sRadio+4.0*dx, 10.0*dy>
        }
        torus {
            bRadio, mRadio
            translate (9*dy) * y
        }
        cone {
            <0, 0, 0>, sRadio
            <0, 0.5*dy, 0>, sRadio+1.0*dx
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
        FatVase(0.6, 0.6, 0.4)
        texture {
            pigment { DarkBrown }
            finish { phong 1 }
        }
    }
#end

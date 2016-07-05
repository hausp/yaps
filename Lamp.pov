#version 3.7;

#include "colors.inc"
#include "shapes.inc"

#local debugMode = 1;
#if (debugMode)
    global_settings {
        assumed_gamma 1
    }
#end

// ----------------------------------------
// Lamp
// ----------------------------------------

#macro Lamp(length, lampRadius, status)
    #local gap = 0.02;
    #local LampBody = union {
        cylinder {
            <-lampRadius - gap/2, 0, -length/2>,
            <-lampRadius - gap/2, 0, length/2>,
            lampRadius
        }

        cylinder {
            <lampRadius + gap/2, 0, -length/2>,
            <lampRadius + gap/2, 0, length/2>,
            lampRadius
        }

        pigment { White }

        finish {
            #if (status)
                ambient 1
            #end
        }
    }

    #if (status)
        light_source {
            <0, 0, 0> color White
            looks_like { LampBody }
        }
    #else
        object { LampBody }
    #end
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

    //light_source { <-1, 2, -2> color White }

    plane {
        y, -1
        texture {
            pigment { checker rgb<0.3, 0.3, 0.3> White }
        }
    }

    object {
        Lamp(0.7, 0.04, 1)
        //rotate y * 90
        translate <-0.5, 0.7, 0>
    }

    object {
        Lamp(0.7, 0.04, 0)
        //rotate y * 90
        translate <0, 0.7, 0>
    }

    object {
        Lamp(0.7, 0.04, 1)
        //rotate y * 90
        translate <0.5, 0.7, 0>
    }

    sphere {
        <-0.7, 0, 0>, 0.3
        pigment { Red }
    }

    sphere {
        <0.7, 0, 0>, 0.3
        pigment { Red }
    }

    sphere {
        <0.7, 0, 2>, 0.3
        pigment { Red }
    }
#end

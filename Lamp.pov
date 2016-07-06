#version 3.7;

#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"

#local debugMode = 0;
#if (debugMode)
    global_settings {
        assumed_gamma 1
    }
#end

// ----------------------------------------
// Lamp
// ----------------------------------------

#macro Lamp(length, lampRadius, intensity, status)
    #local gap = 0.02;
    #local totalWidth = 2 * lampRadius + gap;
    #local bodyHeight = 0.06;
    #local thick = 0.002;
    #local Sheet = difference {
        cylinder {
            <0, 0, -length/2>,
            <0, 0, length/2>,
            lampRadius
        }

        union {
            cylinder {
                <0, 0, -length/2 - 0.01>,
                <0, 0, length/2 + 0.01>,
                lampRadius - thick
            }

            box {
                <-lampRadius, -lampRadius, -length/2 - 0.01>,
                <lampRadius, 0, length/2 + 0.01>
            }

            box {
                <0, 0, -length/2 - 0.01>,
                <lampRadius, lampRadius, length/2 + 0.01>
            }
        }
        pigment { Gray }
        finish {
            reflection 0.5
        }
    }
    #local LampBody = union {
        union {
            cylinder {
                <-totalWidth/2, 0, -length/2>,
                <-totalWidth/2, 0, length/2>,
                lampRadius
            }

            cylinder {
                <totalWidth/2, 0, -length/2>,
                <totalWidth/2, 0, length/2>,
                lampRadius
            }
        
            pigment { White }

            #if (status)
            finish {
                ambient 1
            }
            #end
        }

        prism {
            linear_sweep
            linear_spline
            -length/2,
            length/2,
            5,
            <-totalWidth/2 - lampRadius, -bodyHeight/2>,
            <totalWidth/2 + lampRadius, -bodyHeight/2>,
            <totalWidth/3, bodyHeight/2>,
            <-totalWidth/3, bodyHeight/2>,
            <-totalWidth/2 - lampRadius, -bodyHeight/2>
            rotate <90, 0, 180>
            translate <0, lampRadius + bodyHeight/2, 0>
            pigment { Gray }
        }

        object {
            Sheet
            translate <-3 * lampRadius + 0.02, 0, 0>
        }

        object {
            Sheet
            rotate z * -90
            translate <3 * lampRadius - 0.02, 0, 0>
        }

        union {
            cylinder {
                <-totalWidth/2, 0, -length/2 - 0.001>,
                <-totalWidth/2, 0, -length/2>,
                lampRadius
            }

            cylinder {
                <-totalWidth/2, 0, length/2 + 0.001>,
                <-totalWidth/2, 0, length/2>,
                lampRadius
            }

            cylinder {
                <totalWidth/2, 0, -length/2 - 0.001>,
                <totalWidth/2, 0, -length/2>,
                lampRadius
            }

            cylinder {
                <totalWidth/2, 0, length/2 + 0.001>,
                <totalWidth/2, 0, length/2>,
                lampRadius
            }
            texture { pigment { Gray } }
        }
    }

    #if (status)
        light_source {
            <0, 0, 0> color White * intensity
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
      location <0, 0.7, -1.5>
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
        Lamp(0.7, 0.03, 1, 1)
        //rotate y * 90
        translate <-0.5, 0.7, 0>
    }

    object {
        Lamp(0.7, 0.03, 1, 1)
        //rotate y * 90
        //rotate y * 20
        translate <0, 0.7, 0>
    }

    object {
        Lamp(0.7, 0.03, 1, 1)
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

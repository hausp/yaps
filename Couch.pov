#version 3.7;

#include "colors.inc"
#include "shapes.inc"

#local debugMode = 1;
#if (debugMode)
    global_settings {
        assumed_gamma 1
        charset utf8
    }
#end

// ----------------------------------------
// Couch
// ----------------------------------------

#macro Couch(cWidth, cHeight, cLength, supRadius, supThickness, seatHeight, seatThickness, backThickness)
    #local totalWidth = cWidth + 2 * supThickness;
    #local totalSupRadius = supRadius + supThickness/2;
    #local backRadius = 0.07;
    #local feetWidth = cWidth / 12;
    #local feetThickness = cLength / 8;
    #local halfTorus = difference {
        torus {
            supRadius, supThickness/2
        }

        box {
            <0, -totalSupRadius, -totalSupRadius>
            <totalSupRadius, totalSupRadius, totalSupRadius>
        }
    }

    #local support = union {
        object {
            halfTorus
        }

        cylinder {
            <0, 0, supRadius>,
            <cHeight/2, 0, supRadius>,
            supThickness/2
        }

        cylinder {
            <0, 0, -supRadius>,
            <cHeight/2, 0, -supRadius>,
            supThickness/2
        }
        rotate x * -90
        rotate z * -90
        rotate y * 90
        translate <0, cHeight/2, 0>
    }

    difference {
        union {
            // Left Back
            object {
                Round_Box(
                    <-totalWidth/2, seatHeight, (cLength - backThickness)/2>,
                    <0, cHeight, cLength/2>,
                    backRadius, 0
                )
            }

            // Right Back
            object {
                Round_Box(
                    <0, seatHeight, (cLength - backThickness)/2>,
                    <totalWidth/2, cHeight, cLength/2>,
                    backRadius, 0
                )
            }

            // Seat
            box {
                <-totalWidth/2, 0, -cLength/2>,
                <totalWidth/2, seatHeight, cLength/2>
            }

            // Left Support
            object {
                support
                translate <(-totalWidth - supThickness)/2, 0, 0>
            }

            // Right Support
            object {
                support
                translate <(totalWidth + supThickness)/2, 0, 0>
            }        
        }

        box {
            <-totalWidth/2 + feetWidth, 0, -cLength/2 - 0.01>,
            <totalWidth/2 - feetWidth, seatHeight - seatThickness, cLength/2 + 0.01>
        }

        box {
            <-totalWidth/2 - 0.01, 0, -cLength/2 + feetThickness>,
            <totalWidth/2 + 0.01, seatHeight - seatThickness, cLength/2 - feetThickness>
        }

        pigment { rgb<0, 0, 0.1> }
    }
#end

// ----------------------------------------
// Scene
// ----------------------------------------

#if (debugMode)
    camera {
      location <0, 1, -2.5>
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

    #local h = 2;
    union {
        object {
            Couch(2.7, h, 1.1, 0.5, 0.17, h/2, 0.3, 0.6)
            rotate y * 20
        }

        /*box {
            <-1.2, 0, -0.2>,
            <-0.8, h, 0.2>
        }*/
        translate <0, -1, 1>
    }
#end

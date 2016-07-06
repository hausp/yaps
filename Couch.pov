#version 3.7;

#include "colors.inc"
#include "shapes.inc"
#include "Utils.pov"

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
    #local halfTorus = difference {
        torus {
            supRadius, supThickness/2
        }

        box {
            <0, -totalSupRadius, -totalSupRadius>
            <totalSupRadius, totalSupRadius, totalSupRadius>
        }
    }

    #local support = difference {
        union {
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

            cylinder {
                <cHeight/2, 0, -supRadius>,
                <cHeight/2, 0, supRadius>,
                supThickness/2
            }
        }

        box {
            <cHeight/2, -supThickness/2 - 0.01, -supRadius - 0.01>
            <cHeight/2 + supThickness/2, supThickness/2 + 0.01, supRadius + 0.01>
        }

        rotate x * -90
        rotate z * -90
        rotate y * 90
        translate <0, cHeight/2, 0>
    }

    #local partialSupport = difference {
        object {
            support
        }

        box {
            <-supThickness/2, seatHeight - seatThickness + 0.01, -cLength/2 - totalSupRadius>,
            <supThickness/2, cHeight, cLength/2 + totalSupRadius>
        }
    }

    union {
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
            }

            box {
                <-totalWidth/2 - 0.01, 0, -cLength/2 - 0.01>,
                <totalWidth/2 + 0.01, seatHeight - seatThickness, cLength/2 + 0.01>
            }
            pigment { rgb<0, 0, 0.02> }
        }

        // Left Support
        union {
            object {
                support
                translate <(-totalWidth - supThickness)/2, 0, 0>
            }

            // Middle Support
            object {
                partialSupport
            }

            // Right Support
            object {
                support
                translate <(totalWidth + supThickness)/2, 0, 0>
            }
            texture { BlackMetal }
        }
    }
#end

// ----------------------------------------
// Scene
// ----------------------------------------

#if (debugMode)
    camera {
      location <0, 0, -2.5>
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

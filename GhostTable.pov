#version 3.7;

#include "colors.inc"
#include "shapes.inc"
#include "Utils.pov"

#local debugMode = 0;
#if (debugMode)
    global_settings {
        assumed_gamma 1
        charset utf8
    }
#end

// ----------------------------------------
// GhostTable
// ----------------------------------------
#macro GhostTable(tWidth, tHeight, tThickness, absHeight, baseRadius)
    #local yTop = absHeight - tThickness;
    #local sOffset = 0.001 * tWidth;
    #local spThickness = 0.05 * absHeight;
    #local border = 0.1;
    #local padding = (tHeight - border)/2;
    #local barHeight = absHeight / 10;
    #local barThickness = 0.05;
    #local baseCylinder = cylinder {
        <0, 0, 0>,
        <0, yTop, 0>,
        baseRadius
    }

    union {
        object {
            RoundedSquare(tWidth - 2 * sOffset, tHeight, tThickness)
            translate <0, yTop, 0>
            pigment { White } 
        }

        union {
            object {
                baseCylinder
                translate <-tWidth/2 + border, 0, padding>
            }

            object {
                baseCylinder
                translate <tWidth/2 - border - baseRadius, 0, padding>
            }

            object {
                baseCylinder
                translate <-tWidth/2 + border, 0, -padding>
            }

            object {
                baseCylinder
                translate <tWidth/2 - border - baseRadius, 0, -padding>
            }

            box {
                <-tWidth/2 - barThickness/2 + 2 * baseRadius, absHeight/2 - barHeight/2, -tHeight/2 + baseRadius>,
                <-tWidth/2 + barThickness/2 + 2 * baseRadius, absHeight/2 + barHeight/2, tHeight/2 - baseRadius>
            }

            box {
                <tWidth/2 - 2 * baseRadius - barThickness/2, absHeight/2 - barHeight/2, -tHeight/2 + baseRadius>,
                <tWidth/2 - 2 * baseRadius + barThickness/2, absHeight/2 + barHeight/2, tHeight/2 - baseRadius>
           }

            box {
                <-tWidth/2 + 2 * baseRadius, absHeight/2 - barHeight/2, -barThickness/2>,
                <tWidth/2 - 2 * baseRadius, absHeight/2 + barHeight/2, barThickness/2>
            }

            texture { BlackMetal }
        }
    }
#end

#macro RoundedSquare(tWidth, tHeight, tThickness)
    #local radio = tThickness * 0.8;
    #local radioOffset = tThickness * 0.2;
    union {
        box {
            <-tWidth/2, 0, -tHeight/2>,
            <tWidth/2, tThickness, tHeight/2>
        }
        difference {
            union {
                cylinder {
                    <-tWidth/2, radioOffset, -tHeight/2>,
                    <tWidth/2, radioOffset, -tHeight/2>,
                    radio
                }
                cylinder {
                    <-tWidth/2, radioOffset, tHeight/2>,
                    <tWidth/2, radioOffset, tHeight/2>,
                    radio
                }
            }
            box {
                <-tWidth, 0, -tHeight>,
                <tWidth, -tThickness, tHeight>
            }
        }
    }
#end

// ----------------------------------------
// Scene
// ----------------------------------------

#if (debugMode)
    camera {
      //location <0.5, 0, -2.5>
      location <0, 0.5, -2.5>
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

    #local h = 0.8;
    union {
        object {
            GhostTable(1.5, 0.7, 0.03, h, 0.06)
            rotate y * -30
        }

        /*box {
            <-0.6, 0, -0.2>,
            <-0.2, h, 0.2>
        }*/
        translate <0, -1, 1>
    }
#end

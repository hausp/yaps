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
// Monitor
// ----------------------------------------
#macro Monitor(screenWidth, screenHeight, screenThickness, baseX, baseY, baseZ, neckHeight, neckRadius)
    #local ang = 20;

    union {
        union {
            box {
                <-baseX/2, 0, -baseZ/2>,
                <baseX/2, baseY, baseZ/2>
            }

            cylinder {
                <0, baseY, 0>,
                <0, baseY + neckHeight, 0>,
                neckRadius
            }

            finish {
                reflection 0.02        
            }
        }

        union {
            box {
                <-screenWidth/2 + 0.01, -screenHeight/2 + 0.01, -screenThickness/2>,
                <screenWidth/2 - 0.01, screenHeight/2 - 0.01, screenThickness/2>
            }

            object {
                Frame(
                    <-screenWidth/2, -screenHeight/2, -screenThickness/2 - 0.005>,
                    <screenWidth/2, screenHeight/2, -screenThickness/2>,
                    screenThickness
                )
                //Frame(screenWidth, screenHeight, screenThickness, 0.0025)
                pigment { rgb<0.4, 0.4, 0.4> }
                //translate <0, 0, -screenThickness/2 - 0.0025>
            }

            rotate x * ang
            translate y * (baseY + neckHeight + screenHeight/6)
        }

        finish {
            phong 0.9
            phong_size 60
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

    light_source { <-1, 3, -2> color White }

    plane {
        y, -1
        texture {
            pigment { checker rgb<0.3, 0.3, 0.3> White }
        }
    }

    object {
        Monitor(0.8, 0.5, 0.05, 0.8, 0.02, 0.5, 0.5, 0.04)
        //rotate y * 45
        scale 1.5
        translate <0, -1, 1.5>
    }

#end

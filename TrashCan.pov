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
// Trash Can
// ----------------------------------------
#macro TrashCan(height, upperRadius, lowerRadius, thick, gridWidth, numVerticalStripes)
    #local gridLength = sqrt(pow(height, 2) + pow(upperRadius - lowerRadius, 2));
    #local gridAngle = atan2(upperRadius - lowerRadius, height);
    #local gridAngleDeg = gridAngle * 180 / pi;
    #local deltaTheta = 360 / numVerticalStripes;
    #local baseX = 0;
    #local baseY = 0;
    #local baseZ = 0.005 - lowerRadius;

    union {
        torus {
            upperRadius, thick/2
            translate y * height
        }

        cone {
            <0, 0, 0>, lowerRadius,
            <0, height/5, 0>, (4 * lowerRadius + upperRadius) / 5
        }

        #for (I, 0, numVerticalStripes - 1)
            #local currAngle = deltaTheta * I;
            #local sinTheta = sin(currAngle * pi / 180);
            #local cosTheta = cos(currAngle * pi / 180);
            #local translX = cosTheta * baseX + sinTheta * baseZ;
            #local translY = 0;
            #local translZ = -sinTheta * baseX + cosTheta * baseZ;
            box {
                <-gridWidth/2, 0, 0>
                <gridWidth/2, gridLength, 0>
                rotate <-gridAngleDeg, 0, 0>
                rotate <0, currAngle, 0>
                translate <translX, translY, translZ>                
            }
        #end
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

    object {
        TrashCan(0.8, 0.5, 0.3, 0.05, 0.02, 35)
        pigment { Orange }
        //translate <0, -1, 1>
        //translate <-0.8, 0, 2>
    }

#end

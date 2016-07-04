#version 3.7;

#include "colors.inc"
#include "shapes.inc"

#local debugMode = 0;
#if (debugMode)
    global_settings {
        assumed_gamma 1
        charset utf8
    }
#end

// ----------------------------------------
// Trash Can
// ----------------------------------------
#macro TrashCan(height, upperRadius, lowerRadius, thick, stripeWidth, numVerticalStripes, numHorizontalStripes)
    #local deltaRadius = upperRadius - lowerRadius;
    #local gridLength = sqrt(pow(height, 2) + pow(deltaRadius, 2));
    #local gridAngle = atan2(deltaRadius, height);
    #local gridAngleDeg = gridAngle * 180 / pi;
    #local deltaTheta = 360 / numVerticalStripes;
    #local baseX = 0;
    #local baseY = 0;
    #local baseZ = 0.005 - lowerRadius;
    #local bottomHeightFrac = 1 / 5;
    #local bottomHeight = height * bottomHeightFrac;
    #local bodyHeightFrac = 1 - bottomHeightFrac;
    #local bodyHeight = height - bottomHeight;
    #local horizStripeInterval = bodyHeight / (numHorizontalStripes + 1);
    #local baseUpperRadius = upperRadius * bottomHeightFrac + lowerRadius * bodyHeightFrac;

    union {
        torus {
            upperRadius, thick/2
            translate y * height
        }

        cone {
            <0, 0, 0>, lowerRadius,
            <0, bottomHeight, 0>, baseUpperRadius
        }

        #for (I, 0, numHorizontalStripes - 1)
            #local stripeLowerY = (I + 1) * horizStripeInterval + bottomHeight;
            #local stripeUpperY = stripeLowerY + stripeWidth;
            #local lowerFrac = stripeLowerY / height;
            #local upperFrac = stripeUpperY / height;
            #local stripeLowerRadius = upperRadius * lowerFrac + lowerRadius * (1 - lowerFrac);
            #local stripeUpperRadius = upperRadius * upperFrac + lowerRadius * (1 - upperFrac);
            cone {
                <0, stripeLowerY, 0>, stripeLowerRadius,
                <0, stripeUpperY, 0>, stripeUpperRadius
                open
            }
        #end

        #for (I, 0, numVerticalStripes - 1)
            #local currAngle = deltaTheta * I;
            #local sinTheta = sin(currAngle * pi / 180);
            #local cosTheta = cos(currAngle * pi / 180);
            #local translX = cosTheta * baseX + sinTheta * baseZ;
            #local translY = 0;
            #local translZ = -sinTheta * baseX + cosTheta * baseZ;
            box {
                <-stripeWidth/2, 0, 0>
                <stripeWidth/2, gridLength, 0>
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
      location <0, 1, -1.5>
      look_at <0, 0, 1>
    }

    background { White * 0.5 }

    light_source { <-1, 2, -20> color White }

    plane {
        y, -1
        texture {
            pigment { checker rgb<0.3, 0.3, 0.3> White }
        }
    }

    object {
        TrashCan(0.8, 0.5, 0.4, 0.035, 0.02, 35, 4)
        pigment { Orange }
        //translate <0, -1, 1>
        //translate <-0.8, 0, 2>
    }

#end

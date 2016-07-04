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
// MobileOnWheels
// ----------------------------------------
#macro FourthOfATorus(minorRadius, majorRadius)
    #local totalRadius = minorRadius + majorRadius;
    difference {
        torus {
            majorRadius, minorRadius
        }

        union {
            box {
                <-totalRadius, -minorRadius - 0.01, -totalRadius - 0.01>,
                <totalRadius, minorRadius + 0.01, 0.01>
            }

            box {
                <0, -minorRadius - 0.01, -0.01>,
                <totalRadius, minorRadius + 0.01, totalRadius + 0.01>
            }            
        }
    }
#end

#macro supportBar(minorRadius, majorRadius, barLength)
    #local totalRadius = minorRadius + majorRadius;
    union {
        object {
            FourthOfATorus(minorRadius, majorRadius)
            translate <-barLength + totalRadius, minorRadius, -majorRadius>
        }

        cylinder {
            <-barLength + totalRadius, 0, 0>,
            <barLength - totalRadius, 0, 0>,
            minorRadius
            translate <0, minorRadius, 0>
        }

        object {
            FourthOfATorus(minorRadius, majorRadius)
            rotate y * 90
            translate <barLength - totalRadius - 0.01, minorRadius, -majorRadius>
        }    
    }
#end

#macro MobileOnWheels(mWidth, height, length, wheelRadius, wheelThickness, sideThickness)
    #local border = 0.1;
    #local halfW = mWidth / 2;
    #local halfL = length / 2;
    #local heightHole1 = height * 0.25;
    #local heightHole2 = height * 0.35;
    #local minorRadius = 0.03;
    #local majorRadius = 0.5;
    #local totalRadius = minorRadius + majorRadius;
    #local barLength = length - 2 * border;
    #local Wheel = cylinder {
        <0, -wheelThickness/2, 0>,
        <0, wheelThickness/2, 0>,
        wheelRadius
        rotate z * 90
    }

    union {
        object {
            supportBar(minorRadius, majorRadius, barLength)
            rotate y * 90
            translate <halfW + totalRadius, height - 2 * border, 0>
            pigment { Gray }
        }

        object {
            Wheel
            translate <-halfW + border, wheelRadius, -halfL + border>
        }

        object {
            Wheel
            translate <-halfW + border, wheelRadius, halfL - border>
        }

        object {
            Wheel
            translate <halfW - border, wheelRadius, -halfL + border>
        }

        object {
            Wheel
            translate <halfW - border, wheelRadius, halfL - border>
        }

        difference {
            box {
                <-halfW, 2 * wheelRadius, -halfL>,
                <halfW, 2 * wheelRadius + height, halfL>
                //pigment { Blue }
            }

            #local upperY1 = 2 * wheelRadius + height + 0.01;
            #local lowerY1 = upperY1 - heightHole1;
            #local upperY2 = lowerY1 - sideThickness;
            #local lowerY2 = upperY2 - heightHole2;
            #local upperY3 = lowerY2 - sideThickness;
            #local lowerY3 = 2 * wheelRadius + sideThickness;
            union {
                box {
                    <-halfW + sideThickness, lowerY1, -halfL - 0.01>,
                    <halfW - sideThickness, upperY1, halfL - sideThickness>
                }

                box {
                    <-halfW + sideThickness, lowerY2, -halfL - 0.01>,
                    <halfW - sideThickness, upperY2, halfL - sideThickness>    
                }

                box {
                    <-halfW + sideThickness, lowerY3, -halfL - 0.01>,
                    <halfW - sideThickness, upperY3, halfL - sideThickness>    
                }
                //pigment { Yellow }
            }

            pigment { Blue }
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

    object {
        MobileOnWheels(1, 1.6, 1, 0.1, 0.05, 0.05)
        //FourthOfATorus(0.1, 0.4)
        rotate y * 90
        //rotate x * 90
        translate <0, -1, 1>
    }

#end

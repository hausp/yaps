#version 3.7;

global_settings {
    assumed_gamma 1
    charset utf8
}

#include "Chair.pov"
#include "FatVase.pov"
#include "Lamp.pov"
#include "MobileOnWheels.pov"
#include "Monitor.pov"
#include "ReservedTableSign.pov"
#include "RoundTable.pov"
#include "SquareTable.pov"
#include "TrashCan.pov"
#include "Window.pov"

#local winHeightRow1 = 1.5;
#local winHeightRow2 = 4;
#local winHeightRow3 = 2.8;
#local winWidth = 2.5;
#local winBorderRadius = 0.1;
#local numWindows = 12;
#local chairScaling = 1.5;
#local offsetZ = -100;
#local numCeilingRows = 15;
#local numCeilingColumns = 9;
#local ceilingStripeWidth = 3.5;
#local ceilingStripeHeight = 1;
#local ceilingStripeOffsetX = numCeilingColumns * ceilingStripeWidth / 2;
#local ceilingStripeOffsetZ = numCeilingRows * ceilingStripeHeight / 2;
#local p1 = <-ceilingStripeWidth/2, -0.3, -ceilingStripeHeight/2>;
#local p2 = -p1;
#local cy = winHeightRow2 + winHeightRow3;
#local lampRadius = 0.07;
#local lampLength = 1.6;
#local lampIntensity = 0.15;

camera {
    //location <0, 1, -1.5>
    //look_at <0, 1, 1>
    location <-3.8, 0.3, offsetZ>
    look_at <9, 0, 1>
}

background { White * 0.5 }

//light_source { <-3, 4, 4 + offsetZ> color White }

// Floor
plane {
    y, -1
    texture {
        pigment { checker rgb<0.8, 0.8, 0.8> White }
    }
}

// Window
union {
    // Outside world
    box {
        <-100, 0, 2 * winBorderRadius>,
        <100, 2 * (winHeightRow1 + winHeightRow2 + winHeightRow3), 2 * winBorderRadius + 1>
        texture {
            pigment { rgb<0, 0.5, 1> }
        }
    }

    object {
        Window(winWidth, winHeightRow1, winBorderRadius, numWindows)
        translate y * (winHeightRow2 + winHeightRow3)
    }

    object {
        Window(winWidth, winHeightRow2, winBorderRadius, numWindows)
        translate y * winHeightRow3
    }

    object {
        Window(winWidth, winHeightRow3, winBorderRadius, numWindows)
    }

    pigment { Gray }
    translate <0, -1, 20 + offsetZ>
}

// Ceiling
union {
    plane {
        y, cy
        pigment { Gray }
    }

    // Ceiling stripes
    union {
        #for (I, 0, numCeilingRows - 1)
            #for (J, 0, numCeilingColumns - 1)
                object {
                    Frame(p1, p2, 0.02, y)
                    translate <J * ceilingStripeWidth - ceilingStripeOffsetX, 0, I * ceilingStripeHeight - ceilingStripeOffsetZ>
                }
            #end
        #end
        //rotate y * -10
        translate <0, cy + 0.28, 16 + offsetZ>
        texture { Chrome_Metal }
    }

    #local x1 = -7;
    #local x2 = 0;
    #local x3 = 6;
    // Lamps
    union {
        object {
            Lamp(lampLength, lampRadius, lampIntensity, 0)
            translate <x1, 0, 19>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 1)
            translate <x1, 0, 17>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 1)
            translate <x1, 0, 15>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 1)
            translate <x1, 0, 13>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 0)
            translate <x2, 0, 19>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 1)
            translate <x2, 0, 17>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 0)
            translate <x2, 0, 15>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 1)
            translate <x2, 0, 13>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 0)
            translate <x3, 0, 19>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 1)
            translate <x3, 0, 17>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 1)
            translate <x3, 0, 15>
        }

        object {
            Lamp(lampLength, lampRadius, lampIntensity, 1)
            translate <x3, 0, 13>
        }
        translate <0, cy - lampRadius - 0.1, offsetZ>
    }
}

// Chairs
object {
    Chair
    scale chairScaling
    rotate y * 50
    translate <-4, -1, 8 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * -120
    translate <-3.5, -1, 5 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * 150
    translate <-2.5, -1, 5 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * -30
    translate <-3.2, -1, 6 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * 60
    translate <-2.6, -1, 5.7 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * 180
    translate <0.2, -1, 9 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * 170
    translate <1.2, -1, 9 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * 80
    translate <4, -1, 11 + offsetZ>
}

object {
    Chair
    scale chairScaling
    rotate y * 80
    translate <4, -1, 10 + offsetZ>
}

// Tables
object {
    RoundTable(0.8, 0.6, 0.05)
    pigment { White }
    rotate y * 10
    scale 1.2
    translate <-3, -0.46, 5 + offsetZ>
}

object {
    SquareTable(2, 0.5, 0.06, 1)
    pigment { White }
    translate <0.5, -1, 9.5 + offsetZ>
}

// Sign
object {
    Sign
    rotate y * -15
    scale 0.8
    translate <-3, 0.02, 5 + offsetZ>
}

// Trash Cans
object {
    TrashCan(0.8, 0.4, 0.3, 0.035, 0.02, 35, 4)
    pigment { Orange }
    scale 0.7
    translate <-5, -1, 8.5 + offsetZ>
}

object {
    TrashCan(0.8, 0.5, 0.4, 0.035, 0.02, 35, 10)
    pigment { Yellow }
    scale 0.5
    translate <2, -1, 9 + offsetZ>
}

// Monitors
object {
    Monitor(0.8, 0.5, 0.05, 0.8, 0.02, 0.5, 0.5, 0.04)
    rotate y * 60
    scale 1.5
    translate <-7.5, 0, 10 + offsetZ>
}

object {
    Monitor(0.8, 0.5, 0.05, 0.8, 0.02, 0.5, 0.5, 0.04)
    rotate y * 90
    scale 1.5
    translate <1.2, 0, 11 + offsetZ>
}

// Mobile on Wheels
object {
    MobileOnWheels(1, 1.6, 1.2, 0.1, 0.05, 0.05)
    rotate y * 80
    //rotate x * 90
    translate <6, -1, 12 + offsetZ>
}

// Vases
object {
    FatVase(0.8, 0.5, 0.3)
    texture {
        pigment { DarkBrown }
        finish { phong 1 }
    }
    translate <-4, -1, 12 + offsetZ>
}

#version 3.7;

global_settings {
    assumed_gamma 1
    charset utf8
}

#include "transforms.inc"

#include "Chair.pov"
#include "Couch.pov"
#include "FatVase.pov"
#include "FlyingFourthOfATable.pov"
#include "GhostTable.pov"
#include "Lamp.pov"
#include "MobileOnWheels.pov"
#include "Monitor.pov"
#include "ReservedTableSign.pov"
#include "RoundTable.pov"
#include "SquareTable.pov"
#include "TrashCan.pov"
#include "Window.pov"


#declare roomHeight = 3.10;
#declare roomWidth = 70;
#declare roomDepth = 75;

#declare Camera_Location = <8.66, 1.4, roomDepth/2 - 18.5>;
#declare Camera_Look_At  = <14.46, 2.25, roomDepth/2>;
#declare Camera_Angle    =  30;

#local winHeightRow1 = 0.60;
#local winHeightRow2 = 1.53;
#local winHeightRow3 = 1.30;
#local winBorderRadius = 0.07;
#local winWidth = 1;
#local numWindows = (roomWidth + 2 * winBorderRadius) / winWidth;
#local lampRadius = 0.03;
#local lampLength = 1;
#local lampIntensity = 0.15;
#local tableHeight = 0.8;

/*
#declare Cam_V = Camera_Look_At - Camera_Location;
#declare Cam_Ho = sqrt(pow(Cam_V.x,2)+pow(Cam_V.z ,2));
#declare Cam_Y  = Camera_Look_At.y - Camera_Location.y;
//--------------------------------------------------//
camera{ angle Camera_Angle
        right x*image_width/image_height
        location<0,Camera_Look_At.y,-Cam_Ho>
        matrix<1,0,0, 0,1,0, 0,Cam_Y/Cam_Ho,1, 0,0,0>
        Reorient_Trans(z,<Cam_V.x,0,Cam_V.z>)
        translate<Camera_Look_At.x,0,Camera_Look_At.z>
      } //------------------------------------------//
*/
camera {
    location Camera_Location
    right x*image_width/image_height
    look_at Camera_Look_At
    angle Camera_Angle
}

background { rgb<135/255, 206/255, 250/255>
    //Blue
}

light_source {
    <15, roomHeight + 50, roomDepth/2 + 50>
    color White * 0.20
    looks_like {
        sphere {
            <0,0,0>, 20
        }
    }
}

// Room
difference {
    // outer box
    box {
        <-(roomWidth/2 + 0.10), -0.10, -(roomDepth/2 - 0.10)>,
        <(roomWidth/2 + 0.10), roomHeight + 0.10, (roomDepth/2 + 0.05)>
    }
    // inner box
    box {
        <-roomWidth/2, 0, -roomDepth/2>,
        <roomWidth/2, roomHeight, roomDepth/2>
    }
    // windows box
    box {
        <-roomWidth/2, 0, roomDepth/2 + 5>,
        <roomWidth/2, roomHeight, roomDepth/2>
    }
    // That can be ceil color
    texture { pigment { Grey } }
}

// Ceiling
union {
    #local csWidth = 1.20;
    #local csHeight = 0.7;
    #local nRows = ceil(roomWidth/csWidth);
    #local nColumns = ceil(roomDepth/csHeight);

    #for (I, 0, nRows)
        box {
            <roomWidth/2 - I * csWidth, roomHeight, -roomDepth/2>,
            <roomWidth/2 - I * csWidth + 0.02, roomHeight - 0.0001, roomDepth/2>
        }
    #end
    #for (I, 0, nColumns)
        box {
            <-roomWidth/2, roomHeight, roomDepth/2 - I * csHeight>,
            <roomWidth/2, roomHeight - 0.0001, roomDepth/2 - I * csHeight + 0.02>
        }
    #end
    texture { Aluminum }
}

// Floor
union {
    #local fSize = 0.45;
    difference {
        box {
            <-roomWidth/2, 0, -roomDepth/2>,
            <roomWidth/2, 0.05, roomDepth/2>
        }

        // horizontal stripes
        #for (I, 0, ceil(roomWidth/fSize))
            box {
                <roomWidth/2 - I * fSize, 0.06, -roomDepth/2>,
                <roomWidth/2 - I * fSize + 0.02, 0, roomDepth/2>
            }
        #end
        // vertical stripes
        #for (I, 0, ceil(roomDepth/fSize))
            box {
                <-roomWidth/2, 0.06, roomDepth/2 - I * fSize>,
                <roomWidth/2, 0, roomDepth/2 - I * fSize + 0.02>
            }
        #end

        texture {
            pigment {
                rgb<122/255, 113/255, 98/255>
            }
        }

        finish {
            crand 0.1
        }
    }
    // horizontal stripes
    #for (I, 0, ceil(roomWidth/fSize))
        box {
            <roomWidth/2 - I * fSize, 0.048, -roomDepth/2>,
            <roomWidth/2 - I * fSize + 0.02, 0, roomDepth/2>
            texture { pigment { Black } }
        }
    #end
    // vertical stripes
    #for (I, 0, ceil(roomDepth/fSize))
        box {
            <-roomWidth/2, 0.048, roomDepth/2 - I * fSize>,
            <roomWidth/2, 0, roomDepth/2 - I * fSize + 0.02>
            texture { pigment { Black } }
        }
    #end
}

// Window
union {
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
    finish { metallic }
    translate <0, 0, roomDepth/2 + 0.15 - winBorderRadius>
}

// Lamps
#local x1 = 10.85;
#local x2 = 13.00;
#local x3 = 15;
#local x4 = 17.8;
union {
    object {
        Lamp(lampLength, lampRadius, lampIntensity, 0)
        translate <x1, 0, 36>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x1, 0, 34>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x1, 0, 32>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x1, 0, 30>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x1, 0, 27.5>
    }


    object {
        Lamp(lampLength, lampRadius, lampIntensity, 0)
        translate <x2, 0, 36>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x2, 0, 32>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 0)
        translate <x2, 0, 30>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x2, 0, 27.5>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x2, 0, 25.35>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 0)
        translate <x3, 0, 36>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x3, 0, 34>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x3, 0, 31.6>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x3, 0, 29.6>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 0)
        translate <x4, 0, 36>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x4, 0, 34>
    }

    translate <0, roomHeight - lampRadius - 0.05, 0>
}

// Chairs
union {
    object {
        Chair
        rotate y * 75
        scale 1.06
        translate <12.03, 0.048, 29.8>
    }

    object {
        Chair
        rotate y * -105
        scale 1.06
        translate <11.23, 0.048, 29.7>
    }

    object {
        Chair
        rotate y * 160
        scale 1.06
        translate <11.9, 0.048, 29.3>
    }

    object {
        Chair
        rotate y * -30
        scale 1.06
        translate <11.57, 0.048, 30>
    }

    object {
        Chair
        rotate y * 30
        scale 1.06
        translate <12.6, 0.048, 35.5>
    }

    object {
        Chair
        rotate y * 200
        scale 1.06
        translate <10.1, 0.048, 33.55>
    }

    object {
        Chair
        rotate y * 150
        scale 1.06
        translate <10.66, 0.048, 33.55>
    }

    object {
        Chair
        rotate y * 180
        scale 1.06
        translate <13.7, 0.048, 32.2>
    }

    object {
        Chair
        rotate y * 170
        scale 1.06
        translate <14.5, 0.048, 32.2>
    }

    object {
        Chair
        rotate y * 90
        scale 1.06
        translate <16.25, 0.048, 34.1>
    }

    object {
        Chair
        rotate y * 90
        scale 1.06
        translate <16.40, 0.048, 33.45>
    }
}

// Sign
object {
    Sign
    rotate y * -20
    scale 0.6
    translate <11.67, 0.05 + tableHeight, 29.7>
}

// Right fourth of a table
object {
    FlyingFourthOfATable(tableHeight, 0.615, 0.02)
    pigment { White }
    translate <14.9415, 0.0501, 33.0015>
}

// Left fourth of a table
object {
    FlyingFourthOfATable(tableHeight, 0.615, 0.02)
    pigment { White }
    translate <10.797, 0.0501, 34.305>
}

// Center Table
object {
    RoundTable(tableHeight, 0.6, 0.04)
    pigment { White }
    rotate y * 5
    translate <11.72, 0.05, 29.7>
}

// Right Tables
object {
    SquareTable(1.5, 0.6, 0.02, tableHeight)
    pigment { White }
    translate <14.20, 0.05, 32.7>
}

object {
    SquareTable(1.5, 0.6, 0.02, tableHeight)
    pigment { White }
    rotate -90 * y
    translate <15.25, 0.05, 33.75>
}    

object {
    SquareTable(1.5, 0.6, 0.02, tableHeight)
    pigment { White }
    rotate 90 * y
    translate <16.15, 0.05, 33.75>
}

// Left Tables
object {
    SquareTable(1.5, 0.6, 0.02, tableHeight)
    pigment { White }
    rotate -90 * y
    translate <9.5, 0.05, 35.25>
}

object {
    SquareTable(1.2, 0.6, 0.02, tableHeight)
    pigment { White }
    translate <10.2, 0.05, 34.00>
}

object {
    SquareTable(1.5, 0.6, 0.02, tableHeight)
    pigment { White }
    rotate -90 * y
    translate <11.102, 0.05, 35.05>
}

object {
    RoundTable(tableHeight, 0.5, 0.02)
    pigment { White }
    //rotate y * 10
    translate <11.91, 0.05, 35.25>
}

// Trash Cans
object {
    TrashCan(0.8, 0.4, 0.3, 0.035, 0.02, 35, 4)
    pigment { Orange }
    scale 0.4
    translate <11.7, 0.05, 34.80>
}

object {
    TrashCan(0.8, 0.4, 0.3, 0.035, 0.02, 35, 10)
    pigment { Yellow }
    scale 0.3
    translate <15.20, 0.05, 32.7>
}

// Monitors
object {
    Monitor(0.8, 0.5, 0.05, 0.8, 0.02, 0.5, 0.3, 0.04)
    rotate y * 90
    scale 0.666
    translate <9.5, 0.05 + tableHeight, 35.25>
}

object {
    Monitor(0.8, 0.5, 0.05, 0.8, 0.02, 0.5, 0.3, 0.04)
    rotate y * 90
    scale 0.666
    translate <15.25, 0.05  + tableHeight, 33.75>
}

// Mobile on Wheels
object {
    MobileOnWheels(0.7, 0.9, 0.6, 0.08, 0.05, 0.05)
    rotate y * 80
    translate <18.5, 0.05, 36.8>
}

// Vases
object {
    FatVase(0.36, 0.23, 0.1)
    texture {
        pigment { DarkBrown }
        finish { phong 1 }
    }
    translate <13.12, 0, 37>
}

object {
    FatVase(0.45, 0.23, 0.1)
    pigment { Green }
    translate <12.13, 0, 34.85>
}

// Couch
object {
    //Couch(0.5, 2, 1.1, 0.5, 0.17, 1, 0.3, 0.6)
    Couch(2.3, 2, 1.1, 0.5, 0.17, 1, 0.3, 0.6)
    scale 0.5
    translate <14.2, 0, 37>
}

// Ghost Table
object {
    GhostTable(1.3, 0.4, 0.03, 0.52, 0.06)
    translate <14, 0, 35>
}

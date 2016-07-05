#version 3.7;

global_settings {
    assumed_gamma 1
    charset utf8
}

#include "transforms.inc"

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


#declare roomHeight = 3.0;
#declare roomWidth = 75;
#declare roomDepth = 75;

#declare Camera_Location = <9.7, 1.6, roomDepth/2 - 17.8>;
#declare Camera_Look_At  = <14.7, 2, roomDepth/2>;
#declare Camera_Angle    =  30;

#local winHeightRow1 = 0.6;
#local winHeightRow2 = 1.8;
#local winHeightRow3 = 0.8;
#local winBorderRadius = 0.07;
#local winWidth = 0.95;
#local numWindows = roomWidth / winWidth;
#local chairScaling = 1.5;
#local lampRadius = 0.03;
#local lampLength = 1;
#local lampIntensity = 0.15;

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

background { rgb<135/255, 206/255, 250/255> }

light_source {
    <13, roomHeight + 1, roomDepth/2>
    color White
}

// Room
difference {
    // outer box
    box {
        <-(roomWidth/2 + 0.5), -0.5, -(roomDepth/2 + 0.5)>,
        <(roomWidth/2 + 0.5), roomHeight + 0.5, (roomDepth/2 + 0.5)>
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
    #local csWidth = 1;
    #local csHeight = 0.7;
    #local nRows = ceil(roomWidth/csWidth);
    #local nColumns = ceil(roomDepth/csHeight);

    #for (I, 0, nRows)
        box {
            <roomWidth/2 - I * csWidth, roomHeight, -roomDepth/2>,
            <roomWidth/2 - I * csWidth + 0.02, roomHeight - 0.002, roomDepth/2>
        }
    #end
    #for (I, 0, nColumns)
        box {
            <-roomWidth/2, roomHeight, roomDepth/2 - I * csHeight>,
            <roomWidth/2, roomHeight - 0.002, roomDepth/2 - I * csHeight + 0.02>
        }
    #end
    texture { Chrome_Metal }
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
    translate <winWidth/2, 0, roomDepth/2>
}

// Lamps
#local x1 = 11.35;
#local x2 = 13.2;
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
        translate <x1, 0, 31.5>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x1, 0, 29.7>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x1, 0, 27>
    }


    object {
        Lamp(lampLength, lampRadius, lampIntensity, 0)
        translate <x2, 0, 36>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x2, 0, 31.5>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 0)
        translate <x2, 0, 29.7>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x2, 0, 27>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x2, 0, 25.2>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 0)
        translate <x3, 0, 36>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x3, 0, 33.75>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x3, 0, 31.3>
    }

    object {
        Lamp(lampLength, lampRadius, lampIntensity, 1)
        translate <x3, 0, 29.5>
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
/*object {
    Chair
    scale chairScaling
    rotate y * 50
    translate <-4, -1, 8>
}

object {
    Chair
    scale chairScaling
    rotate y * -120
    translate <-3.5, -1, 5>
}

object {
    Chair
    scale chairScaling
    rotate y * 150
    translate <-2.5, -1, 5>
}

object {
    Chair
    scale chairScaling
    rotate y * -30
    translate <-3.2, -1, 6>
}

object {
    Chair
    scale chairScaling
    rotate y * 60
    translate <-2.6, -1, 5.7>
}

object {
    Chair
    scale chairScaling
    rotate y * 180
    translate <0.2, -1, 9>
}

object {
    Chair
    scale chairScaling
    rotate y * 170
    translate <1.2, -1, 9>
}

object {
    Chair
    scale chairScaling
    rotate y * 80
    translate <4, -1, 11>
}

object {
    Chair
    scale chairScaling
    rotate y * 80
    translate <4, -1, 10>
}
*/
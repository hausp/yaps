#version 3.7;

global_settings {
    assumed_gamma 1
    charset utf8
}

#include "transforms.inc"

#include "Chair.pov"
#include "FatVase.pov"
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

#declare Camera_Location = <10, 1.6, roomDepth/2 - 15>;
#declare Camera_Look_At  = <13, 1.6, roomDepth/2>;
#declare Camera_Angle    =  30;

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
    <13, roomHeight/2, roomDepth/2>
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
    #local csHeight = 0.5;
    #local nRows = ceil(roomWidth/csWidth);
    #local nColumns = ceil(roomDepth/csHeight);

    #for (I, 0, nRows)
        box {
            <roomWidth/2 - I * csWidth, roomHeight, -roomDepth/2>,
            <roomWidth/2 - I * csWidth + 0.02, roomHeight - 0.01, roomDepth/2>
        }
    #end
    #for (I, 0, nColumns)
        box {
            <-roomWidth/2, roomHeight, roomDepth/2 - I * csHeight>,
            <roomWidth/2, roomHeight - 0.01, roomDepth/2 - I * csHeight + 0.02>
        }
    #end
    texture { Chrome_Metal }
}

// Floor
merge {
    #local fSize = 0.45;
    box {
        <-roomWidth/2, 0, -roomDepth/2>,
        <roomWidth/2, 0.05, roomDepth/2>
        texture {
            pigment {
                rgb<122/255, 113/255, 98/255>
            }
            finish {
                crand 0.1       
            }
        }
    }
    // horizontal stripes
    #for (I, 0, ceil(roomWidth/fSize))
        box {
            <roomWidth/2 - I * fSize, 0.05, -roomDepth/2>,
            <roomWidth/2 - I * fSize + 0.02, 0.03, roomDepth/2>
            texture { pigment { Black } }
        }
    #end
    // vertical stripes
    #for (I, 0, ceil(roomDepth/fSize))
        box {
            <-roomWidth/2, 0.05, roomDepth/2 - I * fSize>,
            <roomWidth/2, 0.03, roomDepth/2 - I * fSize + 0.02>
            texture { pigment { Black } }
        }
    #end
}



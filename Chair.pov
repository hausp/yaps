//==========================================
// Classroom furniture
// -----------------------------------------
// Made for Persistence of vision 3.6
// =========================================
// Copyright 2001-2004 Gilles Tran http://www.oyonale.com
// -----------------------------------------
// This work is licensed under the Creative Commons Attribution License. 
// To view a copy of this license, visit http://creativecommons.org/licenses/by/2.0/ 
// or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
// You are free:
// - to copy, distribute, display, and perform the work
// - to make derivative works
// - to make commercial use of the work
// Under the following conditions:
// - Attribution. You must give the original author credit.
// - For any reuse or distribution, you must make clear to others the license terms of this work.
// - Any of these conditions can be waived if you get permission from the copyright holder.
// Your fair use and other rights are in no way affected by the above. 
// ==========================================  

#version 3.7;

#include "colors.inc"
#include "shapes.inc"

#local debugMode = 0;
#if (debugMode)
    global_settings {
        assumed_gamma 1
    }
#end
      
// ----------------------------------------
// Chair
// ----------------------------------------
#declare rCh = 0.025/2;
#declare rCh2 = rCh+0.002;
#declare rCh3 = 0.01;
#declare rCh4 = 0.05;
#declare yCh = 0.43;
#declare yCh2 = 0.345;
#declare zCh = 0.28;
#declare xCh = 0.33;
#declare zCh3 = 0.07;
#declare yCh1 = yCh-rCh4; 
#declare yCh5 = yCh-rCh*2; 
#declare yCh3 = sqrt(zCh3*zCh3+yCh5*yCh5);
#declare yCh4 = yCh3-rCh4;
#declare aCh = degrees(atan2(zCh3,yCh1));
#declare aCh1 = 2;
#declare aCh2 = 5;
#declare aCh3 = 10;
#declare C_Chair = rgb <1, 0, 0>;
#declare C_PChair1 = rgb <0.24219, 0.5, 0.45313>*0.5;
#declare C_PChair2 = rgb <0.5, 0.25781, 0.13672>*0.1;
#declare P_Chair1 = pigment {
    wood
    turbulence 0.2
    lambda 3
    color_map {
        [0 C_Chair*0.5]
        [1 C_Chair]
    }
    rotate y*100 rotate x*20    scale 0.04 scale 0.01*<10,1,1>    
}                             
#declare P_Chair2 = pigment {
    wood
    turbulence 0.2
    lambda 3
    color_map {
        [0 C_Chair*0.35]
        [1 C_Chair*0.5]
    }
    rotate y*100 rotate z*80 scale 0.01 scale 0.8*<1,5,1>  
}    
#declare T_WoodChair = texture {
    pigment {
        pigment_pattern {
            agate agate_turb 0.3 lambda 3 
            color_map {[0.5 White][0.5 Black]}
            rotate x*148
            scale 0.2
        }
        pigment_map {
            [0 P_Chair1]
            [1 P_Chair2]
        }
    }
    finish {ambient 0 diffuse 1}
}

#declare T_LegChair = texture {
    pigment {
        granite
        color_map {
            [0 C_PChair1]
            [0.7 C_PChair1]
            [0.8 C_PChair2]
            [1 C_PChair2]
        }
    }
    finish {ambient 0 diffuse 0.6 specular 1 roughness 1/10 reflection {0.1,0.8 metallic}}
    scale 0.1
}

#declare LegChairFront = union {
    cylinder {0,y*0.008,rCh2} // rubber
    torus {rCh,rCh2-rCh translate y*0.008}
    cylinder {0,y*yCh1,rCh} // montant Front
    difference {torus {rCh4,rCh rotate z*90} plane {y,0} plane {z,0 inverse} translate <0,yCh1,rCh4>}
    cylinder {0,z*zCh,rCh translate <0,yCh,rCh4>} // horizontal
    union { // Back
        difference {torus {rCh4,rCh rotate z*90} plane {y,0 inverse rotate x*aCh3} plane {z,0} translate y*rCh4}
        union {
            cylinder {0,y*yCh2,rCh}
            union {
                cylinder {0,y*0.01,rCh2}
                sphere {0,rCh2 scale <1,0.004/rCh2,1> translate y*0.01}
                translate y*yCh2
            }   
            translate z*rCh4
            rotate x*aCh3
            translate y*rCh4
        }
        rotate -z*aCh2
        translate <0,yCh,rCh4+zCh>
    }
}
#declare LegChairRear = union {
    cylinder {0,y*0.008,rCh2} 
    torus {rCh,rCh2-rCh translate y*0.008}
    cylinder {0,y*yCh4,rCh} 
    difference {torus {rCh4,rCh rotate x*90} plane {y,0} plane {x,0} translate <-rCh4,yCh4,0>}
}              

#declare rChD1 = xCh/2-sin(radians(aCh1))*(zCh+2*rCh4)+sin(radians(aCh2))*rCh4;
#declare rChD2 = xCh/2-sin(radians(aCh1))*(zCh+2*rCh4)+sin(radians(aCh2))*(rCh4+yCh2);
#declare yChD = yCh2*cos(radians(aCh2));
#declare BackChair = difference {
    cone {0,rChD1,y*yChD,rChD2}
    cone {-y*0.001,rChD1*0.85,y*(yChD+0.001),rChD2*0.85}
    plane {z,0}
    plane {y,yCh2*0.5}
    scale <1,1,0.08/rChD2>
}       
#declare eChS = 0.008;
#declare SeatChair = union {
    box {<-xCh/2,-eChS,0>,<xCh/2,0,zCh>}
    difference {cylinder {0,-eChS*y,xCh/2} plane {z,0} scale <1,1,0.05*2/xCh> translate z*zCh}
    difference {
        cylinder {-x*xCh/2,x*xCh/2,rCh4}
        cylinder {-x*1.1*xCh/2,x*1.1*xCh/2,rCh4-eChS}
        plane {z,0 inverse}
        plane {y,0 rotate x*25}
        translate -y*rCh4
    }
    texture {pigment {P_Chair1} finish {ambient 0 diffuse 1}}
} 

#declare Chair = union {
    union {
        object {LegChairFront rotate -y*aCh1 translate x*xCh/2}
        object {LegChairFront rotate -y*aCh1 translate x*xCh/2 scale <-1,1,1>}
        cylinder {-xCh*x/2,xCh*x/2,rCh3 translate -z*rCh4 rotate x*25 translate z*rCh4+y*yCh1}
        union {
            object {LegChairRear translate x*(xCh/2+rCh4)}
            object {LegChairRear translate x*(xCh/2+rCh4) scale <-1,1,1>}
            union {
                cylinder {-xCh/2*x,x*xCh/2,rCh}
                union {
                    sphere {0,1 translate y scale <1,0.5,1> scale 0.01 translate y*rCh-x*0.6*xCh/2}
                    sphere {0,1 translate y scale <1,0.5,1> scale 0.01 translate y*rCh+x*0.6*xCh/2}
                    texture {pigment {White*0.6}finish {ambient 0 diffuse 1 specular 1 roughness 0.001 reflection 0.1}}
                    rotate x*aCh
                }
                translate y*yCh3
            }
            translate -y*yCh3
            rotate -x*aCh
            translate <0,yCh3,zCh+rCh4>
        }                     
        texture {T_LegChair}
    }

    union {
        object {BackChair
            translate z*rCh4
            rotate x*aCh3
            translate <0,yCh+rCh4,rCh4+zCh>
            texture {T_WoodChair}
        }        
        object {SeatChair
            translate <0,yCh,rCh4>
        }
    }

    object {
        Round_Box(
            <-0.15, 0.40, 0>,
            <0.15, 0.45, 0.38>,
            0.02, 0)
        pigment { Red }
    }
}

// ----------------------------------------
// Scene
// ----------------------------------------

#if (debugMode)
    camera {
      location <0, 1, -1.5>
      look_at <0, 0, 1>
    }

    background { White * 0.5 }

    light_source {
        x*100 color White
        area_light 15*x,15*z, 10,10 jitter adaptive 1
        rotate z*45
        rotate y*150
    }

    plane {
        y, -1
        texture {
            pigment { checker rgb<0.3, 0.3, 0.3> White }
            /*finish {
                ambient 0
                diffuse 1
            }*/
        }
    }

    object {
        Chair
        rotate y * 45
    }
#end

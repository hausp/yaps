#version 3.7;

#include "colors.inc"
#include "textures.inc"
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
// WoodTable
// ----------------------------------------

#macro WoodTable(tWidth, tHeight, tThickness, absHeight)
    #local feetWidth = 0.05 * tWidth;
    #local feetHeight = 0.05 * tHeight;
    #local feetAbsHeight = absHeight - tThickness;
    #local sWidth = tWidth - feetWidth;
    #local sHeight = 0.125 * feetAbsHeight;
    #local ibThickness = 0.05 * tThickness;
    #local sbThickness = 0.10 * tThickness;
    #local cbThickness = tThickness - ibThickness - sbThickness;
    #local cbXOffset = 0.01 * tWidth;
    #local cbZOffset = 0.01 * tHeight;

    union {
        box {
            <-feetWidth/2, 0, -feetHeight/2>,
            <feetWidth/2, feetAbsHeight, feetHeight/2>
            translate (tWidth/2 - feetWidth/2) * x
            translate (tHeight/2 - feetHeight/2) * z
        }
        box {
            <-feetWidth/2, 0, -feetHeight/2>,
            <feetWidth/2, feetAbsHeight, feetHeight/2>
            translate -(tWidth/2 - feetWidth/2) * x
            translate (tHeight/2 - feetHeight/2) * z
        }
        box {
            <-feetWidth/2, 0, -feetHeight/2>,
            <feetWidth/2, feetAbsHeight, feetHeight/2>
            translate (tWidth/2 - feetWidth/2) * x
            translate -(tHeight/2 - feetHeight/2) * z
        }
        box {
            <-feetWidth/2, 0, -feetHeight/2>,
            <feetWidth/2, feetAbsHeight, feetHeight/2>
            translate -(tWidth/2 - feetWidth/2) * x
            translate -(tHeight/2 - feetHeight/2) * z
        }

        union {
            box {
                <-sWidth/2 + feetWidth/2, feetAbsHeight - sHeight, -(tHeight/2 - feetHeight)>,
                <sWidth/2 - feetWidth/2, feetAbsHeight, -tHeight/2>
            }

            box {
                <-sWidth/2 + feetWidth/2, feetAbsHeight - sHeight, (tHeight/2 - feetHeight)>,
                <sWidth/2 - feetWidth/2, feetAbsHeight, tHeight/2>
            }

            box {
                <-tWidth/2, feetAbsHeight - sHeight, -tHeight/2 + feetHeight/2>,
                <-tWidth/2 + feetHeight, feetAbsHeight, tHeight/2 - feetHeight/2>
            }

            box {
                <tWidth/2, feetAbsHeight - sHeight, -tHeight/2 + feetHeight/2>,
                <tWidth/2 - feetHeight, feetAbsHeight, tHeight/2 - feetHeight/2>
            }
        }

        difference {
            union {
                box {
                    <-tWidth/2, feetAbsHeight, -tHeight/2>,
                    <tWidth/2, feetAbsHeight + ibThickness, tHeight/2>
                }

                box {
                    <-tWidth/2 + cbXOffset, feetAbsHeight + ibThickness, -tHeight/2 + cbZOffset>,
                    <tWidth/2 - cbXOffset, feetAbsHeight + ibThickness + cbThickness, tHeight/2 - cbZOffset>
                }

                box {
                    <-tWidth/2, feetAbsHeight + ibThickness + cbThickness, -tHeight/2>,
                    <tWidth/2, feetAbsHeight + ibThickness + cbThickness + sbThickness, tHeight/2>
                }
            }
            box {
                <-tWidth/2 * 0.9, absHeight - cbThickness, -tHeight/2 * 0.9>,
                <tWidth/2 * 0.9, absHeight + 1, tHeight/2 * 0.9>
            }
        }

        texture {
            DMFWood3
            rotate 90 * x
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

    light_source { <-1, 2, -2> color White }

    plane {
        y, 0
        texture {
            pigment { checker rgb<0.3, 0.3, 0.3> White }
        }
    }
    object {
        WoodTable(1, 0.7, 0.10, 0.8)
    }
#end
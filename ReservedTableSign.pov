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
// Sign
// ----------------------------------------
#local signWidth = 0.5;
#local signHeight = 0.6;
#local borderRadius = 0.005;
#local headerHeight = 0.1;

#declare Sign = union {
    #local lowerX = -signWidth/2;
    #local upperX = signWidth/2;
    #local diameter = 2 * borderRadius;
    #local contentLowerX = lowerX + diameter;
    #local contentUpperX = upperX - diameter;
    #local headerLowerY = signHeight - diameter - headerHeight - 0.002;
    #local headerMediumY = headerLowerY + 0.02;
    #local headerUpperY = headerLowerY + headerHeight;

    // Frame
    object {
        Wire_Box(
            <lowerX, 0, 0>,
            <upperX, signHeight, diameter>,
            borderRadius, 0)
    }

    // Body
    box {
        <contentLowerX - 0.01, diameter, 0>,
        <contentUpperX, signHeight - diameter, 0>
        pigment { Orange }
    }

    // Support
    box {
        <lowerX, 0, 0>,
        <upperX, 0, 0.2>
    }

    // Header
    polygon {
        7,
        <contentLowerX - 0.005, headerLowerY, -0.002>,
        <contentLowerX - 0.005, headerMediumY, -0.002>,
        <contentLowerX + signWidth/5, headerMediumY, -0.002>,
        <contentLowerX + signWidth/5 + 0.05, headerUpperY, -0.002>,
        <contentUpperX, headerUpperY, -0.002>,
        <contentUpperX, headerLowerY, -0.002>,
        <contentLowerX - 0.005, headerLowerY, -0.002>
        pigment { Blue }
    }

    text {
        ttf "arial.ttf" "Biblioteca Central" 0.1, 0
        pigment { White }
        translate <-2.15, 13.25, -0.3>
        scale 0.04
    }

    text {
        ttf "arial.ttf" "MESA" 0.1, 0
        translate <-1.4, 4.25, -0.01>
        scale 0.07
    }

    text {
        ttf "arial.ttf" "EXCLUSIVA" 0.1, 0
        translate <-2.7, 3.3, -0.01>
        scale 0.07
    }

    text {
        ttf "arial.ttf" "(Normas Técnicas)" 0.1, 0
        translate <-4, 0.7, -0.01>
        scale 0.04
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

    light_source { <-1, 2, -2> color White }

    plane {
        y, -1
        texture {
            pigment { checker rgb<0.3, 0.3, 0.3> White }
        }
    }

    object {
        Sign
        rotate y * -20
    }
#end

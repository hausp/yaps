#include "colors.inc"
#include "shapes.inc"

global_settings {
    assumed_gamma 1
}

// ----------------------------------------
// Window
// ----------------------------------------
// Adjustable Settings
#declare winHeight = 1;
#declare winWidth = 0.5;
#declare borderRadius = 0.02;
#declare numWindows = 3;

#declare offsetX = numWindows * winWidth / 2;
#declare Window = union {
    #for (I, 0, numWindows - 1)
        object {
            Wire_Box(
                <I * winWidth - offsetX, 0, 0>,
                <(I + 1) * winWidth - offsetX, winHeight, 2 * borderRadius>,
                borderRadius, 0)
            pigment { Blue }
        }
    #end
}


// ----------------------------------------
// Scene
// ----------------------------------------
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
    Window
    //rotate y * 45
}

#include "colors.inc"
#include "shapes.inc"

global_settings {
    assumed_gamma 1
}

// ----------------------------------------
// Window
// ----------------------------------------
#macro Window(winHeight, winWidth, borderRadius, numWindows)
    #local offsetX = numWindows * winWidth / 2;
    union {
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
#end

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
    Window(0.6, 0.5, 0.02, 4)
    //rotate y * 45
    translate y * 0.5
}

object {
    Window(0.5, 0.5, 0.02, 4)
}

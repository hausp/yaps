#include "colors.inc"
#include "textures.inc"

camera {
	location <0, 2, -3>
	look_at <0, 1, 2>
}

sphere {
	<0, 1, 2>, 1
	texture {
		pigment { Yellow }
	}
}

plane {
	y, -1
	pigment {
		checker color Blue, color White
	}
}

light_source { <2, 4, -3> color White}
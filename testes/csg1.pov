#version 3.7;

#include "colors.inc"
camera {
	location <0, 1, -10>
	look_at 0
	angle 36
}

light_source { <500, 500, -1000> White }

plane {
	y, -1.5
	pigment { checker Green White }
}

#declare HoleLens = difference {
	intersection {
		sphere {
			<0, 0, 0>, 1
			translate -0.5 * x
		}

		sphere {
			<0, 0, 0>, 1
			translate 0.5 * x
		}

		pigment { Red }
		rotate 90 * y
	}

	cylinder {
		<0, 0, -1> <0, 0, 1>, .35
	}
}

/*merge {
	object { HoleLens translate <-.65,  .65, 0> }
	object { HoleLens translate < .65,  .65, 0> }
	object { HoleLens translate <-.65, -.65, 0> }
	object { HoleLens translate < .65, -.65, 0> }
	pigment { Red }
}*/

difference {
	box {
		<-1, -1, -1> <1, 1, 1>
		pigment { Red }
	}

	cylinder {
		-1.001 * z, 1.001 * z, 0.5
		pigment { Green }
	}

	//rotate 45 * y
}

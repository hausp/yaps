#version 3.7;

#macro Frame(p1, p2, frameThickness)
	#local delta = <frameThickness, frameThickness, -0.01>;
    difference {
        box { p1, p2 }
        box { p1 + delta, p2 - delta }
    }
#end

#declare BlackMetal = texture {
    pigment { rgb<0.01, 0.01, 0.01> }
    finish {
        specular albedo 0.5
        roughness 0.01
        diffuse albedo 0.3
        ambient 0.2
        brilliance 10.0
        metallic
    }
}
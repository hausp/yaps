#version 3.7;

#macro Frame(p1, p2, frameThickness)
	#local delta = <frameThickness, frameThickness, -0.01>;
    difference {
        box { p1, p2 }
        box { p1 + delta, p2 - delta }
    }
#end

#declare BlackMetal = texture {
    pigment { rgb<0.001, 0.001, 0.001> }
    finish {
        specular albedo 0.3
        roughness 0.1
        diffuse albedo 0.2
        ambient 0.2
        brilliance 5.0
        reflection { 0.003 }
        metallic 0.99
    }
}
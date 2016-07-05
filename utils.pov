#version 3.7;

#local debugMode = 1;
#if (debugMode)
    global_settings {
        assumed_gamma 1
        charset utf8
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
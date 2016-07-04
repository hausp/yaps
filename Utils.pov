#version 3.7;

#macro Frame(p1, p2, frameThickness)
	#local delta = <frameThickness, frameThickness, -0.01>;
    difference {
        box { p1, p2 }
        box { p1 + delta, p2 - delta }
    }
#end

shader_type canvas_item;

void vertex() {
    // This function is required for 2D shaders but can be left empty in this case.
}

void fragment() {
    // Set the color to red
    COLOR.rgb = vec3(1.0, 0.0, 0.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

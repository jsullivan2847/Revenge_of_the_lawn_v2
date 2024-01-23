shader_type canvas_item;

uniform vec2 mask_center = vec2(0.5, 0.5);
uniform float mask_radius = 0.1;

void vertex() {
    vec4 global_vertex = vec4(VERTEX.x, VERTEX.y, 0.0, 1.0);
    vec4 transformed_vertex = MODEL_MATRIX * global_vertex;
    vec2 global_vertex_position = transformed_vertex.xy / transformed_vertex.w;

    // Check if the vertex is very close to the player's global position
    if (length(global_vertex_position - mask_center) < 0.001) {
        COLOR.a = 0.0;
    }
    else {
        // Modify the alpha value based on the distance to the mask
        float distance_to_mask = distance(global_vertex_position, mask_center);
        COLOR.a *= smoothstep(0.0, 0.02, mask_radius - distance_to_mask);
    }
}


//void light() {
	 //Called for every pixel for every light affecting the CanvasItem.
	 //Uncomment to replace the default light processing function with this one.
//}

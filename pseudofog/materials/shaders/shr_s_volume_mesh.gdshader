shader_type spatial;
render_mode unshaded, depth_draw_opaque, cull_disabled, specular_disabled;

uniform vec4 color :hint_color = vec4(0, 0, 1, 1);

void fragment(){
	ALBEDO = color.rgb;
}
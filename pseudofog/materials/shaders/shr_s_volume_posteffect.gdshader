shader_type canvas_item;
render_mode unshaded;

uniform sampler2D volume_renderpass;

uniform float blur_directions :hint_range(0, 64) = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
uniform float blur_quality :hint_range(0, 10) = 3.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
uniform float blur_amount :hint_range(0, 128) = 8.0; // BLUR SIZE (Radius)

uniform float overlay_amount :hint_range(0.0, 1.0) = 0.5;

const float TAU = 6.28;
void fragment() {
	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	vec4 volumepass_tex = texture(volume_renderpass, uv);
	vec4 renderpass_tex = texture(SCREEN_TEXTURE, uv);
	
	vec4 volumepass_blurred = volumepass_tex;
	vec2 blur_radius = blur_amount / (1.0 / SCREEN_PIXEL_SIZE).xy;
	for( float d = 0.0; d < TAU; d += TAU / blur_directions){
		for(float i = 1.0 / blur_quality; i <= 1.0; i += 1.0 / blur_quality){
			volumepass_blurred += texture(volume_renderpass, uv + vec2(cos(d), sin(d)) * blur_radius * i);
		}
	}
	volumepass_blurred /= blur_quality * blur_directions - 15.0;
	
	vec4 finalpass_tex = 1.0 - (1.0 - volumepass_blurred) * (1.0 - renderpass_tex);
	
	COLOR = mix(finalpass_tex, renderpass_tex, overlay_amount);
}
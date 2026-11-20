shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float blur_amount : hint_range(0.0, 5.0) = 2.5;
uniform float darkness : hint_range(0.0, 1.0) = 0.45;

void fragment() {
    vec4 background = textureLod(
        SCREEN_TEXTURE,
        SCREEN_UV,
        blur_amount
    );

    COLOR = vec4(
        background.rgb * (1.0 - darkness),
        1.0
    );
}

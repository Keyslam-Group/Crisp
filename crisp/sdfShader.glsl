uniform float screenPxRange = 2.0f;

float median(float r, float g, float b) {
    return max(min(r, g), min(max(r, g), b));
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec3 msd = Texel(tex, texture_coords).rgb;
    float sd = median(msd.r, msd.g, msd.b) - 0.5f;
    float screenPxDistance = screenPxRange * sd;
    float opacity = clamp(screenPxDistance + 0.5, 0.0, 1.0);

    color.a *= opacity;
    return color;
}

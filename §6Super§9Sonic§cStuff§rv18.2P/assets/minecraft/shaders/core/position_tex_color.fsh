#version 150

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;

in vec2 texCoord0;
in vec4 vertexColor;
in vec4 Pos;

out vec4 fragColor;

void main() {
    vec4 color;
    if (Pos.x != 1)
    {
        float Time = abs(Pos.x * 3);

        float frame = floor(Time);
        float slide = Time - frame;

        vec2 coords = texCoord0 * vec2(1, 0.2) + vec2(0, 0.2) * frame;

        vec4 color1 = texture(Sampler0, coords) * vertexColor;

        vec4 color2 = texture(Sampler0, coords + vec2(0, 0.2)) * vertexColor;

        color = mix(color1, color2, clamp((slide -0.5) * 2, 0, 1));
    }
    else
        color = texture(Sampler0, texCoord0) * vertexColor;

    if (color.a < 0.1) {
        discard;
    }
    fragColor = color * ColorModulator;
}

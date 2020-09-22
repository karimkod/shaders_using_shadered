#version 330
uniform sampler2D text;

in vec4 color;
out vec4 outColor;
in vec2 vST;
void main() {
	vec3 textColor = texture(text, vST).rgb;
   outColor = vec4(textColor, 1);
}
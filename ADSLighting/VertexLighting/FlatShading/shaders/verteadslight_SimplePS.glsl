#version 400

flat in vec4 color;
out vec4 outColor;

void main() {
   outColor = vec4(color);
}
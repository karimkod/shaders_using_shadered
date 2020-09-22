#version 330

uniform mat4 matVP;
uniform mat4 matGeo;


layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 textCoord;
out vec4 color;
out vec2 vST; 
void main() {

	vST=textCoord.st;
   color = vec4(abs(normal), 1.0);
   gl_Position = matVP * matGeo * vec4(pos, 1);
}

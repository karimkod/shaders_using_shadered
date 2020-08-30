#version 330
#define M_PI 3.1415926535897932384626433832795



uniform mat4 matVP; 
uniform mat4 matV; 
uniform mat4 matGeo; 
uniform mat4 matP;

uniform vec3 lightPosition; 
uniform float angleAboutY; 
uniform float squishAmount;
uniform float shrinkAmount;
uniform float lowerEdge; 
uniform float higherEdge;
uniform float transformationAmount;

uniform float time;

layout (location = 0) in vec3 position;
layout (location = 1)  in vec3 normal;

out vec3 ECnormal; 

out vec3 ECpos; // eye coordinates position
void main()
{
	float realDegree = (1-smoothstep(lowerEdge, higherEdge, position.y)) * angleAboutY;
	float cosine = cos(radians(realDegree));
	float sine = sin(radians(realDegree));
	mat4 rotationAboutY = mat4(
	cosine, 0, sine, 0, 
	0, 1, 0, 0, 
	-sine, 0, cosine, 0, 
	0, 0, 0, 1
	);
	
	mat4 squishY = mat4(
	shrinkAmount, 0, 0, 0, 
	0, 1/squishAmount, 0, 0,
	0, 0, shrinkAmount, 0, 
	0, 0, 0, 1
	);
	
	
	
	mat4 totalTransform = mat4(1) + (transformationAmount * 
	(abs(floor(mod(time, 2)) - fract(time))) * 
	(rotationAboutY * squishY));
	ECnormal = vec3(transpose(inverse(matV * matGeo * rotationAboutY)) * vec4(normal, 1.0));

	ECpos = vec3(matV * matGeo * totalTransform* vec4(position, 1.0));

	
	gl_Position = matVP * matGeo * totalTransform* vec4(position, 1.0);
}

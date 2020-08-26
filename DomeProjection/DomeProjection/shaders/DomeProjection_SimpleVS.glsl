#version 330
#define M_PI 3.1415926535897932384626433832795



uniform mat4 matVP; 
uniform mat4 matV; 
uniform mat4 matGeo; 
uniform mat4 matP;

uniform vec3 lightPosition; 

uniform bool domeProjection;
uniform float domeScale;

layout (location = 0) in vec3 position;
layout (location = 1)  in vec3 normal;

out vec3 ECnormal; 

out vec3 ECpos; 
void main()
{
	
	ECnormal = vec3(transpose(inverse(matV * matGeo)) * vec4(normal, 1.0));

	ECpos = vec3(matV * matGeo * vec4(position, 1.0));
	
	
	float lenxy = length(ECpos.xy);
	

	float phi = atan(lenxy, -ECpos.z);
	ECpos.xy = normalize(ECpos.xy);
	float r = phi/(M_PI/2);
	ECpos.xy = domeScale * r * ECpos.xy;
	
	
	if(domeProjection)
		gl_Position = matP * vec4(ECpos, 1.0); 
	else 
		gl_Position = matVP * matGeo * vec4(position, 1.0);
}

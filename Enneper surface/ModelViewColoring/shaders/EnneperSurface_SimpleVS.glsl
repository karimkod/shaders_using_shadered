#version 330
#define M_PI 3.1415926535897932384626433832795



uniform mat4 matVP; 
uniform mat4 matV; 
uniform mat4 matGeo; 
uniform mat4 matP;

uniform vec3 lightPosition; 




layout (location = 0) in vec3 position;
layout (location = 1)  in vec3 normal;
layout (location = 2) in vec3 textCoord;

out vec3 ECnormal; 

out vec3 ECpos; // eye coordinates position
void main()
{
	
	vec3 newPos; 
	
	float u = textCoord.s; 
	float v = textCoord.t;
	
	newPos.x = (u - pow(u,3)) / (3 + u*pow(u,3) );
	newPos.y = (-v- (pow(u,2)*v) + pow(v,3)) / 3;
	newPos.z = pow(u,2) - pow(v,2);
	
	ECnormal = vec3(transpose(inverse(matV * matGeo)) * vec4(normal, 1.0));

	ECpos = vec3(matV * matGeo * vec4(newPos, 1.0));
	
	
	gl_Position = matVP * matGeo * vec4(newPos, 1.0);
}

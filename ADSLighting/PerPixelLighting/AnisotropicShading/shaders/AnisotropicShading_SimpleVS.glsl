 #version 330

uniform mat4 matVP; 
uniform mat4 matV; 
uniform mat4 matGeo; 


uniform vec3 lightPosition; 




layout (location = 0) in vec3 position;
layout (location = 1)  in vec3 normal;
layout (location = 3) in vec3 tangent;

out vec3 ECnormal; 
out vec3 ECtangent; 
out vec3 ECpos; 
void main()
{
	
	ECnormal = vec3(transpose(inverse(matV * matGeo)) * vec4(normal, 1.0));
	
	ECpos = vec3(matV * matGeo * vec4(position, 1.0));
	ECtangent = normalize(vec3(matV * matGeo* vec4(tangent, 1.0)));
	gl_Position = matVP * matGeo * vec4(position, 1.0); 
}

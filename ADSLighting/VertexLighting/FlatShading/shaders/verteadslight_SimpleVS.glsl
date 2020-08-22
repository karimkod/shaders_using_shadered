#version 400 


uniform mat4 matVP; 
uniform mat4 matGeo; 


uniform vec4 lightPosition;

uniform vec3 ambientLight; 
uniform vec3 specularLight; 
uniform vec3 diffuseLight; 

uniform float aCoeff; 
uniform float dCoeff; 
uniform float sCoeff;

uniform vec3 diffuseMaterial; 
uniform vec3 specularMaterial; 
uniform vec3 ambientMaterial; 

uniform vec4 eyePosition; 

uniform float materialShininess;

layout (location = 0) in vec3 position; 
layout (location = 1) in vec3 normal; 
flat out vec4 color; 


void main()
{
	vec4 worldPos =  matGeo * vec4(position,1) ;
	vec3 Lightv = normalize(vec3(lightPosition - worldPos)); 
	vec3 Viewv = normalize(vec3(eyePosition - worldPos));
	vec3 ref = normalize(reflect(-Lightv, normal));
	
	vec3 ambient = ambientLight * ambientMaterial; 
	vec3 diffuse = diffuseLight * diffuseMaterial * max(0.0, dot(Lightv, normal));
	vec3 specular = vec3(0);//specularLight * specularMaterial * 
	if(dot(ref, Viewv) > 0)
	{
		specular = specularLight * specularMaterial * pow(dot(ref, Viewv), materialShininess);
	}
	
	
	color = vec4(aCoeff * ambient + dCoeff* diffuse + sCoeff* specular, 1.0); 
	
	gl_Position = matVP * matGeo * vec4(position, 1);
	 
}



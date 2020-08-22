#version 330

uniform mat4 matV; 
uniform mat4 matGeo; 

uniform vec4 lightColor;
uniform vec4 ambientColor;

uniform vec4 colorMaterial;

uniform float aCoeff; 
uniform float dCoeff; 
uniform float sCoeff;
uniform vec3 lightPosition; 
uniform float materialShininess;
//uniform float specularCutOff;
//uniform float inferiorEdge;

in vec3 ECnormal;

in vec3 ECpos;
out vec4 color; 

void main(){
	vec3 EClightPosition = vec3(matV * vec4(lightPosition, 1.0));
   	vec3 lightRay = normalize(EClightPosition  - ECpos);

	vec3 reflecRay = normalize(reflect(-lightRay, ECnormal));
	
 	vec3 viewRay = normalize(-ECpos);

	vec3 ambient = vec3(ambientColor * colorMaterial * aCoeff); 
	vec3 diffuse = vec3(lightColor* colorMaterial * dCoeff * max(0.0,dot(lightRay,ECnormal)));
	vec3 specular = vec3(0);
	float cosine = dot(viewRay, reflecRay);
	
	
		//specular = vec3(lightColor * colorMaterial * sCoeff * pow(smoothstep(inferiorEdge, inferiorEdge+specularCutOff, cosine), materialShininess));
	if(cosine > 0)
	{
			specular = vec3(lightColor * colorMaterial * sCoeff * pow( cosine, materialShininess));
	}
	
	color = vec4(ambient + diffuse + specular ,1);
}










 

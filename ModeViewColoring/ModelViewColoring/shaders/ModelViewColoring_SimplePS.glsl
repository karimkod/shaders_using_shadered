#version 330

uniform mat4 matV; 
uniform mat4 matGeo; 

uniform vec4 lightColor;
uniform vec4 ambientColor;



uniform vec3 oddColor;
uniform vec3 evenColor;

uniform bool modelColoring;

uniform float aCoeff; 
uniform float dCoeff; 
uniform float sCoeff;
uniform vec3 lightPosition; 
uniform float materialShininess;

uniform float time; 
uniform vec3 mousePosition;
uniform float frequency;
in vec3 ECnormal;

in vec3 ECpos;
in vec3 MCpos;
out vec4 color; 

void main(){

	vec3 forCalculationPos; 
	if(modelColoring)
		{
				
			forCalculationPos = MCpos; 
			
		}
	else 
		forCalculationPos = ECpos;
		
	bool isEven = mod(floor(forCalculationPos.x*frequency ),  2) == 0;	
		
	vec4 colorMaterial = vec4(1);	
	
	if(isEven)
		colorMaterial = vec4(evenColor,1); 
	else 
		colorMaterial = vec4(oddColor,1);  
	      
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










 

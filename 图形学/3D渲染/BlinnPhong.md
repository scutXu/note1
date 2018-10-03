###Lambert
{%ace edit=true, lang='glsl'%}
vec3 lambert(float Ka, vec3 ambient,
			 float Kd, vec3 diffuse, vec3 lightDirection, vec3 vertexNormal)
{
	return (Ka * ambient) + 
		   (Kd * diffuse * max(dot(- lightDirection, vertexNormal), 0.0));
}

{%endace%}

###Phong
{%ace edit=true, lang='glsl'%}
vec3 phong(float Ks, vec3 specular, vec3 lightDirection, vec3 viewDirection, vec3 vertexNormal, float shininess)
{
	vec3 reflectedLightDirection = reflect(lightDirection, vertexNormal);
	return Ks * specular * pow(max(dot(- reflectedLightDirection, viewDirection), 0.0), shininess);
}
{%endace%}

###Blinn-Phong

{%ace edit=true, lang='glsl'%}
vec3 blinnPhong(float Ks, vec3 specular, vec3 lightDirection, vec3 viewDirection, vec3 vertexNormal, float shininess)
{
	vec3 halfDirection = normalize(lightDirection + viewDirection);
	return Ks * specular * pow(max(dot(- halfDirection, vertexNormal), 0.0), shininess);
}
{%endace%}

以上代码忽略了多光源的情况，实际上计算公式应该为

**color = ambient + ∑(diffuse + specular)**
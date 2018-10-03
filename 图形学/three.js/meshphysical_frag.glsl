uniform mat4 viewMatrix;
uniform vec3 cameraPosition;

#define PHYSICAL

uniform vec3 diffuse;
uniform vec3 emissive;
uniform float roughness;
uniform float metalness;
uniform float opacity;

#ifndef STANDARD
	uniform float clearCoat;
	uniform float clearCoatRoughness;
#endif

varying vec3 vViewPosition;

varying vec3 vNormal;

#include <common>
//struct ReflectedLight {
//	  vec3 directDiffuse;
//	  vec3 directSpecular;
//	  vec3 indirectDiffuse;
//	  vec3 indirectSpecular;
//};
//struct IncidentLight {
//	  vec3 color;
//	  vec3 direction;
//	  bool visible;
//};

#include <packing>
#include <dithering_pars_fragment>
#include <color_pars_fragment> //varying vec3 vColor;
#include <uv_pars_fragment> //varying vec2 vUv;
#include <uv2_pars_fragment> //varying vec2 vUv2;
#include <map_pars_fragment> //uniform sampler2D map;
#include <alphamap_pars_fragment> //uniform sampler2D alphaMap;
#include <aomap_pars_fragment> //uniform sampler2D aoMap;uniform float aoMapIntensity;
#include <lightmap_pars_fragment> //uniform sampler2D lightMap;uniform float lightMapIntensity;
#include <emissivemap_pars_fragment> //uniform sampler2D emissiveMap;
#include <envmap_pars_fragment>
#include <fog_pars_fragment>
#include <bsdfs>
#include <cube_uv_reflection_fragment> //#ifdef ENVMAP_TYPE_CUBE_UV
									   //	vec4 textureCubeUV(vec3 reflectedDirection,float roughness);
									   //#endif

#include <lights_pars_begin> //AmbientLight: vec3 -> vec3
							 //DirectionalLight: DirectionalLight -> IncidentLight
							 //Point Light: PointLight -> IncidentLight
							 //SpotLight: SpotLight -> IncidentLight
							 //RectAreaLight: RectAreaLight -> RectAreaLight
							 //HemisphereLight: HemisphereLight -> vec3

#include <lights_pars_maps> //ENVMAP: map -> vec3

#include <lights_physical_pars_fragment> //RE_Direct: BRDF_Specular_GGX, BRDF_Diffuse_Lambert
										 //RE_Direct_RectArea: 
										 //RE_IndirectDiffuse: BRDF_Diffuse_Lambert
										 //RE_IndirectSpecular: BRDF_Specular_GGX_Environment
#include <shadowmap_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <roughnessmap_pars_fragment> //uniform sampler2D roughnessMap;
#include <metalnessmap_pars_fragment> //uniform sampler2D metalnessMap;
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( diffuse, opacity );
	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive;

	#include <logdepthbuf_fragment>

	#include <map_fragment> //vec4 texelColor = texture2D( map, vUv );
							//texelColor = mapTexelToLinear( texelColor );
							//diffuseColor *= texelColor;

	#include <color_fragment> //diffuseColor.rgb *= vColor;
	#include <alphamap_fragment> //diffuseColor.a *= texture2D( alphaMap, vUv ).g;
	#include <alphatest_fragment> //if ( diffuseColor.a < ALPHATEST ) discard;

	#include <roughnessmap_fragment> //float roughnessFactor = roughness;
									 //vec4 texelRoughness = texture2D( roughnessMap, vUv );
									 //roughnessFactor *= texelRoughness.g;

	#include <metalnessmap_fragment> //float metalnessFactor = metalness;
									 //vec4 texelMetalness = texture2D( metalnessMap, vUv );
									 //metalnessFactor *= texelMetalness.b;

	#include <normal_fragment_begin> //vec3 normal = normalize( vNormal );

	#include <normal_fragment_maps> //#ifdef USE_NORMALMAP
									//	normal = perturbNormal2Arb( -vViewPosition, normal );
									//#elif defined( USE_BUMPMAP )
									//	normal = perturbNormalArb( -vViewPosition, normal, dHdxy_fwd() );

	#include <emissivemap_fragment> //vec4 emissiveColor = texture2D( emissiveMap, vUv );
									//emissiveColor.rgb = emissiveMapTexelToLinear( emissiveColor ).rgb;
									//totalEmissiveRadiance *= emissiveColor.rgb;

	#include <lights_physical_fragment> //PhysicalMaterial material;

	#include <lights_fragment_begin> //directSpecular, directDiffuse := RE_Direct(PointLight)
									 //directSpecular, directDiffuse += RE_Direct(SpotLight)
									 //directSpecular, directDiffuse += RE_Direct(DirectionalLight)
									 //directSpecular, directDiffuse += RE_Direct_RectArea(RectAreaLight)
									 //irradiance := AmbientLight + HemisphereLight
									 //radiance := 0

	#include <lights_fragment_maps> //irradiance += LIGHTMAP + ENVMAP
									//radiance += ENVMAP

	#include <lights_fragment_end> //indirectDiffuse := RE_IndirectDiffuse(irradiance)
								   //indirectSpecular := RE_IndirectSpecular(radiance)

	#include <aomap_fragment> //indirectSpecular *= AOMAP

	vec3 outgoingLight = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse + reflectedLight.directSpecular + reflectedLight.indirectSpecular + totalEmissiveRadiance;

	gl_FragColor = vec4( outgoingLight, diffuseColor.a );

	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>

}
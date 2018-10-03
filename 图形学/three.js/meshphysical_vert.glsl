uniform mat4 modelMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat3 normalMatrix;
uniform vec3 cameraPosition;

attribute vec3 position;
attribute vec3 normal;
attribute vec2 uv;

#ifdef USE_COLOR

	attribute vec3 color;

#endif

#ifdef USE_MORPHTARGETS

	attribute vec3 morphTarget0;
	attribute vec3 morphTarget1;
	attribute vec3 morphTarget2;
	attribute vec3 morphTarget3;

	#ifdef USE_MORPHNORMALS

		attribute vec3 morphNormal0;
		attribute vec3 morphNormal1;
		attribute vec3 morphNormal2;
		attribute vec3 morphNormal3;

	#else

		attribute vec3 morphTarget4;
		attribute vec3 morphTarget5;
		attribute vec3 morphTarget6;
		attribute vec3 morphTarget7;

	#endif

#endif

#ifdef USE_SKINNING

	attribute vec4 skinIndex;
	attribute vec4 skinWeight;

#endif


#define PHYSICAL

varying vec3 vViewPosition;

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif

#include <common>
#include <uv_pars_vertex> //varying vec2 vUv;uniform mat3 uvTransform;
#include <uv2_pars_vertex> //attribute vec2 uv2;varying vec2 vUv2;

#include <displacementmap_pars_vertex> //uniform sampler2D displacementMap;
									   //uniform float displacementScale;
									   //uniform float displacementBias;

#include <color_pars_vertex> //varying vec3 vColor;
#include <fog_pars_vertex> //varying float fogDepth;
#include <morphtarget_pars_vertex> 

#include <skinning_pars_vertex> //uniform mat4 bindMatrix;
								//uniform mat4 bindMatrixInverse;
								//#ifdef BONE_TEXTURE
								//			uniform sampler2D boneTexture;
								//			uniform int boneTextureSize;
								//#else
								//			uniform mat4 boneMatrices[ MAX_BONES ];
								//mat4 getBoneMatrix( const in float i );
#include <shadowmap_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <uv_vertex> //vUv = ( uvTransform * vec3( uv, 1 ) ).xy;
	#include <uv2_vertex> //vUv2 = uv2;
	#include <color_vertex> //vColor.xyz = color.xyz;

	#include <beginnormal_vertex> //vec3 objectNormal = vec3( normal );
	#include <morphnormal_vertex>

	#include <skinbase_vertex> //mat4 boneMatX = getBoneMatrix( skinIndex.x );
							   //mat4 boneMatY = getBoneMatrix( skinIndex.y );
							   //mat4 boneMatZ = getBoneMatrix( skinIndex.z );
							   //mat4 boneMatW = getBoneMatrix( skinIndex.w );
	
	
	#include <skinnormal_vertex> //mat4 skinMatrix = mat4( 0.0 );
								 //skinMatrix += skinWeight.x * boneMatX;
								 //skinMatrix += skinWeight.y * boneMatY;
								 //skinMatrix += skinWeight.z * boneMatZ;
								 //skinMatrix += skinWeight.w * boneMatW;
								 //skinMatrix  = bindMatrixInverse * skinMatrix * bindMatrix;
								 //objectNormal = vec4( skinMatrix * vec4( objectNormal, 0.0 ) ).xyz;

	#include <defaultnormal_vertex> //vec3 transformedNormal = normalMatrix * objectNormal;


	#include <begin_vertex> //vec3 transformed = vec3( position );
	#include <morphtarget_vertex>

	#include <skinning_vertex> //vec4 skinVertex = bindMatrix * vec4( transformed, 1.0 );
							   //vec4 skinned = vec4( 0.0 );
							   //skinned += boneMatX * skinVertex * skinWeight.x;
							   //skinned += boneMatY * skinVertex * skinWeight.y;
							   //skinned += boneMatZ * skinVertex * skinWeight.z;
							   //skinned += boneMatW * skinVertex * skinWeight.w;
							   //transformed = ( bindMatrixInverse * skinned ).xyz;
	
	#include <displacementmap_vertex> //transformed += normalize( objectNormal ) * ( texture2D( displacementMap, uv ).x * displacementScale + displacementBias );

	#include <project_vertex> //vec4 mvPosition = modelViewMatrix * vec4( transformed, 1.0 );
							  //gl_Position = projectionMatrix * mvPosition;

	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>

	vViewPosition = - mvPosition.xyz;

	#include <worldpos_vertex> //vec4 worldPosition = modelMatrix * vec4( transformed, 1.0 );
	#include <shadowmap_vertex>
	#include <fog_vertex>

}

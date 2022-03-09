#version 330 compatibility
uniform vec3 LightPosition;
uniform float uScale;
uniform sampler2D uDispUnit;
out vec2 vST;
out vec3 vNormal;
out  vec3  vN;		// normal vector
out  vec3  vL;		// vector from point to light
out  vec3  vE;		// vector from point to eye

const vec3 LIGHTPOSITION = vec3( 0., 0., 20. );

void
main( )
{ 
	vec3 vert = gl_Vertex.xyz;
	vec4 ECposition = gl_ModelViewMatrix * vec4( vert, 1. );
	vN = normalize( gl_NormalMatrix * gl_Normal );	// normal vector
	vL = LightPosition - ECposition.xyz;		// vector from the point
							// to the light position
	vE = vec3( 0., 0., 0. ) - ECposition.xyz;	// vector from the point
							// to the eye position 

	vec2 st = gl_MultiTexCoord0.st;
	vST = st; // to send to fragment shader
	//gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	vec3 norm = normalize( gl_Normal );
	vNormal= normalize( gl_NormalMatrix * gl_Normal );

	float disp = texture( uDispUnit, st ).r;
			// in half-meters, relative to a radius of 1,727,400 meters
	disp *= uScale;

	vert += norm * disp;

	gl_Position = gl_ModelViewProjectionMatrix * vec4( vert, 1. );
}

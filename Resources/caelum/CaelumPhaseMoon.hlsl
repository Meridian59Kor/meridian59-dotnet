/*
This file is part of Caelum.
See http://www.ogre3d.org/wiki/index.php/Caelum 

Copyright (c) 2006-2007 Caelum team. See Contributors.txt for details.

Caelum is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Caelum is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Caelum. If not, see <http://www.gnu.org/licenses/>.
*/

struct VOut
{
	float4 p	: POSITION;
	float2 uv	: TEXCOORD0;
};

VOut PhaseMoonVP(
	float4 p : POSITION,
	float2 uv : TEXCOORD0,
	uniform float4x4 wvpMat,
	uniform float4x4 texMat)
{
	VOut OUT;

	OUT.p  = mul(wvpMat, p);
	OUT.uv = mul(texMat, float4(uv, 0, 1)).xy;

	return OUT;
}

// Get how much of a certain point on the moon is seen (or not) because of the phase.
// uv is the rect position on moon; as seen from the earth.
// phase ranges from 0 (full moon) to 1 (again fool moon)
float MoonPhaseFactor(float2 uv, float phase)
{
    // 1. In phase interval [0..1/2) day-to-night terminator appeared on the right side of the moon and moves to the left by cosine law
    // 2. In phase interval [1/2..1) night-to-day terminator appeared on the right side of the moon and moves to the left by cosine law
    // but if we swapped for simplicity left and right sides of the moon for the second interval than
    // 2' In phase interval [1/2..1) night-to-day terminator appeared on the left side of the moon and moves to the right by cosine law
    // therefore in such coord system terminator would move from right to left and to the right again, and picture would be like this: 
    // Moon => (day | night)

    float cY = uv.y - 0.5;                             // signed
    float cX = sqrt(0.25 - cY * cY);                   // positive, half of disk chord
    
    float termX = cX * cos((2.0 * 3.1416) * phase);    // determine terminator position in our tweaked coord system
    float refX = (uv.x - 0.5) * sign(0.5 - phase);     // reverse X axis for phase interval [1/2..1)
    	
    return 0.5 * sign(termX - refX) + 0.5;             // day if refX < termX
}

void PhaseMoonFP
(
    in float2 uv: TEXCOORD0,
    uniform float phase,
    uniform sampler2D moonDisc: register(s0), 
    out float4 outcol : COLOR
)
{
    outcol = tex2D(moonDisc, uv);
    float alpha = MoonPhaseFactor(uv, phase);

    // Get luminance from the texture.
    float lum = dot(outcol.rgb, float3(0.3333, 0.3333, 0.3333));
    //float lum = dot(outcol.rgb, float3(0.3, 0.59, 0.11));
    outcol.a = min(outcol.a, lum * alpha);
    outcol.rgb /= lum;
}

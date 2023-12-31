#pragma header

    // "RayMarching starting point" 
    // by Martijn Steinrucken aka The Art of Code/BigWings - 2020
    // The MIT License
    // Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    // Email: countfrolic@gmail.com
    // Twitter: @The_ArtOfCode
    // YouTube: youtube.com/TheArtOfCodeIsCool
    // Facebook: https://www.facebook.com/groups/theartofcode/
    //
    // You can use this shader as a template for ray marching shaders

    #define MAX_STEPS 100
    #define MAX_DIST 100.
    #define SURF_DIST .001

    #define S smoothstep
    #define T iTime

	uniform float xMatch;
	uniform float yMatch;
    uniform vec3 iResolution;

    mat2 Rot(float a) {
        float s=sin(a), c=cos(a);
        return mat2(c, -s, s, c);
    }

    float sdBox(vec3 p, vec3 s) {
        p = abs(p)-s;
        return length(max(p, 0.))+min(max(p.x, max(p.y, p.z)), 0.);
    }


    float GetDist(vec3 p) {
        float d = sdBox(p, vec3(1));
        
        return d;
    }

    float RayMarch(vec3 ro, vec3 rd) {
        float dO=0.;
        
        for(int i=0; i<MAX_STEPS; i++) {
            vec3 p = ro + rd*dO;
            float dS = GetDist(p);
            dO += dS;
            if(dO>MAX_DIST || abs(dS)<SURF_DIST) break;
        }
        
        return dO;
    }

    vec3 GetNormal(vec3 p) {
        float d = GetDist(p);
        vec2 e = vec2(.001, 0);
        
        vec3 n = d - vec3(
            GetDist(p-e.xyy),
            GetDist(p-e.yxy),
            GetDist(p-e.yyx));
        
        return normalize(n);
    }

    vec3 GetRayDir(vec2 uv, vec3 p, vec3 l, float z) {
        vec3 f = normalize(l-p),
            r = normalize(cross(vec3(0,1,0), f)),
            u = cross(f,r),
            c = f*z,
            i = c + uv.x*r + uv.y*u,
            d = normalize(i);
        return d;
    }

    void main() //this shader is pain
    {
        vec2 center = vec2(0.5, 0.5);
        //vec2 uv = (openfl_TextureCoordv.xy * iResolution.xy); //apparently this moves it to the center?????? no fuck you
        //uv = 2.0 * uv.xy / iResolution.xy;
        //vec2 m = shaderPointShit.xy/iResolution.xy;
        vec2 uv = openfl_TextureCoordv.xy - center;

        vec3 ro = vec3(0, 0, -3); //ok so -2 is the correct zoom

        ro.yz *= Rot(yMatch); //rotation shit
        ro.xz *= Rot(xMatch);
        
        vec3 rd = GetRayDir(uv, ro, vec3(0,0.,0), 1.);
        vec4 col = vec4(0);
    
        float d = RayMarch(ro, rd);

        if(d<MAX_DIST) {
            vec3 p = ro + rd * d;

            //vec3 n = GetNormal(p);  
            //vec3 r = reflect(rd, n);
            //float dif = dot(n, normalize(vec3(1,2,3)))*.5+.5;

            //uv = vec2(n.x,n.y);
            //uv = vec2(p.x,p.y) + iResolution.xy;

            //uv = (vec2(p.x,p.y) / iResolution.xy);
            uv = vec2(p.x,p.y) / 2;
            uv += center; //move coords from top left to center
            col = flixel_texture2D(bitmap, uv); //shadertoy to haxe bullshit i barely understand
        }
        
        //col = pow(col, vec4(.4545));	// gamma correction
        // makes the colour look fuckin weird
        
        gl_FragColor = col;
        //gl_FragDepth = 2;
    }
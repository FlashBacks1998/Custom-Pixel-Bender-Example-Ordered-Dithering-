package org.flashbacks.dither.assets {
    
    import flash.display.MovieClip;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.display.Shader;
    import flash.display.ShaderJob;
    import flash.display.ShaderData;
    import flash.display.ShaderInput;
    import flash.display.ShaderParameter;
    import flash.filters.ShaderFilter; 
    import flash.events.ShaderEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    
	import away3d.containers.*;
	import away3d.entities.*;
	import away3d.materials.*;
	import away3d.primitives.*;
	import away3d.utils.*;

    import org.flashbacks.dither.assets.mcHelloWorld;

	 
    public class mcScene extends MovieClip {
        [Embed(source="orderedDither.pbj", mimeType="application/octet-stream")] 
        public var shaderOrderedDitherOctetStream:Class; 
        
        public var mcBase:MovieClip;
        public var bitmapBaseData:BitmapData;
        public var bitmapBase:Bitmap;

        public var shader:Shader;
        public var shaderData:ShaderData;
        public var shaderFilter:ShaderFilter;

        public var timer:Timer;

        public function mcScene() {
            mcBase          = new mcHelloWorld();
            bitmapBaseData  = new BitmapData(mcBase.width, mcBase.height, true, 0);    
            bitmapBaseData.draw(mcBase);
            bitmapBase      = new Bitmap(bitmapBaseData);

            shader          = new Shader(new shaderOrderedDitherOctetStream());
            shaderData      = shader.data; 
            shaderData.matrixWidth.value = [4];
            shaderData.matrixHeight.value = [4];
            shaderFilter    = new ShaderFilter(shader);

            for (var prop:String in shaderData) 
            { 
                if (!(shaderData[prop] is ShaderInput) && !(shaderData[prop] is ShaderParameter)) 
                    trace("Shader metadata:", prop, "Value:", shaderData[prop]);
                else if (shaderData[prop] is ShaderInput) 
                    trace("Shader input:", prop, "Value:", shaderData[prop].input); 
                else if (shaderData[prop] is ShaderParameter) 
                    trace("Shader parameter:", prop, "Value:", shaderData[prop].value);
            } 

            // Apply the shader filter to the bitmapBase
            bitmapBase.filters = [shaderFilter];

            addChild(bitmapBase);  
        }  
    }
}

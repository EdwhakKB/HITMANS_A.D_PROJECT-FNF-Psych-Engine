import flixel.FlxG;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import lime.graphics.Image;
import flixel.FlxCamera;


//PROBABLY DOES NOT WORK ON BLITZ RENDER MODE!
//Credits to "Hazard24" for this code LMAO
class HazardAFT_Capture{
    public var time:Float = 0;

    //Set to true if you want it to not clear out the old bitmap data
    public var recursive:Bool = true; 
    
    //The camera to target (copy the pixels from)
    public var targetCAM:FlxCamera = null;
    
    //The actual bitmap data
    public var bitmap:BitmapData;
    
    //For limiting the AFT update rate. Useful to make it less framerate dependent.
    //TODO - Make a public function called limitAFT() which takes a target FPS (like the mirin template plugin)
    public var updateTimer:Float = 0.0;
    public var updateRate:Float = 0.25;
    
    //Just a basic rectangle which fills the entire bitmap when clearing out the old pixel data
    var rec:Rectangle;
    
    public function updateAFT(){
        if(!recursive){ //clear out the old bitmap data 
            bitmap.fillRect(rec, 0x00FFFFFF);
        }
        bitmap.draw(targetCAM.canvas);
        bitmap.disposeImage(); //To prevent memory leak lol
    }    
    
    public function update(elapsed:Float = 0.0){
        if(targetCAM != null && bitmap != null){
            if(updateTimer >= 0 && updateRate != 0){ updateTimer -= elapsed; }
            else if(updateTimer < 0 || updateRate == 0){
                updateTimer = updateRate;
                updateAFT();
            }
        }
    }
    
    public function new(cameraTarget:FlxCamera)
    {
        this.targetCAM = cameraTarget;
        bitmap = new BitmapData(FlxG.width,FlxG.height, true, 0x00FFFFFF);        
        rec = new Rectangle(0,0,FlxG.width,FlxG.height);
    }
}
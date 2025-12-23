package options;

import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.input.keyboard.FlxKey;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.util.FlxGradient;
import lime.system.Clipboard;
import objects.StrumNote;
import objects.Note;

class FunkinArrowSubState extends MusicBeatSubstate
{
  var onModeColumn:Bool = true;
  var curSelectedMode:Int = 0;
  var curSelectedNote:Int = 0;
  var onPixel:Bool = false;
  var dataArray:Array<String> = ["HITMANS", "INHUMAN", "FNF", "ITHIT", "MANIAHIT", "FUTURE", "CIRCLE", "STEPMANIA", "NOTITG"];
  var colorArray:Array<Array<FlxColor>>;

  var hexTypeLine:FlxSprite;
  var hexTypeNum:Int = -1;
  var hexTypeVisibleTimer:Float = 0;

  var copyButton:FlxSprite;
  var pasteButton:FlxSprite;

  var colorGradient:FlxSprite;
  var colorGradientSelector:FlxSprite;
  var colorPalette:FlxSprite;
  var colorWheel:FlxSprite;
  var colorWheelSelector:FlxSprite;

  var alphabetR:Alphabet;
  var alphabetG:Alphabet;
  var alphabetB:Alphabet;
  var alphabetHex:Alphabet;

  var modeBG:FlxSprite;
  var notesBG:FlxSprite;

  // controller support
  var controllerPointer:FlxSprite;
  var _lastControllerMode:Bool = false;
  var tipTxt:FlxText;

  public function new()
  {
    super();

    #if DISCORD_ALLOWED
    DiscordClient.changePresence("Note Colors Menu", null);
    #end

    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
    bg.screenCenter();
    bg.antialiasing = ClientPrefs.data.antialiasing;
    add(bg);

    myNotes = new FlxTypedGroup<StrumNote>();
    add(myNotes);

    var choose:Alphabet = new Alphabet(20, -10, 'Select A NoteSkin!', true);
    choose.alignment = CENTERED;
    add(choose);

    spawnNotes();
    updateNotes(true);
    FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);

    cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
  }

  var _storedColor:FlxColor;
  var changingNote:Bool = false;
  var holdingOnObj:FlxSprite;
  var allowedTypeKeys:Map<FlxKey, String> = [
    ZERO => '0', ONE => '1', TWO => '2', THREE => '3', FOUR => '4', FIVE => '5', SIX => '6', SEVEN => '7', EIGHT => '8', NINE => '9', NUMPADZERO => '0',
    NUMPADONE => '1', NUMPADTWO => '2', NUMPADTHREE => '3', NUMPADFOUR => '4', NUMPADFIVE => '5', NUMPADSIX => '6', NUMPADSEVEN => '7', NUMPADEIGHT => '8',
    NUMPADNINE => '9', A => 'A', B => 'B', C => 'C', D => 'D', E => 'E', F => 'F'
  ];

  override function update(elapsed:Float)
  {
    if (controls.BACK)
    {
      FlxG.mouse.visible = false;
      FlxG.sound.play(Paths.sound('cancelMenu'));
      close();
      return;
    }

    super.update(elapsed);

    // controller things
    var analogX:Float = 0;
    var analogY:Float = 0;
    var analogMoved:Bool = false;
    //

    // Copy/Paste buttons
    var generalMoved:Bool = (FlxG.mouse.justMoved || analogMoved);
    var generalPressed:Bool = FlxG.mouse.justPressed;

    // Click
    if (generalPressed)
    {
      if (pointerOverlaps(myNotes))
      {
        myNotes.forEachAlive(function(note:StrumNote) {
          if (curSelectedNote != note.ID && pointerOverlaps(note))
          {
            curSelectedNote = note.ID;
            ClientPrefs.data.notesSkin[0] = dataArray[note.ID];
            ClientPrefs.saveSettings();
            updateNotes();
            FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
          }
        });
      }
    }
  }

  function pointerOverlaps(obj:Dynamic)
  {
    return FlxG.mouse.overlaps(obj);
  }

  function pointerX():Float
  {
    return FlxG.mouse.x;
  }

  function pointerY():Float
  {
    return FlxG.mouse.y;
  }

  function pointerFlxPoint():FlxPoint
  {
    return FlxG.mouse.getScreenPosition();
  }

  function changeSelectionNote(change:Int = 0)
  {
    curSelectedNote += change;
    if (curSelectedNote < 0) curSelectedNote = dataArray.length - 1;
    if (curSelectedNote >= dataArray.length) curSelectedNote = 0;
    updateNotes();
    FlxG.sound.play(Paths.sound('scrollMenu'));
  }

  // alphabets
  function makeColorAlphabet(x:Float = 0, y:Float = 0):Alphabet
  {
    var text:Alphabet = new Alphabet(x, y, '', true);
    text.alignment = CENTERED;
    text.setScale(0.6);
    add(text);
    return text;
  }

  // notes sprites functions
  var myNotes:FlxTypedGroup<StrumNote>;

  public function spawnNotes()
  {
    colorArray = ClientPrefs.data.arrowRGB9;
    // clear groups
    myNotes.forEachAlive(function(note:StrumNote) {
      note.kill();
      note.destroy();
    });
    myNotes.clear();

    // respawn stuff
    Note.globalRgb9Shaders = [];
    for (i in 0...dataArray.length)
    {
      Note.initializeGlobalRGBShader(i, true);
      var newNote:StrumNote = new StrumNote(80 + (480 / dataArray.length * i) * 2.5, 200, i, -1, 'Skins/Notes/${dataArray[i]}/NOTE_assets', 'shared', false, true);
      newNote.useRGBShader = true;
      newNote.setGraphicSize(102);
      newNote.updateHitbox();
      newNote.ID = i;
      myNotes.add(newNote);
    }
    _storedColor = getShaderColor();
  }

  function updateNotes(?instant:Bool = false)
  {
    for (note in myNotes)
    {
      var newAnim:String = curSelectedNote == note.ID ? 'confirm' : 'pressed';
      note.alpha = (curSelectedNote == note.ID) ? 1 : 0.6;
      if (note.animation.curAnim == null || note.animation.curAnim.name != newAnim) note.playAnim(newAnim, true);
      if (instant) note.animation.curAnim.finish();
    }
    updateColors();

    /*for (note in mySecondNotes)
      {
        var newAnim:String = curSelectedNote == note.ID ? 'confirm' : 'pressed';
        note.alpha = (curSelectedNote == note.ID) ? 1 : 0.6;
        if (note.animation.curAnim == null || note.animation.curAnim.name != newAnim) note.playAnim(newAnim, true);
        if (instant) note.animation.curAnim.finish();
    }*/
  }

  function updateColors(specific:Null<FlxColor> = null)
    {
      var color:FlxColor = getShaderColor();
      var wheelColor:FlxColor = specific == null ? getShaderColor() : specific;
  
      var strumRGB:RGBShaderReference = myNotes.members[curSelectedNote].rgbShader;
      switch(curSelectedMode)
      {
        case 0:
          getShader().r = strumRGB.r = color;
        case 1:
          getShader().g = strumRGB.g = color;
        case 2:
          getShader().b = strumRGB.b = color;
      }
    }
  
    function setShaderColor(value:FlxColor) colorArray[curSelectedNote][curSelectedMode] = value;
    function getShaderColor() return colorArray[curSelectedNote][curSelectedMode];
    function getShader() return Note.globalRgb9Shaders[curSelectedNote];
}

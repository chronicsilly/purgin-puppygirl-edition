// i only did this because the other script fucked my brain and i didn't want to mess something up in it
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxStringUtil;

function postCreate() { // this was, very fucking stressing due to codename lagspiking for whatever fucking reason
    insert(20, clock = new FlxSprite()).loadGraphic(Paths.image("game/timer")).screenCenter(FlxAxes.X).scale.set(0.76, 0.76);
    insert(23, timerTxt = new FunkinText(0, FlxG.height - 678, 0, "X : XX", 32, true)).screenCenter(FlxAxes.X).setFormat(Paths.font("vcr.ttf"), 32, FlxColor.BLACK, "center", FlxTextBorderStyle.OUTLINE, FlxColor.RED);
    clock.cameras = timerTxt.cameras = [camHUD];
}

function update(elapsed:Float) {
    // thank you Eliza <3
    timerTxt.text = FlxStringUtil.formatTime(Conductor.songPosition / 1000, false);
}
//
import flixel.util.FlxTimer;

function create() {
    add(load = new FunkinSprite());
    load.frames = Paths.getSparrowAtlas("other/loading");
    load.animation.addByPrefix("load", "load", 12, true);
    load.antialiasing = Options.antialiasing;
    load.animation.play("load");

    new FlxTimer().start(FlxG.random.float(1.5, 2.5), ()->{ FlxG.switchState(new PlayState());});
}
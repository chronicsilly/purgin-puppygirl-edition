//
public var camTitleCard = null;

introLength = 0;
function onCountdown(fuck) {
    fuck.cancel();
}

function postCreate() {
    FlxG.cameras.add(camTitleCard = new HudCamera(), false);
    camTitleCard.bgColor = FlxColor.TRANSPARENT;

    add(intro = new FunkinSprite().loadGraphic(Paths.image("game/songtitles/" + SONG.meta.name)));
    intro.screenCenter(); intro.x += 15; intro.y = 105; intro.scale.set(1.5, 1.5);
    intro.cameras = [camTitleCard]; intro.antialiasing = Options.antialiasing;

    new FlxTimer().start(1.5, function(_:FlxTimer)
        {
            FlxTween.tween(camTitleCard, {alpha: 0}, (Conductor.stepCrochet / 1000) * 12);
        });
}
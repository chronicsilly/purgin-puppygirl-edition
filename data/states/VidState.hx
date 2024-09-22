import hxvlc.flixel.FlxVideoSprite;

function create() {
    add(vid = new FlxVideoSprite());
    vid.load(Assets.getPath(Paths.file('videos/intro.mp4')));
    vid.antialiasing = true;
    vid.bitmap.onEndReached.add(function() FlxG.switchState(new ModState("MyNewTitles")));
    vid.play();
}

function update()
    if(controls.ACCEPT)
        FlxG.switchState(new ModState("MyNewTitles"));
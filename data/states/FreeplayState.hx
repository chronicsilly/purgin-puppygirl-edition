//
function postCreate() {
    insert(0, purp = new FunkinSprite().loadGraphic(Paths.image("menus/freeplay/purp")));
    purp.alpha = 0;
    insert(0, new FunkinSprite().loadGraphic(Paths.image("menus/freeplay/back")));
    bg.visible = false;
    diffText.color = scoreText.color = FlxColor.RED;
}

function postUpdate() {
    scoreBG.scale.y *= 1.25;
    if (controls.BACK) {
		CoolUtil.playMenuSFX(CANCEL, 0.7);
		FlxG.switchState(new ModState("MyNewMenus"));
	}
}

function onSelect(e) {
    e.cancel();
    FlxTween.tween(FlxG.camera, {zoom: 3}, 0.5, {ease: FlxEase.quadInOut});
    FlxTween.tween(purp, {alpha: 1}, 0.25);
    FlxTween.tween(FlxG.camera, {alpha: 1}, 0.25, {
        onComplete: function(twn) {
            Options.freeplayLastSong = songs[curSelected].name;
            Options.freeplayLastDifficulty = songs[curSelected].difficulties[curDifficulty];
            PlayState.loadSong(songs[curSelected].name);
            FlxG.switchState(new ModState("Load"));
        }, ease: FlxEase.quadInOut
    });
}
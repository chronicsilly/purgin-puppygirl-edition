//
function postCreate() {
    camHUD.alpha = 0;
    camGame.zoom = defaultCamZoom = 0.3;

    strumLines.members[0].characters[1].visible = false;
    strumLines.members[0].characters[1].x -= 50;
    strumLines.members[0].characters[1].y -= 25;
}

function stepHit(curStep:Int) {
    switch (curStep) {
        case 0:
            FlxTween.tween(camHUD, {alpha: 1}, (Conductor.stepCrochet / 1000) * 10, {ease: FlxEase.quadInOut});
            FlxTween.num(camGame.zoom, 0.8, (Conductor.stepCrochet / 1000) * 128, {ease: FlxEase.cubeInOut, onComplete: function(twn) defaultCamZoom = 0.4}, function(a) camGame.zoom = defaultCamZoom = a);
        case 128:
            strumLines.members[0].characters[0].visible = false;
            strumLines.members[0].characters[1].visible = true;
        case 132:
            strumLines.members[0].characters[0].visible = true;
            strumLines.members[0].characters[1].visible = false;
        case 148 | 152 | 156 | 180 | 184 | 188:
            defaultCamZoom += 0.1;
        case 160 | 192 | 256 | 288 | 320 | 352 | 384 | 616 | 800 | 832:
            defaultCamZoom = 0.4;
        case 224 | 796 | 2020:
            defaultCamZoom = 0.7;
        case 240 | 272 | 304 | 342 | 512 | 544 | 576 | 608 | 790 | 816:
            defaultCamZoom = 0.6;
        case 368:
            defaultCamZoom = 0.55;
        case 520 | 552 | 584 | 784:
            defaultCamZoom -= 0.1;
        case 1152:
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * 12);
        case 1168:
            strumLines.members[0].characters[0].visible = false;
            strumLines.members[0].characters[1].visible = true;
            strumLines.members[0].characters[1].playAnim("anim", true);
        case 1183 | 1200:
            FlxTween.tween(camFollow, {x: 1183 ? 430 : -230}, (Conductor.stepCrochet / 1000) * (1183 ? 26 : 26*2));
        case 1216:
            camGame.flash(FlxColor.WHITE, (Conductor.stepCrochet / 1000) * 16);
            defaultCamZoom = 0.3;
            stage.stageSprites["bg_chars_left"].alpha = stage.stageSprites["bg_chars_right"].alpha = stage.stageSprites["foregroundies"].alpha = camHUD.alpha = 1;
        case 1472:
            stage.stageSprites["bg_chars_left"].animation.addByPrefix("cheer");
            stage.stageSprites["bg_chars_left"].playAnim("cheer", true);
            stage.stageSprites["bg_chars_right"].animation.addByPrefix("cheer");
            stage.stageSprites["bg_chars_right"].playAnim("cheer", true);
        case 1984:
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * (13 * 7));
        case 2050:
            FlxTween.tween(camGame, {alpha: 0}, (Conductor.stepCrochet / 1000) * 40);
    }
}

function onGameOver(e) {
    e.deathCharID = "bf-bitingthecurb";
    e.gameOverSong = e.gameOverSong + "-SANFORD";
    e.lossSFX = e.lossSFX + "-SANFORD";
    e.retrySFX = e.retrySFX + "-SANFORD";
}
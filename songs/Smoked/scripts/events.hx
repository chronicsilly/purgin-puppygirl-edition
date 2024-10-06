//
function postCreate(){
    camHUD.alpha = 0;
}

function stepHit(curStep:Int) {
    switch (curStep) {
        case 32: FlxTween.tween(camHUD, {alpha: 1}, (Conductor.stepCrochet / 1000) * 10, {ease: FlxEase.quadInOut});
        case 64: defaultCamZoom = 0.5;
        case 70: defaultCamZoom = 0.6;
        case 76: defaultCamZoom = 0.7;
        case 80 | 324 | 352 | 372 | 656 | 702 | 724 | 916 | 1088 | 1136 | 1200 | 1232 | 1264: defaultCamZoom = 0.45;
        case 288 | 320 | 340 | 344 | 646 | 718 | 748 | 782 | 904 | 1190 | 1222 | 1254 | 1328: defaultCamZoom = 0.65;
        case 356: defaultCamZoom = 0.55;
        case 360: defaultCamZoom = 0.65;
        case 364: defaultCamZoom = 0.75;
        case 368 | 544 | 640 | 736 | 772 | 800 | 1088 | 1120 | 1184 | 1248 | 1216: defaultCamZoom = 0.55;
        case 416: defaultCamZoom = 0.4;
        case 576: defaultCamZoom = 0.55;
        case 582 | 652: defaultCamZoom = 0.75;
        case 672 | 708 | 716: defaultCamZoom = 0.5;
        case 684 | 748 | 788 | 1196 | 1228 | 752: defaultCamZoom = 0.7;
        case 696 | 760: defaultCamZoom = 0.8;
        case 700: defaultCamZoom = 0.85;
        case 800 | 776: defaultCamZoom = 0.45;
        case 760 | 672: defaultCamZoom = 0.5;
        case 1344:
            defaultCamZoom = 0.4;
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * 10, {ease: FlxEase.quadInOut});
            FlxTween.tween(camGame, {alpha: 0}, (Conductor.stepCrochet / 1000) * 36, {ease: FlxEase.quadInOut});
        case 1353 | 1357: defaultCamZoom += 0.1;
        case 832:
            defaultCamZoom = 0.45;
            var intro = new FunkinSprite().loadGraphic(Paths.image("game/songtitles/smoked_thing"));
            intro.screenCenter();
            add(intro);
            intro.scrollFactor.x = intro.scrollFactor.y = intro.zoomFactor = 0;
            intro.scale.x = intro.scale.y = 1.5;
            new FlxTimer().start((Conductor.stepCrochet / 1000) * 4, ()->{remove(intro.destroy(), true);});
    }
}

function onNoteHit(e)
    if(e.noteType == "Hey!" || e.noteType == "No Animation") {
        e.cancelAnim();
        if (e.noteType == "Hey!") e.character.playAnim("hey", true);
    }
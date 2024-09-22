import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;

var centerIcon:HealthIcon = new HealthIcon("middleIcons/" + SONG.meta.name);

var bar:FlxBar;
var rating:FunkinSprite;

var angle:Float = 0;

function postCreate() {
    accuracyTxt.y = missesTxt.y = scoreTxt.y += 20;
    healthBar.visible = healthBarBG.visible = doIconBop = false;

    insert(0, centerIcon);
    centerIcon.y = iconP1.y;

    add(rating = new FunkinSprite());
    rating.loadSprite(Paths.image('game/rating'));
    for(a in ["sick", "good", "bad", "shit"])
        rating.animateAtlas.animation.addByPrefix("combo stuff/" + a, "combo stuff/" + a, 24, false);
    rating.alpha = 0;
    
    insert(0, border = new FunkinSprite(0, FlxG.height - (195 * 0.9)).loadGraphic(Paths.image("game/bar/border")));
    border.screenCenter(FlxAxes.X);

    insert(0, bar = new FlxBar(0, FlxG.height - (195 * 0.9), FlxBarFillDirection.RIGHT_TO_LEFT, border.width, border.height, this, 'health', 0, maxHealth));
    bar.createImageBar(Paths.image("game/bar/bar-" + strumLines.members[0].characters[0].curCharacter), Paths.image("game/bar/bar-" + strumLines.members[1].characters[0].curCharacter));
    bar.screenCenter(FlxAxes.X);
    
    var intro = new FunkinSprite().loadGraphic(Paths.image("game/songtitles/" + SONG.meta.name));
    intro.screenCenter();
    add(intro);
    intro.scrollFactor.x = intro.scrollFactor.y = intro.zoomFactor = 0;
    intro.scale.x = intro.scale.y = 1.5;
    FlxTween.tween(intro, {alpha: 0}, (Conductor.stepCrochet / 1000) * 16, {
        startDelay: (Conductor.stepCrochet / 1000) * 20, onComplete: function(twn) remove(intro.destroy(), true)
    });

    border.camera = bar.camera = rating.camera = centerIcon.camera = camHUD;
    border.antialiasing = bar.antialiasing = rating.antialiasing = centerIcon.antialiasing = intro.antialiasing = Options.antialiasing;

}

function beatHit(curBeat:Int) iconP1.scale.x = iconP1.scale.y = iconP2.scale.x = iconP2.scale.y = centerIcon.scale.x = centerIcon.scale.y = 1.2;

function update() {
    iconP1.scale.x = iconP1.scale.y = iconP2.scale.x = iconP2.scale.y = centerIcon.scale.x = centerIcon.scale.y = lerp(centerIcon.scale.y, 1, 0.33);
}

function postUpdate() {
    camGame.angle = FlxMath.lerp(camGame.angle, angle, 0.05);

    switch(strumLines.members[curCameraTarget].characters[0].getAnimName()){
        case "singLEFT" | "singLEFT-alt": camFollow.x -= 30; angle = -2;
        case "singRIGHT" | "singRIGHT-alt": camFollow.x += 30; angle = 2;
        case "singDOWN" | "singDOWN-alt": camFollow.y += 30; angle = 0;
        case "singUP" | "singUP-alt": camFollow.y -= 30; angle = 0;
        case "idle": angle = 0;
    }

    centerIcon.x = bar.x + (bar.width * (FlxMath.remapToRange(bar.percent, 0, 100, 1, 0)) - 75);
    centerIcon.visible = (iconP1.animation.curAnim.curFrame == 0 && iconP2.animation.curAnim.curFrame == 0);
    iconP1.x = bar.x + bar.width - 150;
    iconP2.x = bar.x + 75/2;
}

function onPostNoteCreation(e)
    if(!e.note.isSustainNote)
        e.note.offset.set([9, 26, 4, -3.5][e.strumID], 0);

var lastChar:Int = 0;
var daRating:String;

function onCameraMove() {
    if(curCameraTarget == 0 && lastChar != 0) {
        rating.alpha = 1;
        rating.playAnim("combo stuff/" + daRating, true);
        if(daRating == "sick") strumLines.members[2].characters[0].playAnim("cheer", true);
        FlxTween.tween(rating, {alpha: 0}, (Conductor.crochet / 1000) * 4);
        rating.screenCenter();
    }
    lastChar = curCameraTarget;
}

function onPlayerHit(e) daRating = e.rating;
function onCountdown(e) e.cancel();
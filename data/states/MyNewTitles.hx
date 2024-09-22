// SHITTY AND RUSHED CODE WHY DID THEY GIVE ME THE ASSETS HOURS BEFORE RELEASE
var cool:CustomShader = new CustomShader("coolShit");

var cameraBG = new FlxCamera();
var cameraOverlay = new FlxCamera();

var bop:Bool = true;

function create(){
    CoolUtil.playMenuSong();
    Conductor.changeBPM(187);
    cameraOverlay.flash(FlxColor.WHITE, 1);
	
    for(a in [cameraBG, cameraOverlay]){
        FlxG.cameras.add(a, false);
        a.bgColor = FlxColor.TRANSPARENT;
    }
    cameraBG = camera;

    add(bg = new FunkinSprite().loadGraphic(Paths.image("menus/main/bg")));
    bg.shader = cool;
    FlxTween.tween(bg, {x: FlxG.width - bg.width}, 10, {type: FlxTween.PINGPONG, ease: FlxEase.quadInOut});

    add(hank = new FunkinSprite());
    hank.frames = Paths.getSparrowAtlas("menus/main/hank");
    hank.animation.addByPrefix("hank", "hank", 24, false);
    hank.scale.x = hank.scale.y = 1.1;
    hank.updateHitbox();
    hank.screenCenter(FlxAxes.X);
    hank.x += 25;
    hank.y = FlxG.height - hank.height/1.1 + 75;

    add(logo = new FunkinSprite().loadGraphic(Paths.image("menus/main/logo")));
    logo.screenCenter();
    logo.y += 200;

    logo.camera = hank.camera = cameraOverlay;

    bg.antialiasing = logo.antialiasing = hank.antialiasing = Options.antialiasing;

    cameraBG.addShader(fisheye = new CustomShader("fisheye"));
    fisheye.MAX_POWER = 0.15;

    cool.Threshold = 0.35;
    cool.Soft = 0.001;
}

function update(elapsed:Float) {
    cameraBG.scroll.x = FlxMath.lerp(cameraBG.scroll.x, (FlxG.mouse.screenX-(bg.width/2)) * 0.1, (1/30) * 240 * elapsed);
    logo.scale.x = logo.scale.y = lerp(logo.scale.y, 0.7, 0.33);
    if(controls.ACCEPT) {
        bop = false;
        cameraBG.flash(FlxColor.WHITE, 0.5);
        FlxTween.num(0.35, 0, 0.5, {
            ease: FlxEase.quadInOut, onComplete: function(twn) {
                cameraBG.fade(FlxColor.BLACK, 0.5);
                FlxTween.tween(logo, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
                FlxTween.tween(hank, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
                FlxTween.tween(cameraOverlay, {zoom: 2}, 1, {ease: FlxEase.quadInOut, onComplete: function(idk) FlxG.switchState(new ModState("MyNewMenus"))});
            }}, function(a) cool.Soft = a);

    }
}

function beatHit(curBeat:Int) {
    hank.animation.play("hank");
    if(bop)
        logo.scale.x = logo.scale.y = 0.8;
}

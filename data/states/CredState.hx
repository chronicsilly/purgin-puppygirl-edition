// WORST CODE IVE EVER WRITTEN PLEASE END ME
var creds:Array<FunkinSprite> = [];
var arrows:Array<FunkinShader> = [];
var curSelect:Int = 0;

var lol:FunkinText = new FunkinText(0, FlxG.height - 30, 0, "(i coded this all in 2 days help)", 20);

function create() {
    add(new FunkinSprite().loadGraphic(Paths.image("menus/credits/back")));

    var credits = CoolUtil.coolTextFile(Paths.file('images/menus/credits/_.txt'));
    for (a in 0...credits.length) {
        creds.push(new FunkinSprite().loadGraphic(Paths.image("menus/credits/creds/" + credits[a])));
        creds[a].x = FlxG.width / 1.5 + (FlxG.width * (a - curSelect)) - creds[a].width / 2;
        creds[a].screenCenter(FlxAxes.Y);
        add(creds[a]);
    }        
    add(side = new FunkinSprite().loadGraphic(Paths.image("menus/credits/sidebar")));
    add(logo = new FunkinSprite().loadGraphic(Paths.image("menus/credits/logo")));
    logo.setPosition(side.x + side.width / 2 - logo.width/1.75, 100);
    for(a in 0...2) {arrows.push(new FunkinSprite(a == 0 ? creds[0].x - 48 - 5 : creds[0].x + creds[0].width + 5, creds[0].y + creds[0].height/2 - 57/2).loadGraphic(Paths.image("menus/credits/arrow"))); add(arrows[a]); arrows[a].alpha = 0.25; arrows[a].flipX = a == 1;}
    add(msg = new FunkinText(5, 275, 0, "Hey it's me Eli, thank you so much for playing this mod! It means a lot to us since we all worked hard to push out an update. I hope you enjoyed what you saw n listened to and hopefully there'll be more content soon in the future! Y'all should really check out the rest of the team tho because this mod wouldn't have been possible without their help, please support them for all they've done. Happy madness day (+)", 24));
    msg.fieldWidth = side.width - 35;
    msg.antialasing = Options.antialasing;
    changeSelect(0);
    FlxG.state.forEachOfType(FunkinSprite, sprite -> sprite.antialiasing = Options.antialasing);
}

function update() {
    if(controls.BACK)
        FlxG.switchState(new ModState("MyNewMenus"));
    if(controls.LEFT_P || controls.RIGHT_P)
        changeSelect(controls.LEFT_P ? -1 : 1);
}

function changeSelect(a:Int) {
    FlxTween.num(1, 0.25, 0.5, {}, function(z) arrows[a == -1 ? 0 : 1].alpha = z);
    curSelect = FlxMath.wrap(curSelect + a, 0, creds.length - 1);
    for(a in 0...creds.length)
        FlxTween.tween(creds[a], {x: FlxG.width / 1.5 + (FlxG.width * (a - curSelect)) - creds[a].width / 2}, 0.5, {ease: FlxEase.cubeInOut});
}
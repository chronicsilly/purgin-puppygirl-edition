//
import funkin.options.OptionsMenu;
import funkin.menus.ModSwitchMenu;

var buttons:Array<FunkinSprite> = [];
var shader = new FunkinShader("
    #pragma header
    void main() {
        vec2 uv = openfl_TextureCoordv;
        vec4 tex = flixel_texture2D(bitmap, uv);
        vec3 greyScale = vec3(.5, .5, .5);
        gl_FragColor = vec4(vec3(dot( tex.rgb, greyScale)), tex.a);
    }");
var curSelect:Int = 0;

function create() {
    CoolUtil.playMenuSong();
    Conductor.changeBPM(187);
    add(bg = new FunkinSprite(FlxG.width).loadGraphic(Paths.image("menus/main/bg")));
    add(border = new FunkinSprite(FlxG.width).loadGraphic(Paths.image("menus/main/border")));
    for(a in 0...2) FlxTween.tween([bg, border][a], {x: FlxG.width/2 - [bg, border][a].width / 2}, 1, {ease: FlxEase.quadInOut, startDelay: (a + 1) / 10});
    bg.antialiasing = border.antialiasing = Options.antialiasing;
    border.scrollFactor.x = border.scrollFactor.y = 0;
    
    for(a in 0...4) {
        buttons.push(new FunkinSprite());
        buttons[a].frames = Paths.getSparrowAtlas("menus/main/button_" + ["story", "freeplay", "settings", "credits"][a]);
        buttons[a].animation.addByPrefix("anim", "anim", 24, true);
        buttons[a].animation.play("anim");
        buttons[a].scale.x = buttons[a].scale.y = 0.825;
        buttons[a].antialiasing = Options.antialiasing;
        buttons[a].x = FlxG.width - buttons[a].width/1.3;
        buttons[a].y = FlxG.height / 4 * (a + 1) - buttons[a].height + buttons[a].height/4;
        buttons[a].shader = shader;
        buttons[a].scrollFactor.x = buttons[a].scrollFactor.y = 0;
        buttons[a].updateHitbox();
        add(buttons[a]);
    }
    PlayState.loadWeek({"songs": [{"name": "smoked"}, {"name": "bite the curb"}]});
    changeSelect(0);
}

function update(elapsed:Float) {
    if(controls.ACCEPT && bg.x == FlxG.width/2 - bg.width / 2) {
        FlxG.switchState([new ModState("Load"), new FreeplayState(), new OptionsMenu(), new ModState("CredState")][curSelect]);
    }
    if(controls.UP_P || controls.DOWN_P)
        changeSelect(controls.UP_P ? -1 : 1);
    if (controls.SWITCHMOD) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }
}

function changeSelect(a:Int) {
    buttons[curSelect].shader = shader;
    curSelect = FlxMath.wrap(curSelect + a, 0, buttons.length - 1);
    buttons[curSelect].shader = null;
}

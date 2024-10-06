//
import openfl.display.BlendMode;

function postCreate()
    upperdust.blend = lowerfog.blend = BlendMode.ADD;

function postUpdate() {
    windowlight.color = switch (strumLines.members[curCameraTarget].characters[0].getAnimName()) {
        default: FlxColor.WHITE;
        case "singUP" | "singUP-alt": 0xff12fa05;
        case "singDOWN" | "singDOWN-alt": 0xff00ffff;
        case "singLEFT" | "singLEFT-alt": 0xffc24b99;
        case "singRIGHT" | "singRIGHT-alt": 0xfff9393f;
    }
}
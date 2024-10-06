//
import funkin.backend.system.framerate.Framerate;
import funkin.menus.credits.CreditsMain;

var redirectStates:Map<FlxState, String> = [
	TitleState => "VidState",
	//MainMenuState => "MyNewTitles",
	//StoryMenuState => "MyNewMenus",
	//CreditsMain => "CredState"
];

function new() {
	FlxG.save.data.titles = false;
	Framerate.debugMode = 0;
}

function preStateSwitch() {
		for (redirectState in redirectStates.keys()) 
			if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}
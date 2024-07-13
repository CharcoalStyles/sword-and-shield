package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.text.FlxText.FlxTextAlign;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import utils.CsMenu;
import utils.GlobalState;
import utils.SplitText;

class MainMenu extends FlxState
{
	var gameName:String = "Sword & Shield";
	var globalState:GlobalState;
	var menu:CsMenu;

	var startText1:FlxText;
	var startText2:FlxText;

	var menuShowing = false;

	override public function create()
	{
		super.create();
		globalState = new GlobalState();
		FlxG.plugins.addPlugin(globalState);

		FlxG.mouse.visible = true;

		var title = generateTitle();
		add(title);
		title.x = (FlxG.width - title.width) / 2;
		title.y = 96;

		startText1 = new FlxText(0, 0, FlxG.width, "Press any button to begin");
		startText1.setFormat(null, 24, FlxColor.WHITE, CENTER);
		add(startText1);

		startText2 = new FlxText(0, 0, FlxG.width, "This demo is made only for controllers");
		startText2.setFormat(null, 16, FlxColor.WHITE, CENTER);
		add(startText2);

		startText1.y = FlxG.height / 2;
		startText2.y = FlxG.height / 2 + (startText1.height * 1.5);

		globalState.createEmitter();
		add(globalState.emitter.activeMembers);

		FlxG.gamepads.deviceConnected.addOnce((gp) ->
		{
      menuShowing = true;
			globalState.controllerId = gp.id;
			remove(startText1);
			remove(startText2);
			generateMenu();
			add(menu);
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// check to see if any buttons are pressed
		if (!menuShowing && FlxG.gamepads.firstActive != null)
		{
			if (FlxG.gamepads.firstActive.justPressed.ANY)
			{
        menuShowing = true;
				globalState.controllerId = FlxG.gamepads.firstActive.id;
				remove(startText1);
				remove(startText2);
				generateMenu();
				add(menu);
			}
		}
	}

	function generateMenu()
	{
		// hardcoding the gamepad stuff,as right now the test is only for gamepads
		// Also, this funciton is only called when the a gamepad button is pressed.
		var gamepadId = FlxG.gamepads.firstActive.id;

		menu = new CsMenu(FlxG.width / 2, FlxG.height / 2, FlxTextAlign.CENTER, {
			keyboard: false,
			mouse: false,
			gamepad: true,
			gamepadId: gamepadId,
		});
		var mainPage = menu.createPage("Main");

		mainPage.addItem("New Game", () ->
		{
			FlxG.switchState(new PlayState());
		});
		mainPage.addItem("Toggle Fullscreen", () -> FlxG.fullscreen = !FlxG.fullscreen);
	}

	function generateTitle()
	{
		var text = new SplitText(0, 0, gameName, SplitText.naiieveScaleDefaultOptions(2.5));
		text.color = 0xff000000;
		text.borderColor = 0xffffffff;
		text.borderQuality = 4;
		text.borderSize = 2;
		text.borderStyle = OUTLINE;
		text.animateWave(5, 0.1, 1.5, false);
		text.animateColourByArray([0xff000000, 0xff333333], 0.075, 0.6,);

		return text;
	}
}

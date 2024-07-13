package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import utils.GlobalState;

class PlayState extends FlxState
{
	var globalState:GlobalState;

	var player:FlxSprite;

	override public function create()
	{
		super.create();
		globalState = FlxG.plugins.get(GlobalState);

		player = new FlxSprite();
		player.makeGraphic(64, 64, FlxColor.RED);
		player.screenCenter();
		add(player);

		// FlxG.gamepads.firstActive
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.log.add('gamepads.firstActive: ${FlxG.gamepads.firstActive}');
		player.x = FlxG.mouse.screenX;
		player.y = FlxG.mouse.screenY;
	}
}

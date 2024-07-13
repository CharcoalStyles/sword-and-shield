package states;

import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import utils.GlobalState;

class PlayState extends FlxState
{
	var globalState:GlobalState;

	var player:Player;

	override public function create()
	{
		super.create();
		globalState = FlxG.plugins.get(GlobalState);

		player = new Player();
		add(player);
	}
}

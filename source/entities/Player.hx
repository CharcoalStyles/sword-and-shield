package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import utils.GlobalState;

class Player extends FlxGroup
{
	var globalState:GlobalState;

	var player:FlxSprite;
	var sword:FlxSprite;

	// var shield:FlxSprite;

	public function new()
	{
		globalState = FlxG.plugins.get(GlobalState);
		super();

		var t1 = new FlxText(0, 0, 0, "Left Stick to move");
		t1.setFormat(null, 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    t1.x = (FlxG.width - t1.width) / 2;
    t1.y = 32;
		add(t1);

		var t2 = new FlxText(0, 0, 0, "Right Stick to attack with sword");
		t2.setFormat(null, 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    t2.x = (FlxG.width - t2.width) / 2;
    t2.y = 64;
		add(t2);

		player = new FlxSprite(0, 0);
		player.makeGraphic(64, 64, FlxColor.RED);
		player.screenCenter();
		add(player);
		add(player);
		sword = new FlxSprite(0, 0);
		sword.makeGraphic(8, 96, FlxColor.WHITE);
		sword.origin.set(4, 96);
		add(sword);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		var gamepad = FlxG.gamepads.getByID(globalState.controllerId);
		if (gamepad != null)
		{
			var playerStickX = gamepad.analog.value.LEFT_STICK_X;
			var playerStickY = gamepad.analog.value.LEFT_STICK_Y;

			player.velocity.x = playerStickX * 250;
			player.velocity.y = playerStickY * 250;

			var playerAngle = Math.atan2(playerStickX, playerStickY * -1);
			player.angle = (playerAngle * 180) / Math.PI;

			var swordStickX = gamepad.analog.value.RIGHT_STICK_X;
			var swordStickY = gamepad.analog.value.RIGHT_STICK_Y;

			var swordAngle = Math.atan2(swordStickX, swordStickY * -1);
			sword.angle = (swordAngle * 180) / Math.PI;

			var swordLength = FlxPoint.get(swordStickX, swordStickY).length;
			if (swordLength > 0.5)
			{
				sword.scale.y = Math.min(1, swordLength);
			}
			else
			{
				sword.scale.y = 0;
			}
		}

		sword.x = player.x + player.width / 2 - sword.width / 2;
		sword.y = player.y - player.height / 2 - (sword.height - player.height);
	}
}

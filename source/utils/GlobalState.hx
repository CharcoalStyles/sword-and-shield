package utils;

import entities.effects.CsEmitter;
import flixel.FlxBasic;
import utils.Observer.FloatObservable;
import utils.Observer.IntObservable;


class GlobalState extends FlxBasic
{
	public var isUsingController:Bool = false;
	public var controllerId:Int = 0;
	public var emitter:CsEmitter;

	public function new()
	{
		super();
		emitter = new CsEmitter();
	}

	public function createEmitter()
	{
		emitter = new CsEmitter();
	}
}

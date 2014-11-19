package pl.patryk1303.fuzzyLighty.cars;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import pl.patryk1303.fuzzyLighty.enums.CarDirection;

/**
 * ...
 * @author Patryk Wychowaniec
 */
class Emmiter extends FlxSprite
{
	public var _dir:CarDirection;
	public function new(?X:Float = 0, ?Y:Float = 0, ?_dir:CarDirection, ?Color:Int = FlxColor.CHARCOAL) {
		super(X,Y);
		if (_dir == null)
			this._dir = CarDirection.UP;
		else
			this._dir = _dir;
		makeGraphic(8, 8, Color);
	}
	
}
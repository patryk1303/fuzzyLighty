package pl.patryk1303.fuzzyLighty.road;

import flixel.FlxSprite;

/**
 * ...
 * @author Patryk Wychowaniec
 */
class StopArea extends FlxSprite
{

	private var siz1 = 38;
	private var siz2 = 61;
	
	public function new(X:Float=0, Y:Float=0, _isHor:Bool)
	{
		super(X, Y);
		if(_isHor) {
			makeGraphic(siz1, siz2, 0x33FFFF00);
			width = siz1;
			height = siz2;
		}
		else {
			makeGraphic(siz2, siz1, 0x33FFFF00);
			width = siz2;
			height = siz1;
		}
	}
	
}
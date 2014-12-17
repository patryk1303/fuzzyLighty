package pl.patryk1303.fuzzyLighty.cars;


import flixel.FlxSprite;
/**
 * ...
 * @author Maciej Czurak
 */
class CarDetector extends FlxSprite
{

	public function new(X:Float = 0, Y:Float = 0, isHor:Bool) 
	{
		super(X, Y);
		if (isHor) {
			makeGraphic(1, 80, 0x3333AA00);
			width = 1;
			height = 80;
		}
		else {
			makeGraphic(80, 1, 0x3333AA00);
			width = 80;
			height = 1;
		}
	}
	
}
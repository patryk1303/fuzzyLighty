package pl.patryk1303.fuzzyLighty.cars;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
import pl.patryk1303.fuzzyLighty.enums.CarDirection;

/**
 * ...
 * @author ...
 */
class Car extends FlxSprite
{
	public var direction:CarDirection;
	var mA:Float = 0;
	var speed:Float = 100;
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?_dir:CarDirection, ?_color:Int) 
	{
		super(X, Y);
		if (_dir == null)
			direction = CarDirection.UP;
		else
			direction = _dir;
		loadGraphic(AssetPaths.CarBlue__png, false, 82, 123);
		if (_color == 1)
			loadGraphic(AssetPaths.CarRed__png, false, 82, 123);
		drag.x = drag.y = 50;
	}
	
	override public function update():Void 
	{
		switch(direction) {
			case LEFT:	mA = angle = 270;
			case UP:	mA = angle = 0;
			case RIGHT:	mA = angle = 90;
			case DOWN:	mA = angle = 180;
		}
		FlxAngle.rotatePoint(0, speed, 0, 0, mA, velocity);
		super.update();
	}
	
	override public function draw():Void 
	{
		super.draw();
	}
	
	public function stop() {
		speed = 0;
	}
	public function start() {
		speed = 100;
	}
}
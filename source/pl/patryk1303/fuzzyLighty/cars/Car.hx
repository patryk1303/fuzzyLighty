package pl.patryk1303.fuzzyLighty.cars;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
import flixel.util.FlxCollision;
import flixel.FlxG;
import pl.patryk1303.fuzzyLighty.enums.CarDirection;

/**
 * ...
 * @author ...
 */
class Car extends FlxSprite
{
	public var direction:CarDirection;
	var mA:Float = 0;
	var maxSpeed:Float = 80;
	var speed:Float;
	public var touchedStoper:Bool = false;
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?_dir:CarDirection, ?_color:Int, ?_scale:Float = 0.3) 
	{
		super(X, Y);
		speed = maxSpeed;
		if (_dir == null)
			direction = CarDirection.UP;
		else
			direction = _dir;
		loadGraphic(AssetPaths.CarBlue__png, false, 82, 123);
		if (_color == 1)
			loadGraphic(AssetPaths.CarRed__png, false, 82, 123);
		drag.x = drag.y = 50;
		scale.set(_scale, _scale);
		updateHitbox();
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
		if (speed < maxSpeed)
			start();
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
		speed = maxSpeed;
	}
	public function orange_stopping() {
		while (speed >= maxSpeed/2)
			speed--;
	}
	public function orange_starting() {
		while (speed <= maxSpeed/2)
			speed++;
	}
	public function checkAnotherCars() {
		
	}
}
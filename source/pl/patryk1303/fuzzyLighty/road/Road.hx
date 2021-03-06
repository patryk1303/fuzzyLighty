package pl.patryk1303.fuzzyLighty.road;

import flixel.FlxSprite;
import pl.patryk1303.fuzzyLighty.enums.CarDirection;

/**
 * ...
 * @author Patryk Wychowaniec
 */
class Road extends FlxSprite {

	public var originPoints:Array<Array<Dynamic>> = new Array<Array<Dynamic>>();
	public var lightPoints:Array<Array<Int>> = new Array<Array<Int>>();
	public var stopAreaPoints = new Array<Array<Int>>();
	
	public function new(X:Float=0, Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.road__png, false, 640, 480);
		originPoints = [[330, 480, CarDirection.UP], [290, 0, CarDirection.DOWN], [0, 245, CarDirection.RIGHT], [640, 200, CarDirection.LEFT]]; //bottom, top, left, right
		lightPoints = [[370, 290, 0], [230, 290, 90], [255, 150, 180], [370, 150, 270]]; //bottom, left, top, right
		stopAreaPoints = [[320, 338-55], [222 + 11, 277-40], [283, 202-40], [358 + 11, 240-40]]; //bottom, left, top, right
	}
	
	public override function draw() {
		
		super.draw();
	}
	
	override public function update() {
		
		super.update();
	}
	
}
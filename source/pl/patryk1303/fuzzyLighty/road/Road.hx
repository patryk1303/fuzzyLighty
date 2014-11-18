package pl.patryk1303.fuzzyLighty.road;

import flixel.FlxSprite;

/**
 * ...
 * @author Patryk Wychowaniec
 */
class Road extends FlxSprite {

	public function new(X:Float=0, Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.road__png, false, 300, 300);
		width = 300;
		height = 300;
	}
	
	public override function draw() {
		
		super.draw();
	}
	
	override public function update() {
		
		super.update();
	}
	
}
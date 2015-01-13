package pl.patryk1303.fuzzyLighty.lights;

import source.pl.patryk1303.fuzzyLighty.enums.LightStates;
import flixel.FlxSprite;
import flixel.FlxG;

/**
 * ...
 * @author Patryk Wychowaniec
 */
class Lights extends FlxSprite {
	
	public var currentState:LightStates  = GREEN;
	private var sterVal:Int  = 10;
	public var ster:Int = 10;
	public var isSter:Bool = false;
	
	//[orange,red,red-orange,green]
	public var lightTimes = [100, 300, 100, 300];

	public function new(x:Float = 16, y:Float = 16, ?rotate = 0, ?state:LightStates) {
		super(x, y);
		ster = lightTimes[0];
		if (state == null)
			currentState = GREEN;
		else
			currentState = state;
		loadGraphic(AssetPaths.lights__png, false, 128, 256);
		animation.add("green", [0], 0, false);
		animation.add("orange", [1], 0, false);
		animation.add("red", [2], 0, false);
		animation.add("redorange", [3], 0, false);
		width = 128;
		height = 256;
		this.angle = rotate;
	}
	
	public function setGreenLight(time:Int) {
		lightTimes[3] = time;
	}
	public function setRedLight(time:Int) {
		lightTimes[1] = time;
	}
	
	public override function draw() {
		switch(currentState) {
			case GREEN: animation.play("green");
			case RED: animation.play("red");
			case RED_ORANGE: animation.play("redorange");
			case ORANGE: animation.play("orange");
		}
		
		super.draw();
	}
	
	public override function update() {
		#if debug
		sterring();
		#end
		phasing();
		super.update();
	}
	
	private function phasing() {
		
		if (isSter) {
			isSter = false;
			switch(currentState) {
				case GREEN: 		ster = lightTimes[0];
									currentState = ORANGE;
				case ORANGE: 		ster = lightTimes[1];
									currentState = RED;
				case RED: 			ster = lightTimes[2];
									currentState = RED_ORANGE;
				case RED_ORANGE:	ster = lightTimes[3];
									currentState = GREEN;
			}
		}
		
		if (!isSter) {
			ster--;
			if (ster <= 0) {
				isSter = true;
			}
		}
	}
	
	/**
	 * function for debuging
	 */
	private function sterring() {
		var _a:Bool = FlxG.keys.anyPressed(["A"]);
		var _s:Bool = FlxG.keys.anyPressed(["S"]);
		
		if(isSter) {
			if (_s) {
				switch(currentState) {
					case GREEN: currentState = RED;
					case RED: currentState = RED_ORANGE;
					case RED_ORANGE: currentState = GREEN;
					//dummy match
					case ORANGE: currentState = ORANGE;
				}
			}
			if (_a) {
				switch(currentState) {
					case GREEN: currentState = ORANGE;
					case ORANGE: currentState = RED;
					case RED: currentState = GREEN;
					//dummy match
					case RED_ORANGE: currentState = RED_ORANGE;
				}
			}
		}
		
		if ((_s || _a) && isSter) {
			isSter = false;
		}
		
		if (!isSter) {
			ster--;
			if (ster <= 0) {
				ster = sterVal;
				isSter = true;
			}
		}
	}
	
}
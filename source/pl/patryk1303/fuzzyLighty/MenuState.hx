package pl.patryk1303.fuzzyLighty;

import pl.patryk1303.fuzzyLighty.lights.Lights;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import pl.patryk1303.fuzzyLighty.road.Road;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {
	
	public var lights:Array<Lights> = new Array<Lights>();
	public var road:Road;
	public var txt:FlxText;
	
	override public function create():Void {
		txt = new FlxText();
		road  = new Road(150, 150);
		lights.push(new Lights(road.x + 190 - 150, road.y + 108 - 150));
		lights.push(new Lights(road.x + 108 - 150, road.y + 108 - 150, 90, ORANGE));
		lights.push(new Lights(road.x + 92 - 150, road.y + 210 - 150, 180, RED_ORANGE));
		for (light in lights) {
			
			for (i in 0...light.lightTimes.length) {
				light.lightTimes[i] += Std.random(300);
			}
			light.scale.set(0.1, 0.1);
			add(light);
		}
		add(txt);
		add(road);
		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		//txt.text = "State: " + lights[0].currentState + "\nster: " + lights[0].ster;
		
		super.update();
		/*for (light in lights) {
			light.update();
		}*/
	}
}
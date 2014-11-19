package pl.patryk1303.fuzzyLighty;

import flixel.addons.ui.AnchorPoint;
import pl.patryk1303.fuzzyLighty.lights.Lights;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import pl.patryk1303.fuzzyLighty.road.Road;
import pl.patryk1303.fuzzyLighty.cars.Car;
import source.pl.patryk1303.fuzzyLighty.enums.LightStates;
import pl.patryk1303.fuzzyLighty.enums.CarDirection;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {
	
	public var lights:Array<Lights> = new Array<Lights>();
	public var cars = new Array<Car>();
	public var road:Road;
	public var txt:FlxText;
	
	override public function create():Void {
		txt = new FlxText();
		//add(cross);
		road  = new Road(0,0);
		road.updateHitbox();
		var i = 0;
		for (point in road.lightPoints) {
			var start = LightStates.GREEN;
			if (i % 2 != 0) start = LightStates.RED; 
			lights.push(new Lights(road.x + point[0], road.y + point[1], point[2], start));
			++i;
		}
		cars.push(new Car(road.x + road.originPoints[0][0], road.y + road.originPoints[0][1], road.originPoints[0][2], 1));
		cars.push(new Car(road.x + road.originPoints[1][0], road.y + road.originPoints[1][1], road.originPoints[1][2]));
		cars.push(new Car(road.x + road.originPoints[2][0], road.y + road.originPoints[2][1], road.originPoints[2][2]));
		cars.push(new Car(road.x + road.originPoints[3][0], road.y + road.originPoints[3][1], road.originPoints[3][2], 1));
		
		add(road);
		for (light in lights) {
			
			/*for (i in 0...light.lightTimes.length) {
				light.lightTimes[i] += Std.random(300);
			}*/
			light.scale.set(0.1, 0.1);
			light.updateHitbox();
			add(light);
		}
		for (car in cars) {
			car.scale.set(0.3, 0.3);
			car.updateHitbox();
			add(car);
		}
		
		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		if (lights[0].currentState == RED)
			cars[0].stop();
		if (lights[0].currentState == ORANGE)
			cars[0].orange_stopping();
		else if(lights[0].currentState == GREEN)
			cars[0].start();
		else if(lights[0].currentState == RED_ORANGE)
			cars[0].orange_starting();
		
		for (car in cars) {
			if (!(car.inWorldBounds()))
				car.kill();
		}
		super.update();
	}
}
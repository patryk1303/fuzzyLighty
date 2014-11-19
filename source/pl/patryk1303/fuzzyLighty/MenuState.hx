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

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {
	
	public var lights:Array<Lights> = new Array<Lights>();
	public var cars = new Array<Car>();
	public var road:Road;
	public var cross:Crossing = new Crossing();
	public var txt:FlxText;
	public var originPoints = new Array<Array<Float>>();
	
	override public function create():Void {
		txt = new FlxText();
		//add(cross);
		road  = new Road(20,20);
		road.updateHitbox();
		originPoints.push([road.x + 158, road.y + 300]);
		lights.push(new Lights(road.x + 195, road.y + 200));
		lights.push(new Lights(road.x + 70, road.y + 200, 90, RED));
		lights.push(new Lights(road.x + 200, road.y + 70, 270, RED));
		lights.push(new Lights(road.x + 92, road.y + 70, 180));
		var tmpX = originPoints[0][0];
		var tmpY = originPoints[0][1];
		
		cars.push(new Car(tmpX, tmpY));
		cars.push(new Car(road.x + 400, road.y + 100, LEFT, 1));
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
		//add(txt);
		
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
		else if(lights[0].currentState == GREEN)
			cars[0].start();
		
		for (car in cars) {
			if (!(car.inWorldBounds()))
				car.kill();
		}
		super.update();
	}
}
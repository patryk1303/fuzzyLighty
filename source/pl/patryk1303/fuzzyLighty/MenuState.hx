package pl.patryk1303.fuzzyLighty;

import flixel.addons.ui.AnchorPoint;
import flixel.group.FlxTypedGroup;
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
import pl.patryk1303.fuzzyLighty.road.StopArea;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {
	
	public var lights = new FlxTypedGroup<Lights>();
	public var cars = new FlxTypedGroup<Car>();
	public var stopAreas = new FlxTypedGroup<StopArea>();
	public var road:Road;
	public var txt:FlxText;
	
	override public function create():Void {
		FlxG.camera.bgColor = 0xFF00CE00;
		txt = new FlxText();
		road  = new Road(0,0);
		road.updateHitbox();
		var i = 0;
		for (point in road.lightPoints) {
			var start = LightStates.RED;
			if (i % 2 != 0) start = LightStates.GREEN; 
			lights.add(new Lights(road.x + point[0], road.y + point[1], point[2], start));
			++i;
		}
		cars.add(new Car(road.x + road.originPoints[0][0], road.y + road.originPoints[0][1], road.originPoints[0][2], 1));
		cars.add(new Car(road.x + road.originPoints[1][0], road.y + road.originPoints[1][1], road.originPoints[1][2]));
		cars.add(new Car(road.x + road.originPoints[2][0], road.y + road.originPoints[2][1], road.originPoints[2][2]));
		cars.add(new Car(road.x + road.originPoints[3][0], road.y + road.originPoints[3][1], road.originPoints[3][2], 1));
		
		i = 0;
		for (stopPoint in road.stopAreaPoints) {
			var hor:Bool = true;
			if (i % 2 != 0) hor = false;
			stopAreas.add(new StopArea(road.x + stopPoint[0], road.y + stopPoint[1], hor));
			++i;
		}
		
		add(road);
		for (light in lights) {
			light.scale.set(0.1, 0.1);
			light.updateHitbox();
			add(light);
		}
		for (car in cars) {
			car.scale.set(0.3, 0.3);
			car.updateHitbox();
			add(car);
		}
		for (stopPoint in stopAreas) {
			add(stopPoint);
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
		
		for (car in cars) {
			FlxG.overlap(car, stopAreas, carCheckStop);
		}
		
		for (car in cars) {
			if (!(car.inWorldBounds()))
				car.kill();
		}
		super.update();
	}
	
	private function carCheckStop(C:Car, S:StopArea) {
		if (C.alive && C.exists) {
			switch(C.direction) {
				case UP:	checkLightForCar(C, 0);
				case RIGHT:	checkLightForCar(C, 1);
				case DOWN:	checkLightForCar(C, 2);
				case LEFT:	checkLightForCar(C, 3);
			}
		}
	}
	
	private function checkLightForCar(C:Car, id:Int) {
		switch (getLightState(id)) {
			case GREEN: C.start();
			case ORANGE: C.orange_stopping();
			case RED: C.stop();
			case RED_ORANGE: C.orange_starting();
		}
	}
	
	function getLightState(id:Int):LightStates {
		var _l = lights.members;
		return _l[id].currentState;
	}
}
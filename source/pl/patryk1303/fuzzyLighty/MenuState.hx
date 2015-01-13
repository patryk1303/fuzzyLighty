package pl.patryk1303.fuzzyLighty;

import flixel.addons.ui.AnchorPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import pl.patryk1303.fuzzyLighty.road.Road;
import pl.patryk1303.fuzzyLighty.cars.Car;
import pl.patryk1303.fuzzyLighty.cars.CarDetector;
import source.pl.patryk1303.fuzzyLighty.enums.LightStates;
import pl.patryk1303.fuzzyLighty.enums.CarDirection;
import pl.patryk1303.fuzzyLighty.road.StopArea;
import pl.patryk1303.fuzzyLighty.cars.Emmiter;
import pl.patryk1303.fuzzyLighty.lights.Lights;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {
	
	public var lights = new FlxTypedGroup<Lights>();
	public var cars = new FlxTypedGroup<Car>();
	public var carsDetectors = new FlxTypedGroup<CarDetector>();
	public var stopAreas = new FlxTypedGroup<StopArea>();
	public var emmiters = new FlxTypedGroup<Emmiter>();
	public var road:Road;
	public var txt:FlxText;
	public var counts:FlxText;
	private var carTimer:Int;
	private var timer_min:Int = 7;
	private var timer_max:Int = 12;
	
	private var fuzzy:FuzzyDriver = new FuzzyDriver();
	private var fuzzy1:FuzzyDriver = new FuzzyDriver();
	
	private var carCount = [0,0,0,0]; //up,down,right,left
	//private var cars:FlxGroup;
	
	override public function create():Void {
		//cars = new FlxGroup();
		fuzzy1.fuzzy(13, 13);
		FlxG.camera.bgColor = 0xFF00CE00;
		carTimer = Utils.getRandom(timer_min, timer_max);
		txt = new FlxText();
		counts = new FlxText(0, 42);
		road  = new Road(0,0);
		road.updateHitbox();
		var i = 0;
		for (point in road.lightPoints) {
			var start = LightStates.RED;
			if (i % 2 != 0) start = LightStates.GREEN; 
			lights.add(new Lights(road.x + point[0], road.y + point[1], point[2], start));
			++i;
		}
		/*cars.add(new Car(road.x + road.originPoints[0][0], road.y + road.originPoints[0][1], road.originPoints[0][2], 1));
		cars.add(new Car(road.x + road.originPoints[1][0], road.y + road.originPoints[1][1], road.originPoints[1][2]));
		cars.add(new Car(road.x + road.originPoints[2][0], road.y + road.originPoints[2][1], road.originPoints[2][2]));
		cars.add(new Car(road.x + road.originPoints[3][0], road.y + road.originPoints[3][1], road.originPoints[3][2], 1));
		*/
		/*emmiters.add(new Emmiter(road.x + road.originPoints[0][0] + 4, road.y + road.originPoints[0][1] - 15, road.originPoints[0][2]));
		emmiters.add(new Emmiter(road.x + road.originPoints[1][0] + 7, road.y + road.originPoints[1][1] + 8, road.originPoints[1][2]));
		emmiters.add(new Emmiter(road.x + road.originPoints[2][0] + 4, road.y + road.originPoints[2][1] + 8, road.originPoints[2][2]));
		emmiters.add(new Emmiter(road.x + road.originPoints[3][0] - 12, road.y + road.originPoints[3][1] + 12, road.originPoints[3][2]));*/
		
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
			//car.scale.set(0.3, 0.3);
			//car.updateHitbox();
			add(car);
		}
		for (car in carsDetectors) {
			add(car);
		}
		for (stopPoint in stopAreas) {
			add(stopPoint);
		}
		add(emmiters);
		#if debug
		add(txt);
		add(counts);
		#end
		super.create();
	}
	
	override public function destroy():Void {
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		carTimer--;
		
		txt.text = "timer = " + carTimer;
		counts.text =  "main: " + (carCount[2] + carCount[3]) + "\nsecondary:" + (carCount[0] + carCount[1]);
		counts.text += "\nmainL green: " + lights.members[0].lightTimes[3] + "\nmainL red: " + lights.members[0].lightTimes[1];
		counts.text += "\nsecL green: " + lights.members[1].lightTimes[3] + "\nsecL red: " + lights.members[1].lightTimes[1];
		
		if (carTimer <= 0) {
			carTimer = Utils.getRandom(timer_min, timer_max);
			var tmpDir = Utils.getRandom(0, 3);
			switch (tmpDir) {
				case 0: emmitCar(UP);
				case 1: emmitCar(DOWN);
				case 2: emmitCar(RIGHT);
				case 3: emmitCar(LEFT);
			}
		}
		
		for (car in cars) {
			//FlxG.overlap(car, stopAreas, carCheckStop);
			car.touchedStoper = true;
			FlxG.overlap(car, stopAreas, carCheckStop);
			FlxG.overlap(cars, car, carCarCheck);
			//FlxG.collide(car, stopAreas, carCheckStop)
			if (!(car.inWorldBounds())) {
				//car.destroy();
				updateCarCount(car);
			}
		}
		
		var times = fuzzy.fuzzy(carCount[2] + carCount[3], carCount[0] + carCount[1]);
		
		for (l in lights) {
			if (!(getLightState(0) == GREEN && getLightState(1) == GREEN)) {
				l.setGreenLight(Std.int(times[0])*20);
				l.setRedLight(Std.int(times[1]) * 20);
			}
		}
		syncLights();
		super.update();
	}
	
	function syncLights() {
		if (getLightState(0) == GREEN && getLightState(1) == GREEN) {
			lights.members[0].setGreenLight(0);
			lights.members[2].setGreenLight(0);
		}
	}
	
	function updateCarCount(car:Car) {
		if(car.alive && car.exists) {
			switch(car.direction) {
				case UP:	carCount[0]--;
				case DOWN:	carCount[1]--;
				case RIGHT:	carCount[2]--;
				case LEFT:	carCount[3]--;
			}
			car.destroy();
	//		trace(carCount);
		}
	}
	
	function carCarCheck(c:Car, car:Car) {
		c.touchedStoper = true;
		car.touchedStoper = true;
		if (c.direction == car.direction) {
			c.stop();
		}
		else if (c.touchedStoper) {
			c.start();
		}
		else {
			c.start();
		}
		if (c.alive && c.exists && car.alive && car.exists) {
			switch(car.direction) {
				case UP:	checkLightForCar(car, 0);
				case RIGHT:	checkLightForCar(car, 1);
				case DOWN:	checkLightForCar(car, 2);
				case LEFT:	checkLightForCar(car, 3);
			}
		}
	}
	
	private function carCheckStop(C:Car, S:StopArea) {
		//C.touchedStoper = true;
		if (C.alive && C.exists && C.touchedStoper) {
			switch(C.direction) {
				case UP:	checkLightForCar(C, 0);
				case RIGHT:	checkLightForCar(C, 1);
				case DOWN:	checkLightForCar(C, 2);
				case LEFT:	checkLightForCar(C, 3);
			}
		}
		C.touchedStoper = false;
	}
	
	private function checkLightForCar(C:Car, id:Int) {
		switch (getLightState(id)) {
			case GREEN: C.start();
			case ORANGE: C.stop();
			case RED: C.stop();
			case RED_ORANGE: C.stop();
		}
	}
	
	function getLightState(id:Int):LightStates {
		var _l = lights.members;
		return _l[id].currentState;
	}
	
	function emmitCar(_dir:CarDirection) {
		switch(_dir) {
			case UP:	cars.add(new Car(road.x + road.originPoints[0][0], road.y + road.originPoints[0][1], road.originPoints[0][2], 1));
						carsDetectors.add(new CarDetector(road.x + road.originPoints[0][0], road.y + road.originPoints[0][1] + 15, false));
						carCount[0]++;
			case DOWN:	cars.add(new Car(road.x + road.originPoints[1][0], road.y + road.originPoints[1][1], road.originPoints[1][2]));
						carsDetectors.add(new CarDetector(road.x + road.originPoints[1][0], road.y + road.originPoints[1][1] - 15, false));
						carCount[1]++;
			case RIGHT:	cars.add(new Car(road.x + road.originPoints[2][0], road.y + road.originPoints[2][1], road.originPoints[2][2]));
						carsDetectors.add(new CarDetector(road.x + road.originPoints[2][0], road.y + road.originPoints[2][1], true));
						carCount[2]++;
			case LEFT:	cars.add(new Car(road.x + road.originPoints[3][0], road.y + road.originPoints[3][1], road.originPoints[3][2], 1));
						carsDetectors.add(new CarDetector(road.x + road.originPoints[3][0], road.y + road.originPoints[3][1] + 15, true));
						carCount[3]++;
		}
		#if debug
		//trace(carCount);
		#end
		add(cars);
		//trace("EMMIT: " + _dir + " Cars: " + cars.length);
	}
}
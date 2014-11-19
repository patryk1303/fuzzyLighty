package pl.patryk1303.fuzzyLighty;
import flixel.group.FlxSpriteGroup;
import pl.patryk1303.fuzzyLighty.lights.Lights;
import pl.patryk1303.fuzzyLighty.road.Road;
import flixel.FlxSprite;
using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author ...
 */
class Crossing extends FlxSpriteGroup
{
	public var light1:Lights = new Lights(0,16);
	public var light2:Lights = new Lights(16,16);
	public var light3:Lights = new Lights(32,16);
	public var light4:Lights = new Lights(48,16);
	public var road:Road = new Road(16,16);
	
	public function new() 
	{
		super();
		add(road);
		add(light1);
		add(light2);
		add(light3);
		add(light4);
	}
	
}
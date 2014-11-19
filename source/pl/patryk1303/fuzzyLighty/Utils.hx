package pl.patryk1303.fuzzyLighty;

/**
 * ...
 * @author Patryk Wychowaniec
 */
class Utils
{

	public static function getRandom(min:Int, max:Int) {
		return Std.random((max - min) + 1) + min;
	}
	
}
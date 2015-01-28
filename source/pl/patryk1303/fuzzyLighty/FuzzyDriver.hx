package pl.patryk1303.fuzzyLighty;

/**
 * ...
 * @author 
 */
class FuzzyDriver
{
	private var zbiorSamUlGlowna:Array<Dynamic> = new Array<Dynamic>();
	private var zbiorSamUlPob:Array<Dynamic> = new Array<Dynamic>();
	private var zbiorCzas:Array<Dynamic> = new Array<Dynamic>();
	
	public function new() 
	{
		zbiorSamUlGlowna = initZbior(4, zbiorSamUlGlowna);
		zbiorSamUlPob = initZbior(4, zbiorSamUlPob);
		zbiorCzas = initZbior(4, zbiorCzas);
		
		//zbior sam ul glo
		for (i in 0...14) {
			var tM:Float = 0;
			var tS:Float = 0;
			var tD:Float = 0;
			if (i >= 0 && i <= 3)
				tM = 1;
			else if (i >= 4 && i <= 6)
				tM = (6 - i) / 3;
				
			if (i >= 4 && i <= 6)
				tS = (i - 4) / 2;
			else if (i >= 6 && i <= 7)
				tS = 1;
			else if (i >= 7 && i <= 9)
				tS = (9 - i) / 2;
				
			if (i >= 8 && i <= 10)
				tD = (i - 8) / 2;
			else if (i >= 10)
				tD = 1;
			
			zbiorSamUlGlowna[0].push(i);
			zbiorSamUlGlowna[1].push(tM);
			zbiorSamUlGlowna[2].push(tS);
			zbiorSamUlGlowna[3].push(tD);
		}
		/*trace("AA:"+zbiorSamUlGlowna[0]);
		trace("AA:"+zbiorSamUlGlowna[1]);
		trace("AA:"+zbiorSamUlGlowna[2]);
		trace("AA:"+zbiorSamUlGlowna[3]);*/
		
		//zbior sam ul pob
		for (i in 0...14) {
			var tM:Float = 0;
			var tS:Float = 0;
			var tD:Float = 0;
			if (i >= 0 && i <= 1)
				tM = 1;
			else if (i >= 1 && i <= 3)
				tM = (3 - i) / 2;
				
			if (i >= 2 && i <= 4)
				tS = (i - 2) / 2;
			else if (i >= 4 && i <= 6)
				tS = 1;
			else if (i >= 6 && i <= 8)
				tS = (8 - i) / 2;
				
			if (i >= 6 && i <= 9)
				tD = (i - 6) / 3;
			else if (i >= 9)
				tD = 1;
			
			zbiorSamUlPob[0].push(i);
			zbiorSamUlPob[1].push(tM);
			zbiorSamUlPob[2].push(tS);
			zbiorSamUlPob[3].push(tD);
		}
		/*trace("BB:"+zbiorSamUlPob[0]);
		trace("BB:"+zbiorSamUlPob[1]);
		trace("BB:"+zbiorSamUlPob[2]);
		trace("BB:"+zbiorSamUlPob[3]);*/
		
		//zbior czas
		for (i in 0...31) {
			var tM:Float = 0;
			var tS:Float = 0;
			var tD:Float = 0;
			if (i >= 0 && i <= 8)
				tM = 1;
			else if (i >= 8 && i <= 12)
				tM = (12 - i) / 4;
				
			if (i >= 8 && i <= 14)
				tS = (i - 8) / 6;
			else if (i >= 14 && i <= 22)
				tS = 1;
			else if (i >= 22 && i <= 26)
				tS = (26 - i) / 4;
				
			if (i >= 22 && i <= 26)
				tD = (i - 22) / 4;
			else if (i >= 26)
				tD = 1;
			
			zbiorCzas[0].push(i);
			zbiorCzas[1].push(tM);
			zbiorCzas[2].push(tS);
			zbiorCzas[3].push(tD);
		}
		/*trace("CC:"+zbiorCzas[0]);
		trace("CC:"+zbiorCzas[1]);
		trace("CC:"+zbiorCzas[2]);
		trace("CC:"+zbiorCzas[3]);*/
	}
	
	public function fuzzy(carsPrimary:Int, carsSecondary:Int) {
		if (carsPrimary > 13)
			carsPrimary = 13;
		else if (carsPrimary < 0)
			carsPrimary = 0;
		if (carsSecondary > 13)
			carsSecondary = 13;
		else if (carsSecondary < 0)
			carsSecondary = 0;
		var uCPm = zbiorSamUlGlowna[1][carsPrimary];
		var uCPs = zbiorSamUlGlowna[2][carsPrimary];
		var uCPd = zbiorSamUlGlowna[3][carsPrimary];
		var uCSm = zbiorSamUlPob[1][carsSecondary];
		var uCSs = zbiorSamUlPob[2][carsSecondary];
		var uCSd = zbiorSamUlPob[3][carsSecondary];
		var ULi:Array<Dynamic> = new Array<Dynamic>();
		var t:Dynamic;
		var uK, uS, uD:Dynamic;
		var uKred, uSred, uDred:Dynamic;
		
		//baza wnioskow
		ULi.push(fuzzyMin(uCPm,uCSm));
		ULi.push(fuzzyMin(uCPm,uCSs));
		ULi.push(fuzzyMin(uCPm,uCSd));
		ULi.push(fuzzyMin(uCPs,uCSm));
		ULi.push(fuzzyMin(uCPs,uCSs));
		ULi.push(fuzzyMin(uCPs,uCSd));
		ULi.push(fuzzyMin(uCPd,uCSm));
		ULi.push(fuzzyMin(uCPd,uCSs));
		ULi.push(fuzzyMin(uCPd,uCSd));
		
		//swiatla zielone
		//uK = ULi[0];
		//uS = Math.max(Math.max(Math.max(Math.max(ULi[1], ULi[2]), ULi[3]), ULi[4]), ULi[5]);
		//uD = Math.max(Math.max(ULi[6], ULi[7]), ULi[8]);
		uK = ULi[0];
		uS = Math.max(Math.max(Math.max(Math.max(ULi[1], ULi[2]), ULi[3]), ULi[4]), ULi[6]);
		uD = Math.max(Math.max(ULi[5], ULi[7]), ULi[8]);
		//swiatla czerwone
		//uKred = Math.max(ULi[2], ULi[6]);
		//uSred = Math.max(Math.max(Math.max(Math.max(Math.max(ULi[0], ULi[3]), ULi[4]), ULi[5]), ULi[7]),ULi[8]);
		//uDred = ULi[1];
		uKred = ULi[0];
		uSred = Math.max(Math.max(Math.max(Math.max(ULi[1], ULi[2]), ULi[3]), ULi[4]), ULi[6]);
		uDred = Math.max(Math.max(ULi[5], ULi[7]), ULi[8]);
		
		var fGreen = [ uK, uS, uD ];
		var fRed = [ uKred, uSred, uDred ];
		
		return defuzzy(fGreen, fRed, zbiorCzas);
	}//1600??
	
	private function defuzzy(fuzzedGreen:Dynamic,fuzzedRed:Dynamic,zCzas:Dynamic ) {
		var uLiGreen:Array<Dynamic> = new Array<Dynamic>();
		var uLiRed:Array<Dynamic> = new Array<Dynamic>();
		var uLiGreen_A:Array<Dynamic> = new Array<Dynamic>();
		var uLiRed_A:Array<Dynamic> = new Array<Dynamic>();
		var uLiGreen_B:Array<Dynamic> = new Array<Dynamic>();
		var uLiRed_B:Array<Dynamic> = new Array<Dynamic>();
		var zCzas_A:Array<Dynamic> = new Array<Dynamic>();
		var up:Dynamic = 0.0;
		var down:Dynamic = 0.0;
		var returnValues:Array<Dynamic> = new Array<Dynamic>();
		var uTemp:Array<Dynamic> = new Array<Dynamic>();
		
		uLiGreen = initZbior(3, uLiGreen);
		uLiRed = initZbior(3, uLiRed);
		uLiGreen_B = initZbior(3, uLiGreen_B);
		uLiRed_B = initZbior(3, uLiRed_B);
		
		for (i in 0...31) {
			uLiGreen[0].push(Math.min(fuzzedGreen[0], zCzas[1][i])); //KROTKO
			uLiGreen[1].push(Math.min(fuzzedGreen[1], zCzas[2][i])); //SREDNIO
			uLiGreen[2].push(Math.min(fuzzedGreen[2], zCzas[3][i])); //DLUGO
			
			uLiRed[0].push(Math.min(fuzzedRed[0], zCzas[1][i])); //KROTKO
			uLiRed[1].push(Math.min(fuzzedRed[1], zCzas[2][i])); //SREDNIO
			uLiRed[2].push(Math.min(fuzzedRed[2], zCzas[3][i])); //DLUGO
		}
		/*//TODO lustrzane odbicie zbioru - K,D na krancach
		uLiGreen_B[0] = mirrorU(uLiGreen[0]);
		uLiGreen_B[1] = mirrorU(uLiGreen[1]);
		uLiGreen_B[2] = mirrorU(uLiGreen[2], false);
		uLiRed_B[0] = mirrorU(uLiRed[0]);
		uLiRed_B[1] = mirrorU(uLiRed[1]);
		uLiRed_B[2] = mirrorU(uLiRed[2], false);
		zCzas_A[0] = mirrorU(zCzas[0]);
		//trace(zCzas_A[0]);
		
		for (i in 0...62) {
			uLiGreen_A.push(Math.max(Math.max(uLiGreen_B[0][i], uLiGreen_B[1][i]), uLiGreen_B[2][i]));
			uLiRed_A.push(Math.max(Math.max(uLiRed_B[0][i], uLiRed_B[1][i]), uLiRed_B[2][i]));
		}
		//trace(uLiGreen_A);
		
		//GREEN
		for (i in 0...62) {
			//up += uLiGreen_A[i] * zCzas_A[0][i];
			up += uLiGreen_A[i] * i;
			down += uLiGreen_A[i];
		}
		returnValues.push(up / down);
		
		//RED
		for (i in 0...62) {
			//up += uLiRed_A[i] * zCzas_A[0][i];
			up += uLiRed_A[i] * i;
			down += uLiRed_A[i];
		}
		returnValues.push(up / down);*/
		
		//WITHOUT MIRRORING
		
		for (i in 0...31) {
			uLiGreen_A.push(Math.max(Math.max(uLiGreen[0][i], uLiGreen[1][i]), uLiGreen[2][i]));
			uLiRed_A.push(Math.max(Math.max(uLiRed[0][i], uLiRed[1][i]), uLiRed[2][i]));
		}
		
		//GREEN
		for (i in 0...31) {
			up += uLiGreen_A[i] * zCzas[0][i];
			down += uLiGreen_A[i];
		}
		returnValues.push(up / down);
		
		//RED
		for (i in 0...31) {
			up += uLiRed_A[i] * zCzas[0][i];
			down += uLiRed_A[i];
		}
		returnValues.push(up / down);
		
		//trace(returnValues);
		
		return returnValues;
	}
	
	function mirrorU(array:Array<Dynamic>,?isStartL:Bool=true) {
		var uTemp:Array<Dynamic> = new Array<Dynamic>();
		var ret:Array<Dynamic> = new Array<Dynamic>();
		uTemp = array;
		if (isStartL)	uTemp.reverse();
		for (i in 0...31) {
			ret.push(uTemp[i]);
		}
		uTemp.reverse();
		for (i in 0...31) {
			ret.push(uTemp[i]);
		}
		if (!isStartL)	uTemp.reverse();
		//trace(ret);
		return ret;
	}
	
	//MIN FOR FUZZYFICATION
	private function fuzzyMin(v1:Dynamic, v2:Dynamic) {
		var t:Dynamic = 0;
		if (v1 > 0 && v2 > 0) {
			//t = v1 * v2;
			t = Math.min(v1, v2);
 		}
		return t;
	}
	
	//MAX
	private function fuzzyMax(v1:Dynamic, v2:Dynamic) {
		//var t = (v1 + v2) - (v1 * v2);
		var t = Math.max(v1, v2);
		return t;
	}
	
	private function initZbior(xCount:Int,zbior:Dynamic) {
		for (i in 0...xCount) {
			zbior.push(new Array<Dynamic>());
		}
		return zbior;
	}
	
}
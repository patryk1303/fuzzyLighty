package pl.patryk1303.fuzzyLighty;

/**
 * ...
 * @author Patryk Wychowaniec
 */
class FuzzyDriver
{

	/*private var zbiorX1:Array<Array<Float>> = new Array<Array<Float>>();
	private var zbiorX2:Array<Array<Float>> = new Array<Array<Float>>();
	private var zbiorY1:Array<Array<Float>> = new Array<Array<Float>>();
	private var zbiorY2:Array<Array<Float>> = new Array<Array<Float>>();*/
	private var zbiorSamUlGlowna:Array<Dynamic> = new Array<Dynamic>();
	private var zbiorSamUlPob:Array<Dynamic> = new Array<Dynamic>();
	private var zbiorCzas:Array<Dynamic> = new Array<Dynamic>();
	
	
	
	private var zbiorX1:Array<Dynamic> = new Array<Dynamic>();
	private var zbiorX2:Array<Dynamic> = new Array<Dynamic>();
	private var zbiorY1:Array<Dynamic> = new Array<Dynamic>();
	private var zbiorY2:Array<Dynamic> = new Array<Dynamic>();
	
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
		trace("AA:"+zbiorSamUlGlowna[0]);
		trace("AA:"+zbiorSamUlGlowna[1]);
		trace("AA:"+zbiorSamUlGlowna[2]);
		trace("AA:"+zbiorSamUlGlowna[3]);
		
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
		trace("BB:"+zbiorSamUlPob[0]);
		trace("BB:"+zbiorSamUlPob[1]);
		trace("BB:"+zbiorSamUlPob[2]);
		trace("BB:"+zbiorSamUlPob[3]);
		
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
		trace("CC:"+zbiorCzas[0]);
		trace("CC:"+zbiorCzas[1]);
		trace("CC:"+zbiorCzas[2]);
		trace("CC:"+zbiorCzas[3]);
	}
	
	/**
	 * Funkcja do wyliczania testowych danych
	 * dla testowego sterownika
	 */
	public function testFuzzy() {
		//inicjacja zbiorów
		zbiorX1 = initZbior(5, zbiorX1);
		zbiorX2 = initZbior(4, zbiorX2);
		zbiorY1 = initZbior(2, zbiorY1);
		zbiorY2 = initZbior(2, zbiorY2);
		
		//zbiór X1
		for (i in 1...71) {
			var x:Float = (i - 1) * 0.5;
			var zimno:Float;
			var letnio:Float;
			var cieplo:Float;
			var goraco:Float;
			
			//zbiory lingwistyczne
			//zbior zimno
			if ((x >= 0) && (x < 5))
				zimno = 0;
			else if ((x >= 5) && (x <= 15))
				zimno = (15 - x) * 0.1;
			else
				zimno = 0;
			//zbior letnio
			if ((x >= 5) && (x < 15))
				letnio = (x - 5) * 0.1;
			else if ((x >= 15) && (x <= 25))
				letnio = (25 - x) * 0.1;
			else
				letnio = 0;
			//zbior cieplo
			if ((x >= 15) && (x < 25))
				cieplo = (x - 15) * 0.1;
			else if ((x >= 25) && (x <= 35))
				cieplo = (35 - x) * 0.1;
			else
				cieplo = 0;
			//zbior goraco
			if ((x >= 25) && (x <= 35))
				goraco = (x - 25) * 0.1;
			else
				goraco = 0;
				
			zbiorX1[0].push(x);
			zbiorX1[1].push(zimno);
			zbiorX1[2].push(letnio);
			zbiorX1[3].push(cieplo);
			zbiorX1[4].push(goraco);
			
			//trace("x=" + x + "\t zimno=" + zimno + "\t letnio=" + letnio + "\t cieplo=" + cieplo + "\t goraco=" + goraco);
		}
		//zbiór X2
		for (i in 1...101) {
			var x:Float = (i - 1);
			var mala:Float;
			var srednia:Float;
			var duza:Float;
			
			//zbiory lingwistyczne
			//zbior mala
			if ((x >= 0) && (x < 25))
				mala = 1;
			else if ((x >= 25) && (x <= 50))
				mala = (50 - x) * 0.04; // /25
			else
				mala = 0;
			//zbior srednia
			if ((x >= 25) && (x < 50))
				srednia = (x - 25) * 0.04;
			else if ((x >= 50) && (x <= 100))
				srednia = (100 - x) * 0.02; // /50
			else
				srednia = 0;
			//zbior duza
			if ((x >= 50) && (x <= 100))
				duza = (x - 50) * 0.02;
			else
				duza = 0;
				
			zbiorX2[0].push(x);
			zbiorX2[1].push(mala);
			zbiorX2[2].push(srednia);
			zbiorX2[3].push(duza);
			
			//trace("x=" + x + "\t zimno=" + zimno + "\t letnio=" + letnio + "\t cieplo=" + cieplo + "\t goraco=" + goraco);
		}
		
		// charakterystyka przejściowa
		// y = f(x1), dla x2 = 60
		
		var y:Float;
		var x1:Int;
		var x2:Int = 60;
		
		for (i in 0...35) {
			x1 = i * 2;// + 1;
			
			var USa:Float;
			var UMa:Float;
			var UZa:Float;
			var UDa:Float;
			var UMb:Float;
			var UZb:Float;
			var UDb:Float;
			var USb:Float;
			var UMc:Float;
			var UMX:Float;
			var UDc:Float;
			var USc:Float;
			
			//rozmycie X1
			var UZ:Float = zbiorX1[1][x1];
			var UL:Float = zbiorX1[2][x1];
			var UC:Float = zbiorX1[3][x1];
			var UG:Float = zbiorX1[4][x1];
			
			//rozmycie X2
			var UM:Float = zbiorX2[1][x1];
			var US:Float = zbiorX2[2][x1];
			var UD:Float = zbiorX2[3][x1];
			
			//R Reguła Temperatura \ Wilgotność
			
			//R zimno \ mała
			if ((UZ > 0) && (UM > 0))
				USa = Math.min(UZ, UM);
			else USa = 0;
			//R zimno \ średnia
			if ((UZ > 0) && (US > 0))
				UMa = Math.min(UZ, US);
			else UMa = 0;
			//R zimno \ duża
			if ((UZ > 0) && (UD > 0))
				UZa = Math.min(UZ, UD);
			else UZa = 0;
			//R letnio \ mała
			if ((UL > 0) && (UM > 0))
				UDa = Math.min(UL, UM);
			else UDa = 0;
			//R letnio \ średnia
			if ((UL > 0) && (US > 0))
				UMb = Math.min(UL, US);
			else UMb = 0;
			//R letnio \ duża
			if ((UL > 0) && (UD > 0))
				UZb = Math.min(UL, UD);
			else UZb = 0;
			//R ciepło \ mała
			if ((UC > 0) && (UM > 0))
				UDb = Math.min(UC, UM);
			else UDb = 0;
			//R ciepło \ średnia
			if ((UC > 0) && (US > 0))
				USb = Math.min(UC, US);
			else USb = 0;
			//R ciepło \ duża
			if ((UC > 0) && (UD > 0))
				UMc = Math.min(UC, UD);
			else UMc = 0;
			//R gorąco \ mała
			if ((UG > 0) && (UM > 0))
				UMX = Math.min(UG, UM);
			else UMX = 0;
			//R gorąco \ średnia
			if ((UG > 0) && (US > 0))
				UDc = Math.min(UG, US);
			else UDc = 0;
			//R gorąco \ duża
			if ((UG > 0) && (UD > 0))
				USc = Math.min(UG, UD);
			else USc = 0;
			
			//agregacja
			UM = Math.max(Math.max(UMa, UMb), UMc);
			UZ = Math.max(UZa, UZb);
			US = Math.max(Math.max(USa, USb), USc);
			UD = Math.max(Math.max(UDa, UDb), UDc);
			
			//wartośc intensywności podlewania
			y = (UZ * 0 + UM * 25 + US * 50 + UD * 75 + UMX * 100) / (UZ + UM + US + UD + UMX);
			
			zbiorY1[0].push(i);
			zbiorY1[1].push(y);
		}
		//trace(zbiorY1);
		
	}
	
	private function initZbior(xCount:Int,zbior:Dynamic) {
		for (i in 0...xCount) {
			zbior.push(new Array<Dynamic>());
		}
		//trace(zbior);
		return zbior;
	}
	
}
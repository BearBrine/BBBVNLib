package bvn {
	
	import flash.system.ApplicationDomain;
	
	public class BVNClass {
		
		public static const bvnPath:String = "net.play5d.game.bvn";
		
		public static const kyoPath:String = "net.play5d.kyo";

		public function BVNClass() {
			// constructor code
			throw new Error("BVNClass:What are you doing???");
			
		}
		
		public static function getClass(path:String):Class {
			return ApplicationDomain.currentDomain.getDefinition(path);
		}
		
		public static function getBVNClass(path:String):Class {
			return getClass(bvnPath + "." + path);
		}
		
		public static function getKyoClass(path:String):Class {
			return getClass(kyoPath + "." + path);
		}

	}
	
}

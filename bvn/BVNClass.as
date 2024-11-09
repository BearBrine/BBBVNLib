package bvn {
	
	import flash.system.ApplicationDomain;
	
	/**
	 * <p>BVN 类获取类，使用 ApplicationDomain 的 getDefinition 方法来获取 BVN 的内部类</p>
	 * <p>同时提供一些常用的类获取方法，可以直接使用 BVNClass.FighterMain 的形式来获取</p>
	 * @author BearBrine
	 */
	public class BVNClass {
		
		/**
		 * bvn 命名空间的路径
		 */
		public static const bvnPath:String = "net.play5d.game.bvn";
		
		/**
		 * bvn 命名空间的路径
		 */
		public static const kyoPath:String = "net.play5d.kyo";

		/**
		 * @private
		 */
		public function BVNClass() {
			// constructor code
			throw new Error("BVNClass:你干嘛~~~嗨嗨哎~哟~~");
		}
		
		/**
		 * <p>获取当前应用程序域中指定路径下的一个类</p>
		 * <p>等价于 ApplicationDomain.currentDomain.getDefinition(path)，但是只返回类对象</p>
		 * @param	path	类路径，格式为 "包名.类名"
		 * @return	返回一个类对象
		 */
		public static function getClass(path:String):Class {
			return ApplicationDomain.currentDomain.getDefinition(path);
		}
		
		/**
		 * <p>获取 bvn 命名空间中路径指定的类</p>
		 * <p>等价于 ApplicationDomain.currentDomain.getDefinition("net.play5d.game.bvn." + path)，但是只返回类对象</p>
		 * @param	path	类路径，格式为 "类名"
		 * @return	返回一个类对象
		 */
		public static function getBVNClass(path:String):Class {
			return getClass(bvnPath + "." + path);
		}
		
		/**
		 * <p>获取 kyo 命名空间中路径指定的类</p>
		 * <p>等价于 ApplicationDomain.currentDomain.getDefinition("net.play5d.kyo." + path)，但是只返回类对象</p>
		 * @param	path	类路径，格式为 "类名"
		 * @return	返回一个类对象
		 */
		public static function getKyoClass(path:String):Class {
			return getClass(kyoPath + "." + path);
		}

		/* -------------------- bvn class -------------------- */

		public static function get Debugger():Class {
			return getBVNClass("bvn.Debugger");
		}

		public static function get GameConfig():Class {
			return getBVNClass("bvn.GameConfig");
		}

		public static function get MainGame():Class {
			return getBVNClass("bvn.MainGame");
		}

		/* -------------------- ctrl class -------------------- */

		public static function get AssetManager():Class {
			return getBVNClass("ctrl.AssetManager");
		}

		public static function get EffectCtrl():Class {
			return getBVNClass("ctrl.EffectCtrl");
		}

		public static function get GameLoader():Class {
			return getBVNClass("ctrl.GameLoader");
		}

		public static function get GameLogic():Class {
			return getBVNClass("ctrl.GameLogic");
		}

		public static function get GameRender():Class {
			return getBVNClass("ctrl.GameRender");
		}

		public static function get SoundCtrl():Class {
			return getBVNClass("ctrl.SoundCtrl");
		}

		public static function get StateCtrl():Class {
			return getBVNClass("ctrl.StateCtrl");
		}

		/* -------------------- ctrl.game_ctrls class -------------------- */

		public static function get FighterEventCtrl():Class {
			return getBVNClass("ctrl.game_ctrls.FighterEventCtrl");
		}

		public static function get GameCtrl():Class {
			return getBVNClass("ctrl.game_ctrls.GameCtrl");
		}

		public static function get GameMainLogicCtrler():Class {
			return getBVNClass("ctrl.game_ctrls.GameMainLogicCtrler");
		}

		/* -------------------- data class -------------------- */

		public static function get AssisterModel():Class {
			return getBVNClass("data.AssisterModel");
		}

		public static function get EffectModel():Class {
			return getBVNClass("data.EffectModel");
		}

		public static function get EffectVO():Class {
			return getBVNClass("data.EffectVO");
		}

		public static function get FighterModel():Class {
			return getBVNClass("data.EffectModel");
		}

		public static function get FighterVO():Class {
			return getBVNClass("data.FighterVO");
		}

		public static function get GameData():Class {
			return getBVNClass("data.GameData");
		}

		public static function get GameMode():Class {
			return getBVNClass("data.GameMode");
		}

		public static function get MapModel():Class {
			return getBVNClass("data.MapModel");
		}

		public static function get MapVO():Class {
			return getBVNClass("data.MapVO");
		}

		public static function get MessionModel():Class {
			return getBVNClass("data.MessionModel");
		}

		public static function get TeamVO():Class {
			return getBVNClass("data.TeamVO");
		}

		/* -------------------- events class -------------------- */

		public static function get GameEvent():Class {
			return getBVNClass("events.GameEvent");
		}

		/* -------------------- fighter class -------------------- */
		
		public static function get Assister():Class {
			return getBVNClass("fighter.Assister");
		}

		public static function get Bullet():Class {
			return getBVNClass("fighter.Bullet");
		}

		public static function get FighterAction():Class {
			return getBVNClass("fighter.FighterAction");
		}

		public static function get FighterActionState():Class {
			return getBVNClass("fighter.FighterActionState");
		}

		public static function get FighterMC():Class {
			return getBVNClass("fighter.FighterMC");
		}
		
		public static function get FighterAttacker():Class {
			return getBVNClass("fighter.FighterAttacker");
		}

		public static function get FighterMain():Class {
			return getBVNClass("fighter.FighterMain");
		}
		
		/* -------------------- fighter.ctrler class -------------------- */

		public static function get AssisterCtrler():Class {
			return getBVNClass("fighter.ctrler.AssisterCtrler");
		}

		public static function get FighterAICtrl():Class {
			return getBVNClass("fighter.ctrler.FighterAICtrl");
		}

		public static function get FighterAttackerCtrler():Class {
			return getBVNClass("fighter.ctrler.FighterAttackerCtrler");
		}

		public static function get FighterBuffCtrler():Class {
			return getBVNClass("fighter.ctrler.FighterBuffCtrler");
		}

		public static function get FighterCtrler():Class {
			return getBVNClass("fighter.ctrler.FighterCtrler");
		}

		public static function get FighterEffectCtrl():Class {
			return getBVNClass("fighter.ctrler.FighterEffectCtrl");
		}

		public static function get FighterKeyCtrl():Class {
			return getBVNClass("fighter.ctrler.FighterKeyCtrl");
		}

		public static function get FighterMcCtrler():Class {
			return getBVNClass("fighter.ctrler.FighterMcCtrler");
		}

		public static function get FighterVoiceCtrler():Class {
			return getBVNClass("fighter.ctrler.FighterVoiceCtrler");
		}

		/* -------------------- fighter.events class -------------------- */

		public static function get FighterEvent():Class {
			return getBVNClass("fighter.events.FighterEvent");
		}

		public static function get FighterEventDispatcher():Class {
			return getBVNClass("fighter.events.FighterEventDispatcher");
		}

		/* -------------------- fighter.models class -------------------- */

		public static function get FighterHitModel():Class {
			return getBVNClass("fighter.models.FighterHitModel");
		}

		public static function get HitVO():Class {
			return getBVNClass("fighter.models.HitVO");
		}

		/* -------------------- input class -------------------- */

		public static function get GameInputer():Class {
			return getBVNClass("input.GameInputer");
		}

		public static function get GameKeyInput():Class {
			return getBVNClass("input.GameKeyInput");
		}

		/* -------------------- interfaces class -------------------- */

		public static function get BaseGameSprite():Class {
			return getBVNClass("interfaces.BaseGameSprite");
		}

		/* -------------------- map class -------------------- */

		public static function get FloorVO():Class {
			return getBVNClass("map.FloorVO");
		}

		public static function get MapMain():Class {
			return getBVNClass("map.MapMain");
		}

		/* -------------------- state class -------------------- */

		public static function get GameCamera():Class {
			return getBVNClass("state.GameCamera");
		}

		public static function get GameState():Class {
			return getBVNClass("state.GameState");
		}

		public static function get LoadingState():Class {
			return getBVNClass("state.LoadingState");
		}

		/* -------------------- ui class -------------------- */

		public static function get GameUI():Class {
			return getBVNClass("ui.GameUI");
		}

		/* -------------------- utils class -------------------- */

		public static function get GameLoger():Class {
			return getBVNClass("utils.GameLoger");
		}
	}
	
}

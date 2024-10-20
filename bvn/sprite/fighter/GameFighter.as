package bvn.sprite.fighter 
{
	import bvn.sprite.GameSprite;
	import bvn.BVNClass;
	
	/**
	 * 用于方便控制 FighterMain 类（主人物类）的控制器
	 * @author BearBrine
	 */
	public class GameFighter extends GameSprite 
	{
		
		public function GameFighter(target:*) 
		{
			super(target);
			if (target is BVNClass.getBVNClass("fighter.FighterMain") == false) 
			{
				throw new Error("目标对象类型不是FighterMain");
			}
		}
		
		public function get ctrler():* 
		{
			return _i.getCtrler();
		}
		
		public function get mcCtrler():* 
		{
			return _i.getCtrler().getMcCtrl();
		}
		
		public function get effectCtrler():* 
		{
			return _i.getCtrler.getEffectCtrl();
		}
		
		public function get buffCtrler():* 
		{
			return _i.getBuffCtrl();
		}
		
		public function get voiceCtrler():* 
		{
			return _i.getCtrler().getVoiceCtrl();
		}
		
		public function get hitModel():* 
		{
			return _i.getCtrler().hitModel;
		}
		
		public function get fighterAction():* 
		{
			return _i.getCtrler().getMcCtrl().getAction();
		}
		
		public function get fighterMc():* 
		{
			return _i.getCtrler().getMcCtrl().getFighterMc();
		}
		
		public function doAction(label:String, actionState:int = -1):void 
		{
			fighterAction.hurtAction = label;
			mcCtrler.beHit(null);
			if (actionState != -1) _i.actionState = actionState;
		}
		
	}

}
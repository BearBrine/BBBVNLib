package bvn.sprite.utils 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import net.play5d.game.bvn.ctrl.game_ctrls.GameCtrl;
	import bvn.BVNClass;
	
	/**
	 * ...
	 * @author BearBrine
	 */
	public class GameSpriteUtils 
	{
		
		public function GameSpriteUtils() 
		{
			throw new Error("GameSpriteUtils:给爷爪巴");
		}
		
		/**
		 * 获取游戏对象列表。该列表包含了所有添加到了场景中的游戏对象（一般是这样）。
		 * 另外游戏会按顺序更新该列表中的每个对象，所以我有时会考虑叫他更新列表……(^^;
		 */
		public static function get gameSprites():*
		{
			return GameCtrl.I.gameState.getGameSprites();
		}
		
		/**
		 * 获取目标游戏对象在更新列表中的索引，其实就是个indexOf……(^^;
		 * @param	target	目标游戏对象
		 * @return	目标游戏对象在更新列表中的索引
		 */
		public static function getRenderIndex(target:*):int 
		{
			return gameSprites.indexOf(target);
		}
		
		public static function getSelfByDisplay(display:DisplayObject):*
		{
			for (var index:int = 0; index < gameSprites.length; ++index) 
			{
				if (gameSprites[index].getDisplay() == display) 
				{
					return gameSprites[index];
				}
			}
			return null;
		}
		
		/**
		 * 获取目标人物对应的敌方阵营主要人物，该人物必须也为所属阵营的主要人物（gameRunData.p*FighterGroup.currentFighter）
		 * @param	fighter	目标人物，类型为 FighterMain
		 * @return	目标人物对应的敌方阵营主人物，类型为 FighterMain
		 */
		public static function getEnemyFighterOfFighter(fighter:*):* 
		{
			if(GameCtrl.I.gameRunData.p1FighterGroup.currentFighter == fighter) 
			{
				return GameCtrl.I.gameRunData.p2FighterGroup.currentFighter;
			}
			return GameCtrl.I.gameRunData.p1FighterGroup.currentFighter;
		}
		
		/**
		 * 将更新列表中索引为 index1 的对象移动到索引为 index2 的位置
		 * @param	index1	索引1
		 * @param	index2	索引2
		 */
		public static function moveRenderIndex(index1:int, index2:int):void 
		{
			if (gameSprites.length <= index1 || gameSprites.length <= index2 || index1 == index2) return;
			var target:* = gameSprites[index1];
			var i:int = index1;
			if (index1 < index2) {
				for (; i < index2; ++i) {
					gameSprites[i] = gameSprites[i + 1];
				}
			} else {
				for (; i > index2; --i) {
					gameSprites[i] = gameSprites[i - 1];
				}
			}
			gameSprites[index2] = target;
		}
		
		public static function setRenderIndexToTargetFront(sprite1:*, sprite2:*, close:Boolean = true):void 
		{
			var index1:int = getRenderIndex(sprite1);
			if (index1 == -1) return;
			var index2:int = getRenderIndex(sprite2);
			if (index2 == -1) return;
			if (close) {
				if (index2 - index1 == 1) return;
			} else {
				if (index1 < index2) return;
			}
			if (index1 > index2) moveRenderIndex(index1, index2);
			else moveRenderIndex(index1, index2 - 1);
		}
		
		public static function setRenderIndexToTargetBack(sprite1:*, sprite2:*, close:Boolean = true):void 
		{
			var index1:int = getRenderIndex(sprite1);
			if (index1 == -1) return;
			var index2:int = getRenderIndex(sprite2);
			if (index2 == -1) return;
			if (close) {
				if (index1 - index2 == 1) return;
			} else {
				if (index1 > index2) return;
			}
			if (index1 < index2) {
				moveRenderIndex(index1, index2);
			} else {
				moveRenderIndex(index1, index2 + 1);
			}
		}
		
		public static function setRenderIndexToFront(sprite:*):void 
		{
			var index:int = getRenderIndex(sprite);
			if (index == -1) return;
			moveRenderIndex(index, 0);
		}
		
		public static function setRenderIndexToBack(sprite:*):void 
		{
			var index:int = getRenderIndex(sprite);
			if (index == -1) return;
			moveRenderIndex(index, gameSprites.length - 1);
		}
		
	}

}
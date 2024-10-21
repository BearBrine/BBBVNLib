package bvn.sprite 
{
	import net.play5d.game.bvn.ctrl.game_ctrls.GameCtrl;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import bvn.sprite.utils.GameSpriteUtils;
	import bvn.BVNClass;
	import flash.geom.Rectangle;
	
	/**
	 * 用于方便控制 IGameSprite 类的控制器
	 * @author BearBrine
	 */
	public class GameSpriteBase extends EventDispatcher 
	{
		
		/**
		 * @private
		 */
		protected var _i:*;//IGameSprite
		
		/**
		 * 创建一个包装游戏对象 target 的控制器
		 * @param	target	目标游戏对象，类型必须为 IGameSprite 的实现器
		 */
		public function GameSpriteBase(target:*) 
		{
			super();
			if (target is BVNClass.getBVNClass("interfaces.IGameSprite") == false) 
			{
				throw new Error("目标对象类型不是IGameSprite");
			}
			_i = target;
		}
		
		/**
		 * 获取该控制器所包装的原游戏对象本体
		 */
		public function get i():*
		{
			return _i;
		}

		/**
		 * 获取该控制器所包装的原游戏对象本体的更新列表（游戏对象列表）中的索引。正常情况下应该都不会用到……
		 */
		public function getRenderIndex():int
		{
			return GameSpriteUtils.getRenderIndex(_i);
		}

		/**
		 * 判断自己在更新列表（游戏对象列表）中的索引是否为列表的第一个。正常情况下应该都不会用到……
		 */
		public function isFirstIndex():Boolean
		{
			return getRenderIndex() == 0;
		}
		
		/**
		 * 判断自己在更新列表（游戏对象列表）中的索引是否为列表的最后一个。正常情况下应该都不会用到……
		 */
		public function isLastIndex():Boolean
		{
			return getRenderIndex() == GameSpriteUtils.gameSprites.length - 1;
		}
		
		/**
		 * 设置自己在更新列表（游戏对象列表）中的索引到列表的最前面，或是某个游戏对象的前面。正常情况下应该都不会用到……
		 * @param	target	目标游戏对象，不设置则移动到列表的最前面
		 * @param	close	是否紧挨着目标对象，也就是设置在该目标对象的前一位。仅在设置了 target 参数时有用
		 */
		public function setRenderIndexToFront(target:* = null, close:Boolean = true):void 
		{
			if (!target) {
				GameSpriteUtils.setRenderIndexToFront(_i);
			} else {
				GameSpriteUtils.setRenderIndexToTargetFront(_i, target, close);
			}
		}
		
		/**
		 * 设置自己在更新列表（游戏对象列表）中的索引到列表的最后面，或是某个游戏对象的后面。正常情况下应该都不会用到……
		 * @param	target	目标游戏对象，不设置则移动到列表的最后面
		 * @param	close	是否紧挨着目标对象，也就是设置在该目标对象的后一位。仅在设置了 target 参数时有用
		 */
		public function setRenderIndexToBack(target:* = null, close:Boolean = true):void 
		{
			if (!target) {
				GameSpriteUtils.setRenderIndexToBack(_i);
			} else {
				GameSpriteUtils.setRenderIndexToTargetBack(_i, target, close);
			}
		}
		
		/**
		 * 判断该游戏对象是否被敌方游戏对象击中，需要该游戏对象有属于的队伍时（team 不为空）才能判断
		 * @return	返回一个包含了命中此游戏对象的攻击面信息的 Object，若没有命中则返回 null。
		 * 下面展示了该 Object 的参数：
		 * <ul>
		 * 	<li>hitVO：命中了该游戏对象的攻击面，类型为 HitVO</li>
		 * 	<li>hitRect：一个表示命中了的区域的矩形，类型为 Rectangle</li>
		 * </ul>
		 */
		public function checkBeHit():Object 
		{
			var enemyTeam:* = GameCtrl.I.getEnemyTeam(_i);
			if (enemyTeam == null) return;
			var list:Array = [];
			for (var index:int = 0; index < enemyTeam.children.length; ++index)
			{
				list.push(enemyTeam.children[index]);
			}
			checkBeHitFromList(list);
		}
		
		/**
		 * 判断该游戏对象是否被列表中的游戏对象（包括己方游戏对象）击中，可以不需要该游戏对象有属于的队伍（team 可以为空）
		 * @param	list	一个包含了若干游戏对象的列表
		 * @return	返回一个包含了命中此游戏对象的攻击面信息的 Object，若没有命中则返回 null。
		 * 具体返回格式请参考 checkBeHit 方法.
		 */
		public function checkBeHitFromList(list:Array):Object
		{
			var bodyArea:Rectangle = _i.getBodyArea();
			if (!bodyArea || bodyArea.isEmpty()) 
			{
				return null;
			}
			for (var index:int = 0; index < list.length; ++index) 
			{
				var hits:Array = list[index].getCurrentHits();
				if (!hits || hits.length < 1) continue;
				for (var hitIndex:int = 0; hitIndex < hits.length; ++hitIndex) 
				{
					var hitVO:* = hits[hitIndex];
					if (hitVO != null && hitVO.currentArea != null)
					{
						var hitArea:Rectangle = hitVO.currentArea.intersection(bodyArea);
						if (hitArea && !hitArea.isEmpty()) 
						{
							return {
								"hitVO":hitVO,
								"hitRect":hitArea
							}
						}
					}
				}
			}
			return null;
		}
		
	}

}
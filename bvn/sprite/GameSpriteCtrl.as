package bvn.sprite
{
	
	import flash.display.MovieClip;
	import net.play5d.game.bvn.ctrl.game_ctrls.GameCtrl;
	import net.play5d.game.bvn.state.GameState;
	import bvn.BVNClass;
	
	/**
	 * 此类已废弃，仅保留兼容作用
	 * @private
	 */
	public class GameSpriteCtrl
	{
		
		private var _owner:*;
		
		private var _renderFunc:Function;
		
		private var _renderAnimateFunc:Function;
		
		public function GameSpriteCtrl(target:*)
		{
			// constructor code
			_owner = target;
			if (isBaseGameSprite())
			{
				_initRender();
			}
		}
		
		public static function findGameSprite(mc:MovieClip):*
		{
			var gameSprites:Vector.<*> = getGameSprites();
			var target:* = null;
			for each (var i in gameSprites)
			{
				if (i.getDisplay() == mc)
				{
					target = i;
					break;
				}
			}
			if (target)
			{
				return new GameSpriteCtrl(target);
			}
			return null;
		}
		
		public static function getGameSprite(mc:MovieClip):*
		{
			var gameSprites:Vector.<*> = getGameSprites();
			var target:* = null;
			for each (var i in gameSprites)
			{
				if (i.getDisplay() == mc)
				{
					target = i;
					break;
				}
			}
			if (target)
			{
				return target;
			}
			return null;
		}
		
		public static function findListIndex(target:*):int 
		{
			return getGameSprites().indexOf(target);
		}
		
		public static function moveToListIndex(index1:int, index2:int):void 
		{
			var gameSprites:Vector.<*> = getGameSprites();
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
		
		public static function setListIndexTo(sprite1:*, sprite2:*, toBack:Boolean, close:Boolean = true):void 
		{
			var index1:int = findListIndex(sprite1);
			if (index1 == -1) return;
			var index2:int = findListIndex(sprite2);
			if (index2 == -1) return;
			if (close) {
				if (toBack && index1 - index2 == 1) return;
				if (!toBack && index2 - index1 == 1) return;
			} else {
				if (toBack && index1 > index2) return;
				if (!toBack && index1 < index2) return;
			}
			if (toBack) {
				if (index1 < index2) moveToListIndex(index1, index2);
				else moveToListIndex(index1, index2 + 1);
			} else {
				if (index1 > index2) moveToListIndex(index1, index2);
				else moveToListIndex(index1, index2 - 1);
			}
		}
		
		public static function getGameSprites():*//Vector.<*>
		{
			return GameCtrl.I.gameState.getGameSprites();
		}
		
		public function isBaseGameSprite():Boolean
		{
			return _owner is BVNClass.getBVNClass("interfaces.BaseGameSprite");
		}
		
		/* ----- ----- ----- ----- base ----- ----- ----- ----- */
		
		public function get owner():*
		{
			return _owner;
		}
		
		/* ----- ----- ----- ----- render ----- ----- ----- ----- */
		
		public function setRenderFunc(func:Function):void
		{
			_renderFunc = func;
		}
		
		public function removeRenderFunc():void
		{
			_renderFunc = null;
		}
		
		public function setRenderAnimateFunc(func:Function):void
		{
			_renderAnimateFunc = func;
		}
		
		public function removeRenderAnimateFunc():void
		{
			_renderAnimateFunc = null;
		}
		
		private function _render():void
		{
			_owner.delayCall(_render, 1);
			if (_renderFunc != null) _renderFunc();
		}
		
		private function _renderAnimate():void
		{
			_owner.setAnimateFrameOut(_renderAnimate, 1);
			if (_renderAnimateFunc != null) _renderAnimateFunc();
		}
		
		private function _initRender():void
		{
			_owner.delayCall(_render, 1);
			_owner.setAnimateFrameOut(_renderAnimate, 1);
		}
	
	}

}

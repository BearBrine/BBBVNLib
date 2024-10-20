package bvn.sprite
{
	import bvn.sprite.events.GameSpriteEvent;
	import bvn.BVNClass;
	import flash.events.Event;
	
	/**
	 * 游戏对象本体更新帧时调度，调度时机在更新速度移动之后，执行其它更新之前
	 * @eventType bvn.sprite.events.GameSpriteEvent.RENDER
	 */
	[Event(name = "render", type = "bvn.sprite.events.GameSpriteEvent")]
	/**
	 * 游戏对象本体更新动画帧时调度，调度时机在执行其它更新之前，始终在调度 render 事件之后调度
	 * @eventType bvn.sprite.events.GameSpriteEvent.RENDER_ANIMATE
	 */
	[Event(name = "renderAnimate", type = "bvn.sprite.events.GameSpriteEvent")]
	/**
	 * 用于方便控制 BaseGameSprite 类的控制器
	 * @author BearBrine
	 */
	public class GameSprite extends GameSpriteBase
	{
		
		private var _delayFuncs:Array;
		
		private var _delayAnimateFuncs:Array;
		
		/**
		 * 创建一个包装游戏对象 target 的控制器
		 * @param	target	目标游戏对象，类型必须为 BaseGameSprite 或其子类
		 */
		public function GameSprite(target:*)
		{
			super(target);
			if (target is BVNClass.getBVNClass("interfaces.BaseGameSprite") == false)
			{
				throw new Error("目标对象类型不是BaseGameSprite，如果是IGameSprite请考虑使用GameSpriteBase");
			}
			_initRenderer();
		}
		
		/**
		 * 延时若干帧后调用函数，不用担心出现原delayCall函数莫名跳过调用的诡异问题
		 * @param	func	要调用的函数
		 * @param	frame	间隔多少帧后调用
		 */
		public function delayCall(func:Function, frame:int):void
		{
			if (!_delayFuncs) _delayFuncs = [];
			_delayFuncs.push({"func": func, "frame": frame});
		}
		
		/**
		 * 延时若干动画帧后调用函数，不用担心出现原setAnimateFrameOut函数莫名跳过调用的诡异问题
		 * @param	func	要调用的函数
		 * @param	frame	间隔多少帧后调用
		 */
		public function delayAnimateCall(func:Function, frame:int):void
		{
			if (!_delayAnimateFuncs) _delayAnimateFuncs = [];
			_delayAnimateFuncs.push({"func": func, "frame": frame});
		}
		
		private function _initRenderer():void
		{
			_i.delayCall(_onRender, 1);
			_i.setAnimateFrameOut(_onRenderAnimate, 1);
		}
		
		private function _onRender():void
		{
			_i.delayCall(_onRender, 1);
			dispatchEvent(new GameSpriteEvent(GameSpriteEvent.RENDER));
			_updateDelayCall();
		}
		
		private function _onRenderAnimate():void
		{
			_i.setAnimateFrameOut(_onRenderAnimate, 1);
			dispatchEvent(new GameSpriteEvent(GameSpriteEvent.RENDER_ANIMATE));
			_updateDelayAnimateCall();
		}
		
		private function _updateDelayCall():void
		{
			if (!_delayFuncs || _delayFuncs.length < 1) return;
			for (var index:int = 0; index < _delayFuncs.length; ++index)
			{
				if (--_delayFuncs[index].frame < 1)
				{
					try
					{
						_delayFuncs[index].func.call(NaN);
					}
					catch (err:Error)
					{
						//throw new Error(err.message + "\n\r" + err.getStackTrace());
					}
					_delayFuncs.splice(index, 1);
					--index;
				}
			}
		}
		
		private function _updateDelayAnimateCall():void
		{
			if (!_delayAnimateFuncs || _delayAnimateFuncs.length < 1) return;
			for (var index:int = 0; index < _delayAnimateFuncs.length; ++index)
			{
				if (--_delayAnimateFuncs[index].frame < 1)
				{
					try
					{
						_delayAnimateFuncs[index].func.call(NaN);
					}
					catch (err:Error)
					{
						//throw new Error(err.message + "\n\r" + err.getStackTrace());
					}
					_delayAnimateFuncs.splice(index, 1);
					--index;
				}
			}
		}
	
	}

}
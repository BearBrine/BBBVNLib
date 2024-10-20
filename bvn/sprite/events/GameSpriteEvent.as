package bvn.sprite.events 
{
	import flash.events.Event;
	
	/**
	 * 特定于 GameSpriteBase 及其子类的事件对象
	 * @author BearBrine
	 */
	public class GameSpriteEvent extends Event 
	{
		
		public static const RENDER:String = "render";
		
		public static const RENDER_ANIMATE:String = "renderAnimate";
		
		
		public var params:*;
		
		public function GameSpriteEvent(type:String, parameters:*=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			params = parameters;
		}
		
	}

}
package bvn.sprite.fighter
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author BearBrine
	 */
	
	// only for 3.6
	
	public class FighterActionScanner
	{
		
		private const ACTION_LIST:Array = ["catch1", "catch2", "bishaSUPER", "bishaUP", "bisha", "skill2", "skill1", "zhao3", "zhao2", "attack", "zhao1", "defense", "dash", "moveLeft", "moveRight", "jump", "jumpDown", "attackAIR", "skillAIR", "bishaAIR"];
		
		private const ACTION_CTRLER_LIST:Array = ["catch1", "catch2", "bishaSUPER", "bishaUP", "bisha", "skill2", "skill1", "zhao3", "zhao2", "attack", "zhao1", "defense", "dash", "moveLEFT", "moveRIGHT", "jump", "jumpDown", "attackAIR", "skillAIR", "bishaAIR"];
		
		private var _fighter:*;
		
		private var _action:*;
		
		private var _actionCtrler:*;
		
		private var _lastAction:Object;
		
		private var _listeners:Dictionary;
		
		public function FighterActionScanner(target:*)
		{
			_fighter = target;
			_action = _fighter.getCtrler().getMcCtrl().getAction();
			_actionCtrler = _fighter.getCtrler().getMcCtrl().getActionCtrler();
			_lastAction = {};
			_listeners = new Dictionary();
			updateAction();
		}
		
		public function addListener(func:Function):void 
		{
			if (!_listeners[func]) {
				_listeners[func] = func;
			}
		}
		
		public function removeListener(func:Function):void 
		{
			if (_listeners[func]) {
				delete _listeners[func];
			}
		}
		
		public function render():Array 
		{
			var actionInfo:Array = findDoingAction();
			updateAction();
			return actionInfo;
		}
		
		private function updateAction():void
		{
			for each(var act:String in ACTION_LIST) 
			{
				_lastAction[act] = _action[act];
			}
		}
		
		private function findDoingAction():Array 
		{
			var doingActionName:String = _fighter.getMC().currentFrameName;
			var doingAction:String = null;
			for (var i:int = 0; i < ACTION_CTRLER_LIST.length; ++i) 
			{
				if (_actionCtrler[ACTION_CTRLER_LIST[i]]() && 
					(_lastAction[ACTION_LIST[i]] == doingActionName || _lastAction[ACTION_LIST[i]] && (ACTION_LIST[i] == "jump" && (doingActionName == "起跳" || doingActionName == "跳中" || doingActionName == "跳"))) ) 
				{
					doingAction = ACTION_LIST[i];
					break;
				}
			}
			if (doingAction) 
			{
				for each (var func:Function in _listeners) 
				{
					func(doingAction, doingActionName);
				}
				return [doingAction, doingActionName];
			}
			return null;
		}
		
		public function destroy():void 
		{
			_fighter = null;
			_action = null;
			_actionCtrler = null;
			_lastAction = null;
			_listeners = null;
		}
	
	}

}
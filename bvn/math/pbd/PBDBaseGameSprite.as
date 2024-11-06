package bvn.math.pbd {
    import bvn.BVNClass;
    import flash.geom.Point;

    public class PBDBaseGameSprite extends BasePBDParticle {

        public function PBDBaseGameSprite(baseGameSprite:*) {
            super(baseGameSprite);
            if (baseGameSprite is BVNClass.getBVNClass("interfaces.BaseGameSprite") == false) {
                throw new Error("目标对象类型不是BaseGameSprite");
            }
            _target = baseGameSprite;
            _predX = x;
            _predY = y;
        }

        override public function get x():Number {
            return _target.x;
        }

        override public function get y():Number {
            return _target.y;
        }

        override public function get velocity():Point {
            return _target.getVelocity();
        }

        override public function set velocity(value:Point):void {
            _target.setVelocity(value.x, value.y);
        }
    }
}
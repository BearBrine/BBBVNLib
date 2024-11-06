package bvn.math.pbd {
    import bvn.BVNClass;
    import flash.geom.Point;

    public class PBDBullet extends BasePBDParticle {

        public function PBDBullet(bullet:*) {
            super(baseGameSprite);
            if (bullet is BVNClass.getBVNClass("fighter.Bullet") == false) {
                throw new Error("目标对象类型不是Bullet");
            }
            _target = bullet;
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
            return _target.speed;
        }

        override public function set velocity(value:Point):void {
            _target.speed = value;
        }
    }
}
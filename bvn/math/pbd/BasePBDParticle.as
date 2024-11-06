package bvn.math.pbd {
    import flash.geom.Point;

    public class BasePBDParticle implements IPBDParticle {
        protected var _target:*;

        protected var _predX:Number;
        protected var _predY:Number;

        public function BasePBDParticle(target:*) {
            _target = target;
        }

        public function get x():Number {
            return 0;
        }

        public function get y():Number {
            return 0;
        }

        public function get velocity():Point {
            return null;
        }

        public function set velocity(value:Point):void {
        }

        public function get target():* {
            return _target;
        }

        public function get predX():Number {
            return _predX;
        }

        public function set predX(value:Number):void {
            _predX = value;
        }

        public function get predY():Number {
            return _predY;
        }

        public function set predY(value:Number):void {
            _predY = value;
        }
    }
}
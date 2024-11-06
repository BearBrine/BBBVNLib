package bvn.math.pbd
{
    public class PBDDistanceConstraint implements IPBDConstraint
    {
        private var _target1:*;
        private var _target2:*;

        private var particle1:IPBDParticle;
        private var particle2:IPBDParticle;

        private var _distance:Number;
        private var _stiffness:Number;
        private var _fixed_target1:Boolean;

        public function PBDDistanceConstraint(target1:*, target2:*, distance:Number, stiffness:Number = 1, fixed_target1:Boolean = false)
        {
            _target1 = target1;
            _target2 = target2;
            _distance = distance;
            _stiffness = stiffness;
            _fixed_target1 = fixed_target1;
        }

        public function getTargets():Array
        {
            return [_target1, _target2];
        }

        public function setPBDParticles(targets:Vector.<IPBDParticle>):void
        {
            particle1 = targets[0];
            particle2 = targets[1];
        }

        public function project():void
        {
            var dx:Number = particle2.predX - particle1.predX;
            var dy:Number = particle2.predY - particle1.predY;

            var distance:Number = Math.sqrt(dx * dx + dy * dy);
            if (distance != 0) {
                var diff:Number = distance - _distance;
                var correction:Number = diff / distance;
                if (_fixed_target1 == true) {
                    particle2.predX -= dx * correction * _stiffness;
                    particle2.predY -= dy * correction * _stiffness;
                }
                else {
                    particle1.predX += dx * correction * 0.5 * _stiffness;
                    particle1.predY += dy * correction * 0.5 * _stiffness;
                    particle2.predX -= dx * correction * 0.5 * _stiffness;
                    particle2.predY -= dy * correction * 0.5 * _stiffness;
                }
            }
        }
    }
}
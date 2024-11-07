package bvn.math.pbd
{
    public class PBDDistanceConstraint implements IPBDConstraint
    {
        private var _target1:*;
        private var _target2:*;

        private var particle1:IPBDParticle;
        private var particle2:IPBDParticle;

        private var _distance:Number;
        private var _flexibility:Number;
        private var _fixed_target1:Boolean;

        private var _lambda:Number = 0;

        public function PBDDistanceConstraint(target1:*, target2:*, distance:Number, fixed_target1:Boolean = false, flexibility:Number = 0.2)
        {
            _target1 = target1;
            _target2 = target2;
            _distance = distance;
            _fixed_target1 = fixed_target1;
            _flexibility = flexibility;
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
            if (distance == 0) {
                if (_distance == 0) {
                    return;
                }
                distance = Math.min(_distance, 0.00001);
                dx = distance;
            }
            var diff:Number = distance - _distance;
            var correction:Number = diff / distance;
            if (_fixed_target1 == true) {
                particle2.predX -= dx * correction;
                particle2.predY -= dy * correction;
            }
            else {
                particle1.predX += dx * correction * 0.5;
                particle1.predY += dy * correction * 0.5;
                particle2.predX -= dx * correction * 0.5;
                particle2.predY -= dy * correction * 0.5;
            }
        }

        public function clearLambda():void
        {
            _lambda = 0;
        }

        public function projectX(timeStep:Number):void
        {
            var dx:Number = particle2.predX - particle1.predX;
            var dy:Number = particle2.predY - particle1.predY;

            var distance:Number = Math.sqrt(dx * dx + dy * dy);
            if (distance == 0) {
                if (_distance == 0) {
                    return;
                }
                distance = Math.min(_distance, 0.00001);
                dx = distance;
            }
            var diff:Number = distance - _distance;
            var alpha:Number = _flexibility / (timeStep * timeStep);
            _lambda -= (diff + alpha * _lambda) / (1 + alpha);
            var correction:Number = -_lambda / distance;
            if (_fixed_target1 == true) {
                particle2.predX -= dx * correction;
                particle2.predY -= dy * correction;
            }
            else {
                particle1.predX += dx * correction * 0.5;
                particle1.predY += dy * correction * 0.5;
                particle2.predX -= dx * correction * 0.5;
                particle2.predY -= dy * correction * 0.5;
            }
        }
    }
}
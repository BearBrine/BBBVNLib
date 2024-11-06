package bvn.math.pbd {
    import flash.utils.Dictionary;

    public class PBD {
        private var _constraints:Vector.<IPBDConstraint>;
        private var _particles:Dictionary;
        private var _containedAmount:Dictionary;

        private var _delta:Number;
        private var _iterations:int;

        public function PBD(delta:Number, constraints:Vector.<IPBDConstraint> = null, iterations:int = 20) {
            _delta = delta;
            _iterations = iterations;

            _constraints = new Vector.<IPBDConstraint>();
            _particles = new Dictionary();
            _containedAmount = new Dictionary();
            for each (var constraint:IPBDConstraint in constraints) {
                addConstraint(constraint);
            }
        }

        public function get delta():Number {
            return _delta;
        }

        public function set delta(value:Number):void {
            _delta = value;
        }

        public function getConstraints():Vector.<IPBDConstraint> {
            return _constraints.concat();
        }

        public function getConstrainedTargets():Array {
            var targets:Array = [];
            for (var target:* in _particles) {
                targets.push(target);
            }
            return targets;
        }

        public function addConstraint(constraint:IPBDConstraint):void {
            var targets:Array = constraint.getTargets();
            var constraintParticles:Vector.<IPBDParticle> = new Vector.<IPBDParticle>();

            for (var index:int = 0; index < targets.length; index++) {
                var target:* = targets[index];
                if (!_particles[target]) {
                    if (target is IPBDParticle) {
                        _particles[target] = target;
                    }
                    else {
                        _particles[target] = PBDParticleFactory.createPBDParticle(target);
                    }
                    _containedAmount[target] = 1;
                } else {
                    _containedAmount[target]++;
                }
                constraintParticles.push(_particles[target]);
            }
            constraint.setPBDParticles(constraintParticles);

            _constraints.push(constraint);
        }

        public function removeConstraint(constraint:IPBDConstraint):void {
            var index:int = _constraints.indexOf(constraint);
            if (index != -1) {
                _constraints.splice(index, 1);
                var targets:Array = constraint.getTargets();
                for each (var target:* in targets) {
                    if (_particles[target] == undefined) {
                        continue;
                    }
                    _containedAmount[target]--;
                    if (_containedAmount[target] <= 0) {
                        delete _particles[target];
                        delete _containedAmount[target];
                    }
                }
            }
        }

        public function removeConstraintByTarget(target:*):void {
            if (_particles[target] != undefined) {
                delete _particles[target];
                delete _containedAmount[target];
                for each (var constraint:IPBDConstraint in _constraints) {
                    var index:int = constraint.getTargets().indexOf(target);
                    if (index != -1) {
                        removeConstraint(constraint);
                    }
                }
            }
        }

        public function removeConstraintByTargets(targets:Array):void {
            for each (var constraint:IPBDConstraint in _constraints) {
                var constraintTargets:Array = constraint.getTargets();
                var containAll:Boolean = true;
                for each (var target:* in targets) {
                    if (constraintTargets.indexOf(target) == -1) {
                        containAll = false;
                        break;
                    }
                }
                if (containAll) {
                    removeConstraint(constraint);
                }
            }
        }

        public function update():void {
            for each (var particle:IPBDParticle in _particles) {
                particle.predX = particle.x + particle.velocity.x * _delta;
                particle.predY = particle.y + particle.velocity.y * _delta;
            }
            for (var i:int = 0; i < _iterations; i++) {
                for each (var constraint:IPBDConstraint in _constraints) {
                    constraint.project();
                }
            }
            for each (particle in _particles) {
                particle.velocity.x = (particle.predX - particle.x) / _delta;
                particle.velocity.y = (particle.predY - particle.y) / _delta;
            }
        }
    }
}
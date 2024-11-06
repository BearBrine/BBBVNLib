package bvn.math.pbd
{
    public interface IPBDConstraint
    {
        function project():void;
        function getTargets():Array;
        function setPBDParticles(objects:Vector.<IPBDParticle>):void;
    }
}
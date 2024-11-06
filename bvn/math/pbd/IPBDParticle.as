package bvn.math.pbd
{
    import flash.geom.Point;

    public interface IPBDParticle
    {
        function get x():Number;
        function get y():Number;

        function get velocity():Point;
        function set velocity(value:Point):void;

        function get predX():Number;
        function set predX(value:Number):void;
        function get predY():Number;
        function set predY(value:Number):void;
    }
}
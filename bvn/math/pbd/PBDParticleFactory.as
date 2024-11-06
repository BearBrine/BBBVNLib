package bvn.math.pbd
{
    import bvn.BVNClass;
    import bvn.math.pbd.PBDBaseGameSprite;
    import bvn.math.pbd.PBDBullet;
    import bvn.math.pbd.IPBDParticle;

    public class PBDParticleFactory
    {
        public static function createPBDParticle(target:*):IPBDParticle
        {
            if (target is BVNClass.getBVNClass("interfaces.BaseGameSprite"))
            {
                return new PBDBaseGameSprite(target);
            }
            else if (target is BVNClass.getBVNClass("fighter.Bullet"))
            {
                return new PBDBullet(target);
            }
            else
            {
                throw new Error("不支持的对象类型");
                //return null;
            }
        }

        public static function getTarget(particle:IPBDParticle):*
        {
            return particle is BasePBDParticle ? particle.target : particle;
        }
    }
}
static class PhysicsUtils
{
    public static PVector GetVelocity(PVector initialV, PVector acceleration, float deltaT)
    {
        return new PVector(initialV.x + acceleration.x * deltaT, initialV.y + acceleration.y * deltaT);
    }
    
    public static PVector GetAcceleration(PVector _force, float _mass)
    {
        return _force.mult(1f / _mass);
    }
}
class Particle
{
    private PVector position;
    private PVector acceleration;
    private PVector velocity = new PVector(0, 0); 
    private PVector gravity;

    private PVector pointA;
    private PVector pointB;
    private PVector pointC;

    private float mass;
    private float dragCoefficient;
    private float size;

    private color fillColor;

    public Particle(PVector _position, PVector _force, PVector _gravity, float _mass, int _size, color _fillColor)
    {
        position = _position;        
        SetPoints();
        
        mass = _mass;
        gravity = _gravity;
        
        size = _size;
        fillColor = _fillColor;
    }
    
    private void UpdatePosition(float _deltaT)
    {
        acceleration.mult(dragCoefficient);
        
        velocity = PhysicsUtils.GetVelocity(velocity, acceleration, _deltaT);
        
        PhysicsUtils.UpdatePosition(this, _deltaT);
    }
    
    private void SetPoints()
    {
        float triangleHeight = (size * sqrt(3)) / 2;
        
        pointA = new PVector(round(position.x - size / 2f), round(position.y + (1f / 3f) * triangleHeight));
        pointB = new PVector(round(position.x + size / 2f), round(position.y + (1f / 3f) * triangleHeight));
        pointC = new PVector(round(position.x), round(position.y - (2f / 3f) * triangleHeight));
    }

    public PVector GetPosition()
    {
        return position;
    }
    
    public PVector GetPointA()
    {
        return pointA;
    }
    
    public PVector GetPointB()
    {
        return pointB;
    }
    
    public PVector GetPointC()
    {
        return pointC;
    }
    
    public PVector GetVelocity()
    {
        return velocity;
    }

    public float GetMass()
    {
        return mass;
    }

    public float GetSize()
    {
        return size;
    }

    public color GetFillColor()
    {
        return fillColor;
    }
    
    void UpdateState(float deltaT)
    {        
        UpdatePosition(deltaT);
        
        SetPoints();
    }
}
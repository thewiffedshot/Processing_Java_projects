class Walker
{
    PVector location;
    int distance = 0;
    int colorOffset = (int) random(0, 256);
    int D = 1;
    float radius = 16;
    PVector[] hitbox = new PVector[2];
    
    Walker(PVector _location)
    {
        location = _location;
      
        CreateHitbox();
    }
    
    void CreateHitbox()
    {
        hitbox[0] = location;
        hitbox[1] = new PVector(radius, radius);     
    }
    
    void Display()
    {      
        stroke(255 * ((sin(distance) + 1) / 2) + colorOffset, 255 * ((cos(distance * 0.01f) + 1) / 2) + colorOffset, 255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI) + colorOffset, 200);
        fill(255 * ((sin(distance) + 1) / 2) + colorOffset, 255 * ((cos(distance * 0.01f) + 1) / 2) + colorOffset, 255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI) + colorOffset, 200);
        ellipse(location.x, location.y, radius, radius);
                
        distance++;
    }
    
    void Move(PVector velocity)
    {
        location.add(velocity);
        CreateHitbox();
    }
}
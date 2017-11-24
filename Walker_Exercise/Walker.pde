class Walker
{
    int x, y;
    int distance = 0;
    int colorOffset = (int) random(0, 256);
    int D = 1;
    float radius;
    float[][] hitbox = new float[1][3];
    String hitboxType = "Circle";
    
    Walker(int _x, int _y)
    {
        x = _x;
        y = _y;
      
        createHitbox();
    }
    
    void createHitbox()
    {
        hitbox[0][1] = x;
        hitbox[0][2] = y;
        hitbox[0][3] = radius * radius;      
    }
    
    void Display()
    {
        radius = map(sin(distance * 0.05f), -1, 1, 5, 20);
      
        stroke(255 * ((sin(distance) + 1) / 2) + colorOffset, 255 * ((cos(distance * 0.01f) + 1) / 2) + colorOffset, 255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI) + colorOffset, 200);
        fill(255 * ((sin(distance) + 1) / 2) + colorOffset, 255 * ((cos(distance * 0.01f) + 1) / 2) + colorOffset, 255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI) + colorOffset, 200);
        ellipse(x, y, radius, radius);
        
        
        
        //background(-255 * ((sin(distance) + 1) / 2), -255 * ((cos(distance * 0.01f) + 1) / 2), -255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI));
        
        distance++;
    }
    
    void ChangeBackground()
    {
        pushMatrix();
          background(255 * ((sin(-distance) + 1) / 2), (255 * ((cos(distance * 0.01f) - 1) / 2)), 255 * ((sin(-distance * 0.01f) + 1) / 2) - (3 * PI));
        popMatrix();
    }
}
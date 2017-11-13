class Walker
{
    int x, y;
    int distance = 0;
    int colorOffset = (int) random(0, 256);
    int D = 1;
    
    Walker(int _x, int _y)
    {
        x = _x;
        y = _y;
    }
    
    void Display()
    {
        stroke(255 * ((sin(distance) + 1) / 2) + colorOffset, 255 * ((cos(distance * 0.01f) + 1) / 2) + colorOffset, 255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI) + colorOffset, 200);
        fill(255 * ((sin(distance) + 1) / 2) + colorOffset, 255 * ((cos(distance * 0.01f) + 1) / 2) + colorOffset, 255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI) + colorOffset, 200);
        ellipse(x, y, map(sin(distance * 0.05f), -1, 1, 5, 20), map(sin(distance * 0.05f), -1, 1, 5, 20));
        
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
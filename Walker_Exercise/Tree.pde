class Tree
{
    PVector location; 
    float size = 16;
    float angle = 65;
    PVector[] points = new PVector[8];
    
    Tree(PVector _location)
    {
        location = _location;
    
        createPoints();
    }
  
    Tree(PVector _location, float _size)
    {
        location = _location;
        size = _size;
    
        createPoints();
    }
  
    Tree(PVector _location, float _size, float _angle)
    {
        location = _location;
        size = _size;
        angle = constrain(_angle, 45, 70);
    
        createPoints();
    }
  
    void createPoints()
    {
        points[0] = location;
        points[1] = new PVector(location.x, location.y - size); // C
        points[2] = new PVector(location.x + (size / tan(radians(angle))), location.y); // B       
        points[3] = new PVector(location.x + (size / (3 * tan(radians(angle)))), location.y); // E
        points[4] = new PVector(points[3].x, location.y + ((2f/3) * size)); // G        
        points[6] = new PVector(location.x - (size / (3 * tan(radians(angle)))), location.y); // D        
        points[5] = new PVector(points[6].x, location.y + ((2f/3) * size)); // F                
        points[7] = new PVector(location.x - (size / tan(radians(angle))), location.y); // A
    }
    
    void drawTree()
    {
        pushMatrix();
            fill(0, 255, 0);
            stroke(0);
            beginShape();
            vertex(points[1].x, points[1].y);
            vertex(points[2].x, points[2].y);
            vertex(points[7].x, points[7].y);
            endShape();
        popMatrix();
    
        pushMatrix();
            fill(100, 30, 0);
            stroke(0);
            beginShape();
            vertex(points[6].x, points[6].y);
            vertex(points[3].x, points[3].y);
            vertex(points[4].x, points[4].y);
            vertex(points[5].x, points[5].y);
            endShape();
        popMatrix();
    }
}
class Tree
{
    float x, y, size = 16;
    float angle = 65;
    PVector centre;
    PVector[] points = new PVector[7];
    float[][] hitbox = new float[6][3];
    static final String hitboxType = "Polygon";
    
    Tree()
    {
        // Dummy constructor for Object relation.
    }
    
    Tree(float _x, float _y)
    {
        x = _x;
        y = _y;
    
        createPoints();
        //createHitbox();
    }
  
    Tree(float _x, float _y, float _size)
    {
        x = _x;
        y = _y;
        size = _size;
    
        createPoints();
        //createHitbox();
    }
  
    Tree(float _x, float _y, float _size, float _angle)
    {
        x = _x;
        y = _y;
        size = _size;
        angle = constrain(_angle, 45, 70);
    
        createPoints();
        //createHitbox();
    }
  
    void createPoints()
    {
        centre = new PVector(x, y);
        points[2] = new PVector(x, y - size);
        points[1] = new PVector(x + (size / tan(radians(angle))), y);
        points[0] = new PVector(x - (size / tan(radians(angle))), y);
        points[3] = new PVector(x - (size / (3 * tan(radians(angle)))), y);
        points[4] = new PVector(x + (size / (3 * tan(radians(angle)))), y);
        points[5] = new PVector(points[3].x, y + ((2f/3) * size));
        points[6] = new PVector(points[4].x, y + ((2f/3) * size));
    }
    
    void drawTree()
    {
        pushMatrix();
            fill(0, 255, 0);
            stroke(0);
            beginShape();
            vertex(points[0].x, points[0].y);
            vertex(points[1].x, points[1].y);
            vertex(points[2].x, points[2].y);
            endShape();
        popMatrix();
    
        pushMatrix();
            fill(100, 30, 0);
            stroke(0);
            beginShape();
            vertex(points[3].x, points[3].y);
            vertex(points[4].x, points[4].y);
            vertex(points[5].x, points[5].y);
            vertex(points[6].x, points[6].y);
            endShape();
        popMatrix();
    }
    
    /*void createHitbox()
    {
        //AB
        hitbox[0][0] = 0;
        hitbox[0][1] = B.x - A.x;
        hitbox[0][2] = -A.y * (B.x - A.y);
    
        //BC
        hitbox[1][0] = -(C.y - B.y);
        hitbox[1][1] = C.x - B.x;
        hitbox[1][2] = C.y * (C.x + B.x) - C.x * (C.y + B.y);
    
        //AC
        hitbox[2][0] = -(C.y - A.y);
        hitbox[2][1] = C.x - A.x;
        hitbox[2][2] = C.y * (C.x + A.x) - C.x * (C.y + A.y);
    
        //FG
        hitbox[3][0] = 0;
        hitbox[3][1] = G.x - F.x;
        hitbox[3][2] = -F.y * (G.x - F.y);
    
        //DF
        hitbox[3][0] = F.y - D.y;
        hitbox[3][1] = 0;
        hitbox[3][2] = D.x * (D.y - F.y);
    
        //EG
        hitbox[3][0] = G.y - E.y;
        hitbox[3][1] = 0;
        hitbox[3][2] = D.x * (D.y - F.y) + (2f / 3 * B.copy().sub(A).mag());
    }*/
}
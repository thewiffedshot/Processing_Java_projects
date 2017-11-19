class Tree
{
  float x, y, size = 16;
  float angle = 65;
  PVector centre, A, B, C, D, E, F, G;
  float[][] hitbox = new float[6][3];
  String hitboxType = "Polygon";
  
  Tree(float _x, float _y)
  {
    x = _x;
    y = _y;
    
    createPoints();
    createHitbox();
  }
  
  Tree(float _x, float _y, float _size)
  {
    x = _x;
    y = _y;
    size = _size;
    
    createPoints();
    createHitbox();
  }
  
  Tree(float _x, float _y, float _size, float _angle)
  {
    x = _x;
    y = _y;
    size = _size;
    angle = constrain(_angle, 45, 70);
    
    createPoints();
    createHitbox();
  }
  
  void createPoints()
  {
    centre = new PVector(x, y);
    C = new PVector(x, y - size);
    B = new PVector(x + (size / tan(radians(angle))), y);
    A = new PVector(x - (size / tan(radians(angle))), y);
    D = new PVector(x - (size / (3 * tan(radians(angle)))), y);
    E = new PVector(x + (size / (3 * tan(radians(angle)))), y);
    F = new PVector(D.x, y + ((2f/3) * size));
    G = new PVector(E.x, y + ((2f/3) * size));
  }
  
  void createHitbox()
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
  }
  
  void drawTree()
  {
    pushMatrix();
      fill(0, 255, 0);
      stroke(0);
      beginShape();
      vertex(A.x, A.y);
      vertex(B.x, B.y);
      vertex(C.x, C.y);
      endShape();
    popMatrix();
    
    pushMatrix();
      fill(100, 30, 0);
      stroke(0);
      beginShape();
      vertex(D.x, D.y);
      vertex(E.x, E.y);
      vertex(G.x, G.y);
      vertex(F.x, F.y);
      endShape();
    popMatrix();
  }
}
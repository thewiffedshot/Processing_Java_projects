PVector location = new PVector(0, 0, 0);
PVector velocity = new PVector(1.5f, 2f, 1.5f);
int size = 200;
int radius = size / 10;

void setup()
{
  size(640, 640, P3D);
  background(160);
}

void draw()
{ 
  noFill();
  translate(width / 2, height / 2, 220);
  
  background(160);
  
  rotateY(PI/3);
  box(size);
 
  if (location.x >= size / 2 - radius / 2 || location.x <= -size / 2 + radius / 2)
    velocity.x *= -1;
  if (location.y >= size / 2 - radius / 2 || location.y <= -size / 2 + radius / 2)
    velocity.y *= -1;
  if (location.z >= size / 2 - radius / 2 || location.z <= -size / 2 + radius / 2)
    velocity.z *= -1;
  
  location.add(velocity);  
    
  translate(location.x, location.y, location.z);
  sphere(radius); 
}
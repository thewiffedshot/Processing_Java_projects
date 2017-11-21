int interval = 10;
int rows, cols;
float xOff = 0, yOff = 0;
float[][] heightMap;
float time = 0;

void setup()
{
  size(1280, 720, P3D);
  background(0, 51, 102);
  
  frameRate(60);
  
  rows = height / interval;
  cols = width / interval;
  
  heightMap = new float[rows + 2][cols + 1];  
}

void draw()
{
  updateTerrain();
  
  background(0, 51, 102);
  
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-width/2, -height/2, -200);
    
  for (int y = 0; y <= rows; y++)
  {  
    noFill();
    stroke(255, 0, 255);
    
    beginShape(TRIANGLE_STRIP);
    
    for(int x = 0; x <= cols; x++)
    {
      vertex(x * interval, y * interval, heightMap[y][x]);//map(noise(xOff, yOff), -1, 1, 0, 80));//
      vertex(x * interval, (y + 1) * interval, heightMap[y + 1][x]);//map(noise(xOff, yOff + 0.1f), -1, 1, 0, 80));//heightMap[y + 1][x]);
    }
    
    endShape();
  }
}

void updateTerrain()
{
  time -= 0.04f;
  
  yOff = time;
  
  for (int y = 0; y <= rows; y++)
  {    
    xOff = 0;
    
    for (int x = 0; x <= cols; x++)
    {
      heightMap[y][x] = map(noise(xOff, yOff), 0, 1, 0, 100);
      
      xOff += 0.3f;
    }
    
    yOff += 0.3f;
  }
}
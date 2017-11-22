int interval = 20;
int rows, cols;
float xOff = 0, yOff = 0;
float[][] heightMap;
float time = 0;
color background = color(135, 206, 250);

void setup()
{
  size(1280, 720, P3D);
  background(background);
  
  frameRate(60);
  noiseDetail(8);
  
  
  rows = 3 * height / interval;
  cols = 2 * width / interval;
  
  heightMap = new float[rows + 2][cols + 1];  
  
  
}

void draw()
{
  updateTerrain();
    
  background(background);
  
  pushMatrix();
  
  fill(255, 255, 0);
  ellipse(0, 0, map(sin(time), -1, 1, 0.95f, 1f) * 250, map(sin(time), -1, 1, 0.95f, 1f) * 250);
  
  popMatrix();
  
  pushMatrix();

  pointLight(255, 255, 255, width / 2, 150, 500);
  
  translate(width/2, height/2);
  rotateX(PI/3);
  //rotateZ(time / 80);
  translate(-width, -height, -200);
    
  for (int y = 0; y <= rows; y++)
  {  
    fill(0, 223, 50);
    noStroke();
    
    beginShape(TRIANGLE_STRIP);
    
    for(int x = 0; x <= cols; x++)
    {
      vertex(x * interval, y * interval, heightMap[y][x]);//map(noise(xOff, yOff), -1, 1, 0, 80));//
      vertex(x * interval, (y + 1) * interval, heightMap[y + 1][x]);//map(noise(xOff, yOff + 0.1f), -1, 1, 0, 80));//heightMap[y + 1][x]);
    }
    
    endShape();
  }
  
  popMatrix();
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
      heightMap[y][x] = map(noise(xOff, yOff), 0, 1, 0, 250);
      
      xOff += 0.1f;
    }
    
    yOff += 0.1f;
  }
}
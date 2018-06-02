float damping = 0.995;

float[][] buffer1;
float[][] buffer2;
PImage img;

void setup()
{
  size(600, 600, P2D);
  buffer1 = new float[width][height];
  buffer2 = new float[width][height];
  
  img = createImage(width, height, RGB);
  img.loadPixels();
  
  for (int x = 1; x < width - 1; x++)
  {
    for (int y = 1; y < height - 1; y++)
    {
      buffer1[x][y] = 0;
      buffer2[x][y] = 0;
    }
  }
}

void draw()
{
  for (int x = 1; x < width - 1; x++)
  {
    for (int y = 1; y < height - 1; y++)
    {
      int index = y * width + x;
      buffer2[x][y] = (buffer1[x-1][y] + buffer1[x+1][y] + buffer1[x][y+1] + buffer1[x][y-1]) / 2 - buffer2[x][y];
      buffer2[x][y] *= damping; 
      img.pixels[index] = color(int(buffer2[x][y]));
    }
  }
  
  img.updatePixels();
  
  float[][] temp = buffer1;
  buffer1 = buffer2;
  buffer2 = temp;
  
  image(img, 0, 0);
}

void mouseClicked()
{
  buffer2[mouseX][mouseY] = 255;
}

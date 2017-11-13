package processing.test.walker_exercise;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Walker_Exercise extends PApplet {


ArrayList<Walker> pauls = new ArrayList();
Random randy = new Random();

public void setup()
{
    
    background(160, 160, 160);
    frameRate(60);
}

float walkDev = 5;
float distanceMean = 5;
int D = 1;

public void draw()
{
  /*pushMatrix();
    if (!pauls.isEmpty())
    {
      pauls.get(pauls.size() - 1).ChangeBackground();
    } 
  popMatrix(); */
  
  
  
  for(Walker paul : pauls)
  {
    float rand = random(1);
    
    if (paul.x <= 0 || paul.x >= width || paul.y <= 0 || paul.y >= height) D = -1;

    if (sqrt(pow(paul.x - mouseX, 2) + pow(paul.y - mouseY, 2)) <= 15) D = 1;
    
    if (rand <= 0.1f)
    {
        if (mouseX > paul.x)
        {//paul.x--; 
          paul.x -= D * (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
        }
        else if (mouseX < paul.x) //paul.x++;
        { 
          paul.x += D * (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);          
        }
        if (mouseY > paul.y) //paul.y--;
        {
          paul.y -= D * (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
        }
        else if (mouseY < paul.y) //paul.y++;
        {
          paul.y += D * (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
        }
    }
    else if (rand > 0.1f && rand <= 0.3f)
    {
        //paul.x++; 
        paul.x += (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
    }
    else if (rand > 0.3f && rand <= 0.5f)
    {
        //paul.x--;
        paul.x -= (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
    }  
    else if (rand > 0.5f && rand <= 0.7f)
    {
        //paul.y++;
        paul.y += (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
    }
    else if (rand > 0.7f && rand < 0.9f)
    {
        //paul.y--;
        paul.y -= (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
    }
    
    paul.Display();
  }
}

public void mouseClicked()
{
  pauls.add(new Walker(mouseX, mouseY));
}
class Walker
{
    int x, y;
    int distance = 0;
    int colorOffset = (int) random(0, 256);
    
    Walker(int _x, int _y)
    {
        x = _x;
        y = _y;
    }
    
    public void Display()
    {
        stroke(255 * ((sin(distance) + 1) / 2) + colorOffset, 255 * ((cos(distance * 0.01f) + 1) / 2) + colorOffset, 255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI) + colorOffset, 200);
        fill(255 * ((sin(distance) + 1) / 2) + colorOffset, 255 * ((cos(distance * 0.01f) + 1) / 2) + colorOffset, 255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI) + colorOffset, 200);
        ellipse(x, y, map(sin(distance * 0.05f), -1, 1, 5, 20), map(sin(distance * 0.05f), -1, 1, 5, 20));
        
        //background(-255 * ((sin(distance) + 1) / 2), -255 * ((cos(distance * 0.01f) + 1) / 2), -255 * ((sin(distance * 0.01f) + 1) / 2) - (3 * PI));
        
        distance++;
    }
    
    public void ChangeBackground()
    {
      pushMatrix();
      background(255 * ((sin(-distance) + 1) / 2), (255 * ((cos(distance * 0.01f) - 1) / 2)), 255 * ((sin(-distance * 0.01f) + 1) / 2) - (3 * PI));
      popMatrix();
    }
}
  public void settings() {  size(1280, 720); }
}

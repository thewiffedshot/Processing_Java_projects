import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pendulum extends PApplet {

float x1 = 0, y1 = 0;
float x2 = 0, y2 = 0;
float length1 = 130;
float length2 = 100;
float mass1 = 10;
float mass2 = 10;
float angle1 = 5*PI/6;
float angle2 = -PI/3;
float m1_velocity = 0.2f;
float m2_velocity = 0;
float m1_acceleration = 0;
float m2_acceleration = 0;
float gravity = 9.8202437f;
float drag = 0.995f;
float prevTime = 0;
float deltaTime = 0;
float timePast = 0;
PGraphics buffer;

public void setup()
{
  
  background(255);
  
  buffer = createGraphics(600, 600);  
  buffer.beginDraw();
  buffer.background(255);
  buffer.endDraw();
}

public void draw()
{
  deltaTime = millis() - prevTime;
  timePast += deltaTime;
  prevTime = millis();
  
  image(buffer, 0, 0);
  stroke(0);
  strokeWeight(2);
  
  translate(300, 300);                  
  
  if (timePast >= 5)
  {
    fixedTimeStep();
    timePast = 0;
  }
  
  m1_velocity += m1_acceleration * deltaTime / 1000;
  m2_velocity += m2_acceleration * deltaTime / 1000;
  
  angle1 += m1_velocity;
  angle2 += m2_velocity;
  
  m1_velocity *= drag;
  m2_velocity *= drag;
  
  x1 = length1 * sin(angle1);
  y1 = length1 * cos(angle1);
  
  x2 = x1 + length2 * sin(angle2);
  y2 = y1 + length2 * cos(angle2);
  
  fill(0, 0, 255);
  line(0, 0, x1, y1);
  
  line(x1, y1, x2, y2);  
  ellipse(x1, y1, mass1, mass1);
  
  fill(255, 0, 255);
  ellipse(x2, y2, mass2, mass2); 
  
  buffer.beginDraw();
  buffer.translate(300, 300);   
  buffer.strokeWeight(0);
  buffer.fill(0, 255, 0, 40);
  buffer.ellipse(x1, y1, 5, 5);
  buffer.fill(255, 0, 255, 40);
  buffer.ellipse(x2, y2, 5, 5);
  buffer.endDraw();
}

public void fixedTimeStep()
{
  m1_acceleration = (-gravity * (2 * mass1 + mass2) * sin(angle1) 
                  - mass2 * gravity * sin(angle1 - 2 * angle2) - 2 * sin(angle1 - angle2)
                  * mass2 * (m2_velocity * m2_velocity * length2 + m1_velocity * m1_velocity * length1 * cos(angle1 - angle2)))
                  / (length1 * (2 * mass1 + mass2 - mass2 * cos(2 * angle1 - 2 * angle2)));
 
  m2_acceleration = (2 * sin(angle1 - angle2) 
                  * (m1_velocity * m1_velocity * length1 * (mass1 + mass2) + gravity * (mass1 + mass2) 
                  * cos(angle1) + m2_velocity * m2_velocity * length2 * mass2 * cos(angle1 - angle2)))
                  / (length2 * (2 * mass1 + mass2 - mass2 * cos(2 * angle1 - 2 * angle2)));
}

public void mouseClicked()
{
  float mx = mouseX;
  float my = mouseY;
  
  m1_velocity += map(mx, 0, 600, 0, 0.4f);
  m2_velocity += map(my, 0, 600, 0, 0.4f);
}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pendulum" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

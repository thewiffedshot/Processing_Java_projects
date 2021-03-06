float x1 = 0, y1 = 0;
float x2 = 0, y2 = 0;
float length1 = 150;
float length2 = 100;
float mass1 = 5;
float mass2 = 3;
float mMultiplier = 1;
float angle1 = 2 * PI / 5;
float angle2 = -PI / 6;
float m1_velocity = 0;
float m2_velocity = 0;
float m1_acceleration = 0;
float m2_acceleration = 0;
float gravity = 9.8202437;
float drag = 0.996;
float prevTime = 0;
float deltaTime = 0;
float timePast = 0;
PGraphics buffer;
boolean climbing = true;
float timeStep = 0; // fixed physics update in milliseconds

void setup()
{
  size(600, 600, P2D);
  background(255);
  
  mMultiplier = width * 0.015;
  
  stroke(0);
  strokeWeight(4);
  
  buffer = createGraphics(width, height, P2D );  
  buffer.beginDraw();
  buffer.background(255);
  buffer.endDraw();
}

void draw()
{
  deltaTime = millis() - prevTime;
  timePast += deltaTime;
  prevTime = millis();
  
  image(buffer, 0, 0);
  
  translate(width / 2, height / 2);                  
  
  if (timePast >= timeStep)
  {
    fixedTimeStep(timePast);
    timePast = 0;
  }
  
  angle1 += m1_velocity;
  angle2 += m2_velocity;
  
  x1 = length1 * sin(angle1);
  y1 = length1 * cos(angle1);
  
  x2 = x1 + length2 * sin(angle2);
  y2 = y1 + length2 * cos(angle2);
  
  fill(0, 0, 255);
  line(0, 0, x1, y1);
  
  line(x1, y1, x2, y2);  
  ellipse(x1, y1, mass1 * mMultiplier, mass1 * mMultiplier);
  
  fill(255, 0, 255);
  ellipse(x2, y2, mass2 * mMultiplier, mass2 * mMultiplier);
  
  buffer.beginDraw();
  
  buffer.endDraw();
  
  buffer.beginDraw();
  buffer.translate(width / 2, height / 2); 
  buffer.noStroke();
  buffer.fill(0, 255, 0, 40);
  buffer.ellipse(x1, y1, mass1 * mMultiplier / 4, mass1 * mMultiplier / 4);
  buffer.fill(255, 0, 255, 40);
  buffer.ellipse(x2, y2, mass2 * mMultiplier / 4, mass2 * mMultiplier / 4);
  buffer.endDraw();
}

void fixedTimeStep(float deltaTime)
{
  m1_acceleration = (-gravity * (2 * mass1 + mass2) * sin(angle1) 
                  - mass2 * gravity * sin(angle1 - 2 * angle2) - 2 * sin(angle1 - angle2)
                  * mass2 * (m2_velocity * m2_velocity * length2 + m1_velocity * m1_velocity * length1 * cos(angle1 - angle2)))
                  / (length1 * (2 * mass1 + mass2 - mass2 * cos(2 * angle1 - 2 * angle2)));
 
  m2_acceleration = (2 * sin(angle1 - angle2) 
                  * (m1_velocity * m1_velocity * length1 * (mass1 + mass2) + gravity * (mass1 + mass2) 
                  * cos(angle1) + m2_velocity * m2_velocity * length2 * mass2 * cos(angle1 - angle2)))
                  / (length2 * (2 * mass1 + mass2 - mass2 * cos(2 * angle1 - 2 * angle2)));
  
  m1_velocity += m1_acceleration * deltaTime / 1000;
  m2_velocity += m2_acceleration * deltaTime / 1000;
  
  m1_velocity *= drag;
  m2_velocity *= drag;  
}

void mouseClicked()
{
  float mx = mouseX;
  float my = mouseY;
  
  if (mouseButton == LEFT)
  {
    m1_velocity += map(mx, 0, width / 2, -0.2, 0);
    m1_velocity += map(mx, width / 2, width, 0, 0.2);
  }
  else if (mouseButton == RIGHT)
  {
    m2_velocity += map(mx, 0, width / 2, -0.2, 0);
    m2_velocity += map(mx, width / 2, width, 0, 0.2);
  }
}

void keyPressed()
{
  if (key == 'c' || key == 'C')
  {
    buffer.beginDraw();
    buffer.fill(255, 255, 255, 255);
    buffer.rect(0, 0, width, height);
    buffer.endDraw();
  }
}

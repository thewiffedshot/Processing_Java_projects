float x1 = 0, y1 = 0;
float x2 = 0, y2 = 0;
float length1 = 290;
float length2 = 200;
float mass1 = 10;
float mass2 = 7;
float angle1 = PI/2;
float angle2 = 0;
float m1_velocity = 0;
float m2_velocity = 0;
float m1_acceleration = 0;
float m2_acceleration = 0;
float gravity = 9.8202437;
float drag = 0.9955;
float prevTime = 0;
float deltaTime = 0;
float timePast = 0;
PGraphics buffer;
float alpha = 0;

void setup()
{
  size(1080,1870);
  background(255);
  
  buffer = createGraphics(width, height);  
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
  stroke(0);
  strokeWeight(15);
  
  translate(width / 2, height / 2);                  
  
  if (timePast >= 100)
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
  ellipse(x1, y1, mass1 * 10, mass1 * 10);
  
  fill(255, 0, 255);
  ellipse(x2, y2, mass2 * 10, mass2 * 10); 
  
  buffer.beginDraw();
  buffer.translate(width / 2, height / 2); 
  buffer.noStroke();
  buffer.fill(0, 255, 0, 40);
  buffer.ellipse(x1, y1, mass1 * 10, mass1 * 10);
  buffer.fill(255, 0, 255, 40);
  buffer.ellipse(x2, y2, mass2 * 10, mass2 * 10);
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
                  
  buffer.background(255, 255, 255, alpha % 255);
  alpha += 0.05; // faderate
}

void mouseClicked()
{
  float mx = mouseX;
  float my = mouseY;
  
  m1_velocity += map(mx, 0, width / 2, -0.2, 0);
  m1_velocity += map(mx, width / 2, width, 0, 0.2);
  m2_velocity += map(my, 0, height / 2, -0.2, 0);
  m2_velocity += map(my, height / 2, height, 0, 0.2);
}

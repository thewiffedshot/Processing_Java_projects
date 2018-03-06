float deltaTime = 0;
float lastTime = 0;
ArrayList<Particle> particles = new ArrayList<Particle>();

void setup()
{
    size(1280, 720);
    background(200, 200, 200, 255);
}

void draw()
{
    deltaTime = (millis() - lastTime) / 1000f;

    background(200, 200, 200, 255);
    
    for (Particle particle : particles)
    {
        particle.UpdateState(deltaTime);
               
        fill(particle.GetFillColor());
        triangle(particle.GetPointA().x, particle.GetPointA().y, particle.GetPointB().x, particle.GetPointB().y, particle.GetPointC().x, particle.GetPointC().y);
    }
        
    lastTime = millis();
}

void mouseClicked()
{
    particles.add(new Particle(new PVector(mouseX, mouseY), new PVector(20000f, -100f), new PVector(0f, 50f), 0.8f, 0.75f, 20, color(0, 0, 160)));
}
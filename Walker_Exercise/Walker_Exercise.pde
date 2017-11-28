import java.util.*;
import java.lang.*;

ArrayList<Walker> pauls = new ArrayList();
ArrayList<Tree> trees = new ArrayList();

Walker paul;
Tree tree;

Random randy = new Random();

void setup()
{
    size(1280, 720);
    background(160, 160, 160);
    frameRate(60);
    
    paul = new Walker(new PVector(250, 0));
    tree = new Tree(new PVector(width / 2, height / 2), 64, 65f);
}

float walkDev = 5;
float distanceMean = 5;
float t = 0;
float yOff = 1337;

void draw()
{
    PVector paulVelocity = new PVector(1, 1);
    
    if (!(new Collision(tree.points, paul.hitbox, "Polygon", "Circle").check)) paul.Move(paulVelocity);
    
    paul.Display();
    tree.DrawTree();
    
    t += .01f;   
    /*for (Tree tree : trees)
    for(Walker paul : pauls)
    {        
        //println("---------------");
        //println(paul.location);
        //println("---------------");
        if (!(new Collision(tree.points, paul.hitbox, "Polygon", "Circle").check)) paul.Move(paulVelocity);
        //paul.location.x += map(noise(t), 0, 1, -50, 50); // MonteCarlo(-20, 20);
        //paul.location.y += map(noise(t + yOff), 0, 1, -50, 50); // MonteCarlo(-20, 20);
        
        paul.Display();
        tree.DrawTree();
        
        t += .01f;      
    } */   
}

float MonteCarlo(float minStep, float maxStep)
{
    while (true)
    {
      float r1 = random(minStep, maxStep);
    
      float probability = r1*r1;
    
      if (random(minStep, maxStep) <= probability) return r1;
    }
}

void mouseClicked()
{
    //if (mouseButton == LEFT) pauls.add(new Walker(new PVector(mouseX, mouseY)));
    //if (mouseButton == RIGHT) trees.add(new Tree(new PVector(mouseX, mouseY), 64, 65f));
}

/*float rand = random(1);
    
        if (paul.x <= 0 || paul.x >= width || paul.y <= 0 || paul.y >= height) paul.D = -1;

        if (sqrt(pow(paul.x - mouseX, 2) + pow(paul.y - mouseY, 2)) <= 15) paul.D = 1;
    
        if (rand <= 0.1f)
        {
            if (mouseX > paul.x)
            {//paul.x--; 
              paul.x -= paul.D * (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
            }
            else if (mouseX < paul.x) //paul.x++;
            { 
              paul.x += paul.D * (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);          
            }
            if (mouseY > paul.y) //paul.y--;
            {
              paul.y -= paul.D * (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
            }
            else if (mouseY < paul.y) //paul.y++;
            {
              paul.y += paul.D * (int)abs(walkDev *  (float) randy.nextGaussian() + distanceMean);
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
        }*/
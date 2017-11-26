class Collision
{   
    boolean check;
    
    int collisionType = 0; // 0 - (polygon / polygon); 1 - (circle / circle); 2 - (polygon / circle);
    
    // Data for circles.
    PVector[] centre = new PVector[2];
    float[] radius = new float[2];
    PVector[] circlePoints;
    PVector[] circleRays;
    
    // Data for polygons.
    PVector[] polyCentre = new PVector[2];
    PVector[][] polyPoints = new PVector[2][];
    PVector[][] vectors = new PVector[2][];
        
    Collision(PVector[] firstHitbox, PVector[] secondHitbox, String firstType, String secondType)
    {
        int polyCounter = 0, circleCounter = 0;
        ArrayList<String> detectedTypes = new ArrayList();
        
        switch (firstType)
        {
            case "Polygon":
            
                polyCentre[polyCounter] = firstHitbox[0];
                polyPoints[polyCounter] = new PVector[firstHitbox.length - 1];
                
                int i = 0;
                
                for (PVector point : firstHitbox)
                {
                    if (i != 0)
                    {
                        polyPoints[polyCounter][i - 1] = point;
                    }
                    
                    i++;
                }
                
                detectedTypes.add("Polygon");
                polyCounter++;
                
            break;
            
            case "Circle":
            
                centre[circleCounter] = firstHitbox[0];
                radius[circleCounter] = firstHitbox[1].x;
                
                detectedTypes.add("Circle");
                circleCounter++;
                
            break;
            
            default: throw new IllegalArgumentException("Such a collider type does not exist.");
        }
        
        switch (secondType)
        {
            case "Polygon": 
            
                polyCentre[polyCounter] = secondHitbox[0];
                polyPoints[polyCounter] = new PVector[secondHitbox.length - 1];
                
                int i = 0;
                
                for (PVector point : secondHitbox)
                {
                    if (i != 0)
                    {
                        polyPoints[polyCounter][i - 1] = point;
                    }
                    
                    i++;
                }
                
                detectedTypes.add("Polygon");
                polyCounter++;
                
            break;
            
            case "Circle":
            
                centre[circleCounter] = secondHitbox[0];
                radius[circleCounter] = secondHitbox[1].x;
                
                detectedTypes.add("Circle");
                circleCounter++;
                
            break;
            
            default: throw new IllegalArgumentException("Such a collider type does not exist.");
        }
        
        if (detectedTypes.contains("Polygon") && detectedTypes.contains("Circle"))
        {
            collisionType = 2;
            formulateVectors();
        }
        else if (detectedTypes.contains("Polygon"))
        {
            collisionType = 0;
            formulateVectors();
        }
        else if (detectedTypes.contains("Circle"))
            collisionType = 1;
        
        checkForCollision();
    }
    
    void formulateVectors()
    {
        if (collisionType == 2)
        {
            vectors[0] = new PVector[polyPoints[0].length - 1];
            
            for (int i = 0, u = 1; i < vectors[0].length; i++, u++)
            {
                vectors[0][i] = polyPoints[0][u].copy().sub(polyPoints[0][i]);
            }
        }
        else
        {
            vectors[0] = new PVector[polyPoints[0].length - 1];
            vectors[1] = new PVector[polyPoints[1].length - 1];
            
            for (int i = 0, u = 1; i < vectors[0].length; i++, u++)
            {
                vectors[0][i] = polyPoints[0][u].copy().sub(polyPoints[0][i]);
            }
            
            for (int i = 0, u = 1; i < vectors[1].length; i++, u++)
            {
                vectors[1][i] = polyPoints[1][u].copy().sub(polyPoints[1][i]);
            }
        }
    }
      
    void checkForCollision()
    {
        switch (collisionType)
        {
            case 0:
                
            break;
            
            case 1:
            
                GenerateCirclePoints(2f, 1);
                GenerateCirclePoints(2f, 2);
                
            break;
            
            case 2:
            
                GenerateCirclePoints(2f, 1);
                CastRays();
                
            break;
        }
    }
    
    void GenerateCirclePoints(float base, int circleInstance)
    {
        if (!(circleInstance == 1 || circleInstance == 2))
            throw new IllegalArgumentException("Circle instance must be either 1 or 2.");
        
        circleInstance--;
        
        float radianIncrement = asin(base / (2 * radius[circleInstance]));
        circlePoints = new PVector[ceil(2 * PI / radianIncrement)];
        
        for (int angle = 0, i = 0; angle < 2 * PI; angle += radianIncrement, i++)
        {
            circlePoints[i] = new PVector(centre[circleInstance].x + cos(angle) * radius[circleInstance], centre[circleInstance].y + sin(angle) * radius[circleInstance]);
        }
    }
    
    void CastRays()
    {
        switch (collisionType)
        {            
            case 2:
                      
                int i = 0;
                
                for (PVector point : circlePoints)
                {
                    if (point.x <= polyCentre[0].x)
                    {
                        circleRays[i] = new PVector(width - point.x, point.y);
                    }
                    else if (point.x > polyCentre[0].x)
                    {
                        circleRays[i] = new PVector(0 - point.x, point.y);
                    }
                    
                    i++;
                }
                
            break;
            
            default: println("WARNING: Function call is redundant.");
        }
    }
}
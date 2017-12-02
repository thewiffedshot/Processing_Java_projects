class Collision
{   
    boolean check;
    PVector closestIntersectPoint;
    
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
    PVector[][] vectorOrigins = new PVector[2][];
    
    private static final float Epsilon = 1e-5f;
        
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
                
                vectorOrigins[polyCounter] = new PVector[polyPoints[polyCounter].length - 1];
                
                for (int n = 0; n < polyPoints[polyCounter].length - 1; n++)
                {
                    vectorOrigins[polyCounter][n] = polyPoints[polyCounter][n]; 
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
            FormulateVectors();
        }
        else if (detectedTypes.contains("Polygon"))
        {
            collisionType = 0;
            FormulateVectors();
        }
        else if (detectedTypes.contains("Circle"))
            collisionType = 1;
        
        check = CheckForCollision();
    }
    
    private void FormulateVectors()
    {
        if (collisionType == 2)
        {
            vectors[0] = new PVector[polyPoints[0].length - 1];
            
            for (int i = 0, u = 1; i < vectors[0].length; i++, u++)
            {
                vectors[0][i] = polyPoints[0][u].copy().sub(polyPoints[0][i]);
            }
        }
        else if (collisionType == 0)
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
      
    private boolean CheckForCollision()
    {
        switch (collisionType)
        {
            case 0:
                return false;
            //break;
            
            case 1:
            
                GenerateCirclePoints(2f, 1);
                GenerateCirclePoints(2f, 2);
                
                return false;
                
            //break;
            
            case 2:
            
                GenerateCirclePoints(2f, 1);
                CastRays();
                
                int rayCounter = 0;
                int intersects = 0;
                
                //printArray(circleRays);
                
                for (PVector ray : circleRays)
                {
                    intersects = 0;
                    
                    PVector rayOrigin = circlePoints[rayCounter];
                    
                    float rayDotRay = ray.copy().dot(ray);
                    float segmentDotRay;
                    
                    PVector originsVector;
                    
                    float rayParameter = 0;
                    float segmentParameter = 0;
                    
                    float rayCrossSegment;
                    float originsCrossRay;
                    float originsCrossSegment;
                    
                    int segmentCounter = 0;
                    
                    //printArray(vectors[0]);
                    
                    for (PVector segment : vectors[0])
                    {
                        segmentDotRay = segment.copy().dot(ray);
                        
                        rayCrossSegment = (ray.x * segment.y) - (ray.y * segment.x);
                        originsVector = vectorOrigins[0][segmentCounter].copy().sub(rayOrigin);
                        originsCrossSegment = (originsVector.x * segment.y) - (originsVector.y * segment.x);
                        originsCrossRay = (originsVector.x * ray.y) - (originsVector.y * ray.x);
                        
                        rayParameter = originsCrossSegment / rayCrossSegment;
                        segmentParameter = originsCrossRay / rayCrossSegment;
                        
                        boolean collinear = IsZero(rayCrossSegment) && IsZero(originsCrossRay);
                        boolean intersect = !IsZero(rayCrossSegment) && (rayParameter >= 0 + Epsilon && rayParameter <= 1 - Epsilon) && (segmentParameter >= 0 + Epsilon && segmentParameter <= 1 - Epsilon); 
                        
                        float minMagnitude = new PVector(width, height).mag();
                        
                        if (collinear)
                        {
                            float firstParameter = originsVector.copy().dot(ray) / rayDotRay;
                            float secondParameter = firstParameter + ((segment.copy().dot(ray)) / rayDotRay);
                            
                            if (segmentDotRay >= 0 + Epsilon)
                            {
                                if ((firstParameter <= 0 - Epsilon && secondParameter >= 0 + Epsilon) || (firstParameter >= 0 + Epsilon && firstParameter <= 1 - Epsilon))
                                {
                                    intersects++;
                                    
                                    println("Collinear. +");
                                    // TODO: Store intersection point in an array...
                                }
                            }
                            else if ((secondParameter <= 0 - Epsilon && firstParameter >= 0 + Epsilon) || (secondParameter >= 0 + Epsilon && secondParameter <= 1 - Epsilon))
                            {
                                    intersects++;
                                    
                                    println("Collinear. -");
                                    //println("Intersect.");
                                    // TODO: Store intersection point in an array...
                            } 
                        }
                        else if (intersect)
                        {
                            if (segmentCounter != 0)
                            intersects++;
                            
                            println("----------");
                            println(segmentCounter);
                            println("----------");
                            //println(segmentParameter);
                            //println("Intersect.");                            
                            
                            PVector intersectPoint = rayOrigin.copy().add(ray.copy().mult(rayParameter));
                            
                            if (intersectPoint.mag() < minMagnitude) closestIntersectPoint  = intersectPoint;
                        }
                        
                        segmentCounter++;
                    }
                    
                    println("@@@@@@@@@@");
                    println(intersects);
                    println("@@@@@@@@@@");
                    
                    if (intersects % 2 != 0)
                    {                                               
                        return true;
                    }
                    
                    rayCounter++;
                }              
                                
            break;
        }
        
        return false;
    }
    
    private void GenerateCirclePoints(float base, int circleInstance)
    {
        if (!(circleInstance == 1 || circleInstance == 2))
            throw new IllegalArgumentException("Circle instance must be either 1 or 2.");
        
        circleInstance--;
        
        float radianIncrement = asin(base / (2 * radius[circleInstance]));
        circlePoints = new PVector[ceil(2 * PI / radianIncrement)];
        circleRays = new PVector[circlePoints.length];
        
        int i = 0;
        
        for (float angle = 0; angle < 2 * PI; angle += radianIncrement)
        {
            circlePoints[i] = new PVector(centre[circleInstance].x + cos(angle) * radius[circleInstance], centre[circleInstance].y - sin(angle) * radius[circleInstance]);
            
            i++;
        }
    }
    
    private void CastRays()
    {
        switch (collisionType)
        {            
            case 2:
                      
                int i = 0;
                
                for (PVector point : circlePoints)
                {
                    circleRays[i] = new PVector(width - point.x, 0);
                    
                    i++;
                }
                
            break;
            
            default: println("WARNING: Function call is redundant.");
        }
    }
    
    private boolean IsZero(float f)
    {
        final float Epsilon = 0.00001;
        
        return abs(f) < Epsilon;
    }
}
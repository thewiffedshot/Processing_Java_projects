class Collision
{   
    Object[] actorTypes = { new Tree(), new Walker() };
    
    Tree[] trees = new Tree[2];
    Walker[] walkers = new Walker[2];  
    
    // Data for circles.
    PVector centre1, centre2;
    float radius1, radius2;
    
    // Data for polygons.
    PVector polyCentre1, polyCentre2;
    PVector[] polyPoints1, polyPoints2;
        
    Collision(Object actor1, Object actor2)
    {
        checkActors(actor1, actor2);
        
        
    }
      
    void checkForCollision(String object1, String object2)
    {
        
    }
    
    void checkActors(Object _actor1, Object _actor2)
    {
        boolean firstActorExists = false, secondActorExists = false;
        
        for (Object object : actorTypes)
        {
            if (object.getClass().isInstance(_actor1))
            {
                firstActorExists = true;
            }
            
            if (object.getClass().isInstance(_actor2))
            {
                secondActorExists = true;
            }
        }
        
        if (!(firstActorExists && secondActorExists))
        {
            throw new RuntimeException("Specified type is not a valid actor.");
        }
    }
}
class TriVert
{
    private PVector position;
    ArrayList<TriVert> neighbors;
    
    public TriVert(PVector pos)
    {
        position = pos;
    }
    
    public PVector Position()
    {
        return position;
    }
    
    public void Draw(int radius)
    {
        color(255, 255, 0);
        ellipse(position.x, position.y, radius, radius);
        
        if(!neighbors.isEmpty())
        {
            for (TriVert vertex : neighbors)
            {
                vertex.Draw(radius);
            }
        }
    }
}
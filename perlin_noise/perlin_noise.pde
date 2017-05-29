public int gridResolution = 512; // Will be adjusted to be divisible by the subdivision value. 
public int gridSubdivision = 16;  // Value must be a power of 2.
 
public float steepness = 1f;
 
Grid grid;
 
void setup()
{
  size(513, 513, P2D);
  background(255);
  grid = new Grid(gridResolution, gridSubdivision);
  determinePicture();
}
 
void draw()
{
    
}
 
void determinePicture()
{
  float amp = 0;
  
  for (int y = 0; y < height; y++)
    for (int x = 0; x < width; x++)
    {    
      amp = grid.getAmplitude(x, y);
      color c = color(amp * 255f, amp * 0f, amp * 255f);//color(0f, 0f, amp, 255f);
      set(x, y, c);
    }
}
 
public class Grid
{
    public float steepnessCoefficient = steepness; // The closer it is to one, the steeper the terrain. Has to be greater than or equal to zero.
 
    private int resolution;
    private int subdivision;
    private int subdivisionInterval;
 
    private Point[] points;
 
    public Grid(int _resolution, int _subdivision)
    {
        if (log((float)(_subdivision)) / log(2f) % 1 != 0)
            throw new RuntimeException("Subdivision value MUST be a power of 2.");
 
        while (_resolution % _subdivision != 0)
        {
            _resolution++;
        }
 
        resolution = _resolution;
        subdivision = _subdivision;
        subdivisionInterval = resolution / subdivision;
 
        points = new Point[(int)pow(subdivision + 1, 2)];
 
        generatePoints();
    }
 
    private void generatePoints()
    {
        int n = 0;
 
        for (int i = 0; i <= subdivision; i++)
            for (int j = 0; j <= subdivision; j++)
            {
                points[n] = new Point(j * subdivisionInterval, i * subdivisionInterval);
                n++;
            }
    }
 
    public float getAmplitude(int x, int y)
    {
        float pointX = ((float)x / (float)subdivisionInterval) % 1f , pointY = ((float)y / (float)subdivisionInterval) % 1f;
 
        PVector[] distanceVectors = { new PVector(pointX, pointY), new PVector(pointX - 1, pointY), new PVector(pointX, pointY - 1), new PVector(pointX - 1, pointY - 1) };
 
        float value1 = 0, value2 = 0, value3 = 0, value4 = 0;
        float weighed1 = 0, weighed2 = 0;
        float amplitude = 0;
 
        ArrayList<Point> unitPoints = getUnitPoints(x, y);
 
        int n = 0;
 
        for (Point point : unitPoints)
        {
            switch (n)
            {
                case 0:
                    value1 = PVector.dot(point.GradientVector(), distanceVectors[0]);
                    break;
                case 1:
                    value2 = PVector.dot(point.GradientVector(), distanceVectors[1]);
                    break;
                case 2:
                    value3 = PVector.dot(point.GradientVector(), distanceVectors[2]);
                    break;
                case 3:
                    value4 = PVector.dot(point.GradientVector(), distanceVectors[3]);
                    break;
            }
 
            n++;
        }
 
        weighed1 = lerp(value1, value2, fadeValue(pointX));
        weighed2 = lerp(value3, value4, fadeValue(pointX));
 
        amplitude = lerp(weighed1, weighed2, fadeValue(pointY));
 
        return map(amplitude, -1f, 1f, 0f, 1f) * steepnessCoefficient; // Normalize amplitude to range from 0 to 1. (and apply steepness coefficient)
    }
 
    private float fadeValue(float value)
    {
        return 6 * pow(value, 5) - 15 * pow(value, 4) + 10 * pow(value, 3);
    }
 
    private ArrayList<Point> getUnitPoints(int x, int y)
    {
        int unitNumberX = (int)(x / subdivisionInterval), unitNumberY = (int)(y / subdivisionInterval);
        ArrayList<Point> unitPoints = new ArrayList<Point>();
 
        for (Point point : points)
        {
            if (point.X() == unitNumberX * subdivisionInterval && point.Y() == unitNumberY * subdivisionInterval)
            {
                unitPoints.add(point);
            }
            else if (point.X() == unitNumberX * subdivisionInterval + subdivisionInterval && point.Y() == unitNumberY * subdivisionInterval)
            {
                unitPoints.add(point);
            }
            else if (point.X() == unitNumberX * subdivisionInterval && point.Y() == unitNumberY * subdivisionInterval + subdivisionInterval)
            {
                unitPoints.add(point);
            }
            else if (point.X() == unitNumberX * subdivisionInterval + subdivisionInterval && point.Y() == unitNumberY * subdivisionInterval + subdivisionInterval)
            {
                unitPoints.add(point);
            }
        }
 
        return unitPoints;
    }
 
    //------------------------------ Property declarations ------------------------------
 
    public float getSteepnessCoefficient()
    {
      return steepnessCoefficient;
    }
    
    public void setSteepnessCoefficient(float steepness)
    {
      steepnessCoefficient = steepness;
    }
}
 
public class Point
{
    private PVector[] vectors = { new PVector(1, 1), new PVector(-1, 1), new PVector(1, -1), new PVector(-1, -1) };
    private PVector gradientVector;
 
    private int x, y;
 
    public Point(int _x, int _y)
    {
        x = _x;
        y = _y;
 
        gradientVector = vectors[(int)random(4)];
    }
 
    //------------------------------ Property declarations ------------------------------
 
    public int X()
    {
        return x;
    }
 
    public int Y()
    {
        return y;
    }
 
    public PVector GradientVector()
    {
        return gradientVector;
    }
}
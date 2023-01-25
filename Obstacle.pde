public class Obstacle
{
  private float x, y;
  private int size;
  private PImage image;
  private final String[] fileNames = {"tree.png"};

  public Obstacle(float tallest)
  {
    x = random(width*.3, width*.7);
    y = random(tallest, height*.7);
    size = (int)random(width/10, width/5);
    image = loadImage(fileNames[(int)random(0, fileNames.length)]);
    image.resize(size, size);
  }

  //Renders obstacle
  public void render()
  {
    noFill();
    stroke(0);
    strokeWeight(10);
    rect(x,y,size,size);
    image(image, x, y);
    noStroke();
  }

  //Checks if item hits obstacle
  public boolean isHit(float x, float y, float rad)
  {
    return x + rad > this.x - size/2 && x - rad < this.x + size/2 && y - rad < this.y + size/2 && y + rad > this.y - size/2;
  }
  
  public float getX()
  {
    return x;
  }

  public float getY()
  {
    return y;
  }
  
  public float getSize()
  {
    return size;
  }
}

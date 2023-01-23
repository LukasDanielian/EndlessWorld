public class Bullet
{
  private float x, y;
  private PVector speed;

  public Bullet(float x, float y, float endX, float endY)
  {
    this.x = x;
    this.y = y;
   
    speed = new PVector(endX-x, endY-y).normalize();
    speed.x *= 10;
    speed.y *= 10;
  }

  //Draws bullet and updates position
  public void render()
  {
    fill(255);
    circle(x, y, 10);

    x += speed.x;
    y += speed.y;
  }

  //Checks if bullet in bounds
  public boolean inBounds()
  {
    return x > 0 && x < width && y > 0 && y < height;
  }
  
  public float getX()
  {
    return x;
  }
  
  public float getY()
  {
    return y;
  }
}

public class Bullet
{
  private float x, y;
  private PVector speed;

  public Bullet(float x, float y)
  {
    this.x = x;
    this.y = y;
   
    speed = new PVector(mouseX-x, mouseY-y).normalize();
    speed.x *= 30;
    speed.y *= 30;
  }

  //Draws bullet and updates position
  public void render()
  {
    fill(0);
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

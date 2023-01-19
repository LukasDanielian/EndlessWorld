public class Enemy
{
  Weapon weapon;
  float x, y, xMover, yMover, size;
  boolean isMoving;
  int health;

  public Enemy()
  {
    weapon = new Pistol("Pistol", 25, 10, 10, "pistol.png");

    x = random(0, width);
    y = random(0, height);

    xMover = random(-5, 5);
    yMover = random(-5, 5);

    size = random(50, 100);
    health = 100;
  }

  //Renders enemy
  public void render()
  {
    weapon.render(x, y, player.getX(), player.getY());
    fill(255, 0, 0);
    circle(x, y, size);

    x += xMover;
    y += yMover;

    checkBounds();
  }

  //Bounces enemy
  private void checkBounds()
  {
    if (x > width || x < 0)
      xMover = -xMover;

    else if (y > height || y < 0)
      yMover = -yMover;
  }

  //checks if enemy is hit then applies damage
  public boolean applyDamage(float bX, float bY, int damage)
  {
    if (dist(bX, bY, x, y) <= size)
    {
      //Death
      if (health <= 0)
        return true;

      health -= damage;
    }

    return false;
  }
}

public class Enemy
{
  Weapon weapon;
  float x, y, xMover, yMover, size;
  int health;

  public Enemy()
  {
    weapon = new Pistol("Pistol", 25, 10, 50, "pistol.png");

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
    weapon.fire(x,y,player.getX(),player.getY());
    weapon.render(x, y, player.getX(), player.getY(),false);
    
    fill(255, 0, 0);
    circle(x, y, size);

    x += xMover;
    y += yMover;

    //Heath Bar
    fill(map(health, 100, 0, 175, 255), map(health, 100, 50, 255, 0), 0);
    rectMode(CORNER);
    rect(x-50, y-30, health, 15);
    noFill();
    stroke(0);
    strokeWeight(2);
    rect(x-50, y-30, 100, 15);
    rectMode(CENTER);

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
  public boolean isHit(float x2, float y2)
  {
    return dist(x2,y2,x,y) <= size;
  }
  
  public void applyDamage(int damage)
  {
    health -= damage;
  }
  
  //checks if enemy is dead
  public boolean isDead()
  {
    return health <= 0;
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

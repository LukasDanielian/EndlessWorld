public class Player
{
  private float x, y, px, py, size;
  private int mapRow, mapCol, health, level, xp;
  private Weapon weapon;
  private Cooldown grabWeapon;

  public Player()
  {
    x = width/2;
    y = height/2;
    px = x;
    py = y;
    size = 75;
    health = 100;
    xp = 0;
    level = 1;
    grabWeapon = new Cooldown(50);

    weapon = weaponFactory.getRandomWeapon();
  }

  //Renders Main Player
  public void render()
  {
    weapon.render(x, y, mouseX, mouseY, true);
    fill(255);
    circle(x, y, size);

    grabWeapon.run();
  }

  //Renders info related to player
  public void renderPlayerHUD()
  {
    weapon.renderIcon(width /2, height * .9, width/20, true);

    //Heath Bar
    textAlign(CENTER, TOP);
    fill(0);
    text("Health", width/2, 0);
    textAlign(CENTER, CENTER);
    fill(map(health, 100, 0, 175, 255), map(health, 100, 50, 255, 0), 0);
    rectMode(CORNER);
    rect(width/2-150, height * .05 -15, health * 3, 30, 50);
    rectMode(CENTER);
    noFill();
    stroke(0);
    strokeWeight(2);
    rect(width/2, height * .05, 300, 30, 50);

    //Level text
    textAlign(LEFT, TOP);
    fill(255);
    textSize(25);
    text("Level " + level, 0, 0);
    textAlign(CENTER, CENTER);

    //Level bar
    rectMode(CORNER);
    rect(0, height * .05 -15, xp, 30, 50);
    rectMode(CENTER);
    noFill();
    stroke(0);
    strokeWeight(2);
    rect(125, height * .05, 250, 30, 50);
  }

  //Updates players movement and other actions
  public void updateActions()
  {
    //Key options
    if (keyPressed)
    {
      px = x;
      py = y;

      //Movement
      if (keyDown('W'))
        y -= 5;
      if (keyDown('S'))
        y += 5;
      if (keyDown('A'))
        x -= 5;
      if (keyDown('D'))
        x += 5;

      //Other keys
      if (keyDown('R'))
        weapon.reload();
      if (keyDown('E'))
        pickUpWeapon();
    }

    //fires
    if (mousePressed && mouseButton == LEFT)
      weapon.fire(x, y, mouseX, mouseY, 30);

    //push back
    if (currentZone.didHitObstacle(x, y, size/2))
    {
      Obstacle closest = currentZone.getClosestObstacle(x, y);
      fill(255, 0, 0);
      float[] cords = pushOut(x - size/2, y - size/2, px - size/2, py - size/2, size, size, closest.getX() - closest.getSize()/2, closest.getY() - closest.getSize()/2, closest.getX() - closest.getSize()/2, closest.getY() - closest.getSize()/2, closest.getSize(), closest.getSize());

      x = cords[0] + size/2;
      y = cords[1] + size/2;
    }
  }

  //Picks up weapon if in range
  public void pickUpWeapon()
  {
    if (grabWeapon.canRun())
    {
      Weapon toDrop = weapon;
      Weapon toGrab = currentZone.getClosestWeapon(x, y, size * 2);

      if (toGrab != null)
      {
        weapon = toGrab;
        currentZone.dropWeapon(x, y+size, toDrop);
        grabWeapon.startCooldown();
      }
    }
  }

  //Checks if Player moves to new area
  public void checkBounds()
  {
    //Right
    if (x > width)
    {
      mapCol++;
      x = 0;
    }
    //Left
    else if (x < 0)
    {
      mapCol--;
      x = width;
    }
    //Left
    else if (y < 0)
    {
      mapRow--;
      y = height;
    }
    //Down
    else if (y > height)
    {
      mapRow++;
      y = 0;
    }
    //None
    else
      return;

    updateZone();
    miniMap.updateGrids();
  }

  //adds xp
  public void increaseXP(int amount)
  {
    xp += amount;

    if (xp >= 250)
    {
      xp %= 250;
      level++;
    }
  }

  //checks if player is hit then applies damage
  public boolean isHit(float x2, float y2)
  {
    return dist(x2, y2, x, y) <= size/2;
  }

  public void applyDamage(int damage)
  {
    health -= damage;
  }

  public boolean isDead()
  {
    return health <= 0;
  }

  public int getRow()
  {
    return mapRow;
  }

  public int getCol()
  {
    return mapCol;
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

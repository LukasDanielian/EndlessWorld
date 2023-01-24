public abstract class Weapon
{
  private String name;
  private int damage, rounds, magSize;
  private PImage icon;
  private ArrayList<Bullet> bullets;
  private Cooldown fireRate, reloadRate;

  public Weapon(String name, int damage, int rounds, int coolDown, int reload, PImage icon)
  {
    this.name = name;
    this.damage = damage;
    this.rounds = rounds;
    magSize = rounds;
    fireRate = new Cooldown(coolDown);
    reloadRate = new Cooldown(reload);
    this.icon = icon;
    bullets = new ArrayList<Bullet>();
  }

  //Checks all bullets in weapon
  public void render(float x, float y, float x2, float y2, boolean isPlayer)
  {
    //Bullets
    for (int i = 0; i < bullets.size() && i >= 0; i++)
    {
      Bullet temp = bullets.get(i);
      temp.render();

      //Remove missed shots
      if (!temp.inBounds())
      {
        bullets.remove(temp);
        i--;
      }

      //Go through enemys
      else
      {
        //Check if bullets hit obstacles
        ArrayList<Obstacle> obstacles = currentZone.getObstacles();
        boolean shouldRun = true;
        
        for(int j = 0; j < obstacles.size(); j++)
        {
          if(obstacles.get(j).isHit(temp.getX(),temp.getY(), 10))
          {
            bullets.remove(temp);
            i--;
            j = obstacles.size();
            shouldRun = false;
          }
        }
        
        //player shooting at enemys
        if (isPlayer && shouldRun)
        {
          ArrayList<Enemy> enemys = currentZone.getEnemys();

          for (int j = 0; j < enemys.size(); j++)
          {
            Enemy e = enemys.get(j);

            //if hits enemy
            if (e.isHit(temp.getX(), temp.getY()))
            {
              e.applyDamage(damage);
              bullets.remove(temp);
              i--;

              //enemy dies
              if (e.isDead())
              {
                player.increaseXP(e.getXP());
                //random chance at dropping weapon
                if ((int)random(0, 5) == 0)
                  currentZone.dropWeapon(e.getX(), e.getY());

                enemys.remove(j);
                j--;
              }
            }
          }
        }

        //Enemys shooting at player
        else if (player.isHit(temp.getX(), temp.getY()) && shouldRun)
        {
          player.applyDamage(damage);
          bullets.remove(temp);
          i--;
        }
      }
    }

    fireRate.run();
    reloadRate.run();
  }

  //Fires bullet
  public void fire(float x, float y, float x2, float y2, float vel)
  {
    if (reloadRate.canRun() && fireRate.canRun() && rounds > 0)
    {
      bullets.add(new Bullet(x, y, x2, y2, vel));
      rounds--;
      fireRate.startCooldown();
    }
  }

  //reloads gun
  public void reload()
  {
    if (reloadRate.canRun() && rounds < magSize)
    {
      rounds = magSize;
      reloadRate.startCooldown();
    }
  }

  //Player current Weapon Icon
  public void renderIcon(float x, float y, int size, boolean isHolding)
  {
    pushMatrix();
    translate(x, y);

    //Owns gun
    if (isHolding)
    {
      //Reload animation
      if (!reloadRate.canRun())
      {
        fill(0);
        text("Reloading...", 0, -height/8);
        fill(255, 0, 0);
        arc(0, 0, width/12.5, width/12.5, -HALF_PI, map(reloadRate.getTracker(), 0, reloadRate.getFrames(), -HALF_PI, PI+HALF_PI), PIE);
      }

      fill(0);
      stroke(255);
      strokeWeight(5);
      circle(0, 0, width/15);
      textSize(25);
      fill(0);
      text(name, 0, size * .95);
      text(rounds + "/" + magSize, 0, -size * .95);
      noStroke();
    }

    //On ground
    else
      rotate(-frameCount * .01);

    icon.resize(size, size);
    image(icon, 0, 0);
    popMatrix();
  }
}

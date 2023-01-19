public abstract class Weapon
{
  private String name;
  private int damage, rounds, magSize, reload;
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
    for (int i = 0; i < bullets.size(); i++)
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
        //player shooting at enemys
        if (isPlayer)
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
                //random chance at dropping weapon
                if ((int)random(0, 1) == 0)
                  currentZone.dropWeapon(e.getX(), e.getY());

                enemys.remove(j);
                j--;
              }
            }
          }
        }

        //Enemys shooting at player
        else if (player.isHit(temp.getX(), temp.getY()))
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
  public void fire(float x, float y, float x2, float y2)
  {
    if (reloadRate.canRun() && fireRate.canRun() && rounds > 0)
    {
      bullets.add(new Bullet(x, y, x2, y2));
      rounds--;
      fireRate.startCooldown();
    }
  }

  //reloads gun
  public void reload()
  {
    if (reloadRate.canRun())
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
      fill(0);
      stroke(255);
      strokeWeight(5);
      circle(0, 0, width/15);
      textSize(25);
      fill(0);
      text(name, 0, size * .9);
      text(rounds + "/" + magSize, 0, -size * .9);
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

public class Pistol extends Weapon
{
  private ArrayList<Bullet> bullets;
  private int tempTimer;

  public Pistol(String n, int d, int r, int c, String i)
  {
    super(n, d, r, c, loadImage(i));
    bullets = new ArrayList<Bullet>();
  }

  //Renders all aspect of pistol
  public void render(float x, float y, float x2, float y2, boolean isPlayer)
  {
    //Pistol display
    pushMatrix();
    translate(x, y);
    rotate(atan2(y2 - y, x2 - x));
    fill(0);
    rect(50, 0, 30, 10);
    popMatrix();

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

            if (e.isHit(temp.getX(), temp.getY()))
            {
              e.applyDamage(super.damage);
              bullets.remove(temp);
              i--;

              if (e.isDead())
              {
                enemys.remove(j);
                j--;
              }
            }
          }
        }

        //Enemys shooting at player
        else
        {
          if (player.isHit(temp.getX(), temp.getY()))
          {
            player.applyDamage(super.damage);
            bullets.remove(temp);
            i--;
          }
        }
      }
    }

    //bullet fire rate
    if (super.onCoolDown)
    {
      tempTimer--;

      if (tempTimer < 0)
      {
        super.onCoolDown = false;
        tempTimer = super.coolDown;
      }
    }
  }

  //Fires bullet
  public void fire(float x, float y, float endX, float endY)
  {
    if (!super.onCoolDown && super.rounds > 0)
    {
      bullets.add(new Bullet(x, y, endX, endY));
      super.rounds--;
      super.onCoolDown = true;
    }
  }
}

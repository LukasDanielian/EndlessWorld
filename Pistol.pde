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
  public void render(float x, float y, float x2, float y2)
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
        ArrayList<Enemy> enemys = currentZone.getEnemys();

        for (int j = 0; j < enemys.size(); j++)
        {
          if(enemys.get(j).applyDamage(temp.getX(), temp.getY(), super.damage))
          {
            enemys.remove(j);
            bullets.remove(i);
            j--;
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
        super.onCoolDown = false;
    }
  }

  //Fires bullet
  public void fire()
  {
    if (!super.onCoolDown && super.rounds > 0)
    {
      bullets.add(new Bullet(player.getX(), player.getY()));
      super.rounds--;
      super.onCoolDown = true;
      tempTimer = super.coolDown;
    }
  }
}

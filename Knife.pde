public class Knife extends Weapon
{
  public Knife(String name, int damage, int rounds, int coolDown, int reload, String i)
  {
    super(name, damage, rounds, coolDown, reload, loadImage(i));
  }

  //Renders all aspect of Knife
  public void render(float x, float y, float x2, float y2, boolean isPlayer)
  {
    float knifeAngle = 0;

    super.fireRate.run();
    
    //Knife stab rate
    if (!super.fireRate.canRun())
      knifeAngle = map(super.fireRate.getTracker(), super.fireRate.getFrames(), 0, PI/3, -PI/3);

    //Knife display
    pushMatrix();
    translate(x, y);
    rotate(atan2(y2 - y, x2 - x) + knifeAngle);
    fill(#2C1C08);
    rect(10, 0, 90, 5);
    fill(#A2A2A2);
    triangle(90, 5, 50, -5, 50, 5);
    popMatrix();
  }

  //Stabs knife
  public void fire(float x, float y, float x2, float y2, float vel)
  {
    if (super.fireRate.canRun() && super.rounds > 0)
    {
      super.fireRate.startCooldown();

      ArrayList<Enemy> enemys = currentZone.getEnemys();

      //Check all enemies
      for (int i = 0; i < enemys.size(); i++)
      {
        Enemy e = enemys.get(i);
        float lookAngle = atan2(y2 - y, x2 - x);
        float enemyAngle = atan2(e.getY() - y, e.getX() - x);

        //check if hit
        if (dist(x, y, e.getX(), e.getY()) < player.getSize() * 2 && enemyAngle > lookAngle - PI/3 && enemyAngle < lookAngle + PI/3)
          e.applyDamage(super.damage);

        //check if dead
        if (e.isDead())
        {
          player.increaseXP(e.getXP());
          currentZone.dropWeapon(e.getX(), e.getY());
          enemys.remove(e);
          i--;
        }
      }
    }
  }
}

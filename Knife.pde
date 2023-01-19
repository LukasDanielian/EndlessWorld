public class Knife extends Weapon
{
  private int tempTimer;
  
  public Knife(String n, int d, int r, int c, String i)
  {
    super(n, d, r, c, loadImage(i));
  }
  
  //Renders all aspect of Knife
  public void render(float x, float y, float x2, float y2)
  {
    float knifeAngle = 0;
    
    //Knife stab rate
    if(super.onCoolDown)
    {
      knifeAngle = map(tempTimer, super.coolDown, 0, PI/3,-PI/3);
      
      tempTimer--;
      
      if(tempTimer < 0)
        super.onCoolDown = false;
    }
    
    //Knife display
    pushMatrix();
    translate(x, y);
    rotate(atan2(y2 - y, x2 - x) + knifeAngle);
    fill(#2C1C08);
    rect(10,0,90,5);
    fill(#A2A2A2);
    triangle(90,5,50,-5,50,5);
    popMatrix();
  }

  //Stabs knife
  public void fire()
  {
    if (!super.onCoolDown && super.rounds > 0)
    {
      super.onCoolDown = true;
      tempTimer = super.coolDown;
    }
  }
}

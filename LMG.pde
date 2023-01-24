public class LMG extends Weapon
{
  public LMG(String name, int damage, int rounds, int coolDown, int reload, String i)
  {
    super(name, damage, rounds, coolDown, reload, loadImage(i));
  }

  //Renders all aspect of pistol
  public void render(float x, float y, float x2, float y2, boolean isPlayer)
  {
    super.render(x,y,x2,y2,isPlayer);
    
    //LMG display
    pushMatrix();
    translate(x, y);
    rotate(atan2(y2 - y, x2 - x));
    fill(#8B8B8B);
    rect(50, 0, 100, 10);
    rect(50,0,30,30);
    popMatrix();
  }
}

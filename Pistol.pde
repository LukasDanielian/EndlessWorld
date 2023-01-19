public class Pistol extends Weapon
{
  public Pistol(String name, int damage, int rounds, int coolDown, int reload, String i)
  {
    super(name, damage, rounds, coolDown, reload, loadImage(i));
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
    
    super.render(x,y,x2,y2,isPlayer);
  }
}

public abstract class Weapon
{
  private String name;
  private int damage, rounds, coolDown, magSize;
  private boolean onCoolDown;
  private PImage icon;

  public Weapon(String name, int damage, int rounds, int coolDown, PImage icon)
  {
    this.name = name;
    this.damage = damage;
    this.rounds = rounds;
    magSize = rounds;
    this.coolDown = coolDown;
    onCoolDown = false;
    this.icon = icon;
  }

  public void render(float x, float y, float x2, float y2) {
  }

  public void fire() {
  }

  public void reload()
  {
    rounds = magSize;
  }

  //Player current Weapon Icon
  public void renderIcon(float x, float y, int size, boolean isHolding)
  {
    pushMatrix();
    translate(x,y);
    
    //Owns gun
    if (isHolding)
    {
      fill(0);
      stroke(255);
      strokeWeight(5);
      circle(0, 0, width/15);
      noStroke();
    }
    else
      rotate(-frameCount * .01);
    
    icon.resize(size,size);
    image(icon,0,0);
    popMatrix();
    
    textSize(25);
    text(name, width/2, height * .975);
    text(rounds + "/" + magSize, width/2, height * .8);
  }
}

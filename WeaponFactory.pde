public class WeaponFactory
{
  private final String[] names = {"Knife", "Pistol"};
  private final int[] damages = {30, 15};
  private final int[] rounds = {1, 10};
  private final int[] coolDowns = {15, 15};
  private final int[] reload = {0, 100};
  private final String[] images = {"knife.png", "pistol.png"};

  //Returns a random weapon
  public Weapon getRandomWeapon()
  {
    int num = (int)random(0, names.length);

    if (num == 0)
      return new Knife(names[num], damages[num], rounds[num], coolDowns[num], reload[num], images[num]);

    else if (num == 1)
      return new Pistol(names[num], damages[num], rounds[num], coolDowns[num], reload[num], images[num]);
      
    return null;
  }
}

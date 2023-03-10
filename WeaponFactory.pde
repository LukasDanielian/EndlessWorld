public class WeaponFactory
{
  private final String[] names = {"Knife", "Pistol", "LMG", "Sniper"};
  private final int[] damages = {30, 15, 10, 100};
  private final int[] rounds = {1, 10, 50, 4};
  private final int[] coolDowns = {15, 15, 10, 50};
  private final int[] reload = {1, 100, 500, 250};
  private final String[] images = {"knife.png", "pistol.png", "lmg.png", "sniper.png"};

  //Returns a random weapon
  public Weapon getRandomWeapon()
  {
    int num = (int)random(0, names.length);

    if (num == 0)
      return new Knife(names[num], damages[num], rounds[num], coolDowns[num], reload[num], images[num]);

    else if (num == 1)
      return new Pistol(names[num], damages[num], rounds[num], coolDowns[num], reload[num], images[num]);

    else if (num == 2)
      return new LMG(names[num], damages[num], rounds[num], coolDowns[num], reload[num], images[num]);

    else if (num == 3)
      return new Sniper(names[num], damages[num], rounds[num], coolDowns[num], reload[num], images[num]);
      
    return null;
  }
}

public class Zone
{
  private int type;
  private int backColor;
  private ArrayList<Enemy> enemys;
  private HashMap<String,Weapon> weapons;
  
  public Zone()
  {
    type = (int)random(0,3);
    enemys = new ArrayList<Enemy>();
    weapons = new HashMap<String,Weapon>();
    
    enemys.add(new Enemy());
    weapons.put(getCords((int)random(0,width),(int)random(0,height)),weaponFactory.getRandomWeapon());
    
    //Type One
    if(type == 0)
    {
      backColor = #233E1E;
    }
    
    //Type Two
    else if(type == 1)
    {
      backColor = #392B19;
    }
    
    //Type Three
    else if(type == 2)
    {
      backColor = #363533;
    }
  }
  
  //Renders zone based on type
  public void render()
  {
    background(backColor);
    
    //Render all enemys
    for(int i = 0; i < enemys.size(); i++)
      enemys.get(i).render();
      
    //Renders weapons 
    for(String keyGrab: weapons.keySet())
    {
      String[] loc = keyGrab.split("x");
      weapons.get(keyGrab).renderIcon(float(loc[0]),float(loc[1]),width/30,false);
    }
  }
  
  //drops random
  public void dropWeapon(float x, float y)
  {
    weapons.put(getCords((int)x,(int)y),weaponFactory.getRandomWeapon());
  }
  
  //drops weapon 
  public void dropWeapon(float x, float y, Weapon weapon)
  {
    weapons.put(getCords((int)x,(int)y),weapon);
  }
  
  //Returns the closest weapon to x y
  public Weapon getClosestWeapon(float x, float y, float range)
  {
    float dist = range;
    Weapon toRet = null;
    String toRem = "";
    
    //goes through weapons
    for(String keyGrab: weapons.keySet())
    {
      String[] loc = keyGrab.split("x");
      float tempDist = dist(x,y,float(loc[0]),float(loc[1]));
      
      //sets closest
      if(tempDist < dist)
      {
        dist = tempDist;
        toRet = weapons.get(keyGrab);
        toRem = keyGrab;
      }
    }
    
    weapons.remove(toRem);
    return toRet;
  }
  
  public int getColor()
  {
    return backColor;
  }
  
  public ArrayList<Enemy> getEnemys()
  {
    return enemys;
  }
}

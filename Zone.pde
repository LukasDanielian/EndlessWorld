public class Zone
{
  private int type;
  private int backColor;
  private ArrayList<Enemy> enemys;
  
  public Zone()
  {
    type = (int)random(0,3);
    enemys = new ArrayList<Enemy>();
    
    enemys.add(new Enemy());
    
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

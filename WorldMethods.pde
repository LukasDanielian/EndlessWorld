//Grabs Zones and adds newly discovered ones
public void updateZone()
{
  String loc = getCords(player.getRow(),player.getCol());
  currentZone = world.get(loc);
  
  //Makes new Zone
  if(currentZone == null)
  {
    currentZone = new Zone();
    world.put(loc,currentZone);
  }
}

//Gets cords in string form
public String getCords(int row, int col)
{
  return row + "x" + col;
}

public class Player
{
  private float x, y;
  private int mapRow, mapCol;
  private Weapon weapon;

  public Player()
  {
    x = width/2;
    y = height/2;
    
    weapon = new Knife("Knife", 50, 1, 15, "knife.png");
    weapon = new Pistol("Pistol", 25, 10,10, "pistol.png");
  }

  //Renders Main Player
  public void render()
  {
    weapon.render(x,y,mouseX,mouseY);
    fill(0,255,0);
    circle(x,y,75);
  }
  
  //Renders info related to player
  public void renderPlayerHUD()
  {
    weapon.renderIcon(width / 2,height * .9,width/20,true);
  }

  //Updates players movement and other actions
  public void updateMovement()
  {
    if (keyPressed)
    {
      //Movement
      if (keyDown('W'))
        y -= 5;
      if (keyDown('S'))
        y += 5;
      if (keyDown('A'))
        x -= 5;
      if (keyDown('D'))
        x += 5;
        
      //Other keys
      if(keyDown('R'))
        weapon.reload();
    }
  }

  //Checks if Player moves to new area
  public void checkBounds()
  {
    //Right
    if (x > width)
    {
      mapCol++;
      x = 0;
    }
    //Left
    else if (x < 0)
    {
      mapCol--;
      x = width;
    }
    //Left
    else if (y < 0)
    {
      mapRow--;
      y = height;
    }
    //Down
    else if (y > height)
    {
      mapRow++;
      y = 0;
    }
    //None
    else
      return;

    updateZone();
    miniMap.updateGrids();
  }
  
  //Fires weapon
  public void attack()
  {
    weapon.fire();
  }

  public int getRow()
  {
    return mapRow;
  }

  public int getCol()
  {
    return mapCol;
  }
  
  public float getX()
  {
    return x;
  }

  public float getY()
  {
    return y;
  }
}

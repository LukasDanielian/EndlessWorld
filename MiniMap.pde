public class MiniMap
{
  private Zone[][] areaNearby;
  private final int[] vertDisp = {-1,-1,-1,0,1,1,1,0};
  private final int[] horzDisp = {-1,0,1,1,1,0,-1,-1};
  private float x,y,w,h;
  
  public MiniMap()
  {
    areaNearby = new Zone[3][3];
    
    w = (width/20) * 3;
    h = (height/20) * 3;
    x = width - w/2 - w/10;
    y = h/2 + w/10;
  }
  
  //Updates zones around player
  public void updateGrids()
  {
    //Current zone
    areaNearby[1][1] = currentZone;
    
    //Zones around
    for(int i = 0; i < vertDisp.length; i++)
      areaNearby[1 + vertDisp[i]][1 + horzDisp[i]] = world.get(getCords(player.getRow() + vertDisp[i], player.getCol() + horzDisp[i]));
  }
  
  //Renders mini map
  public void render()
  {
    //Background of mini map
    fill(0);
    rect(x,y,w,h);
    
    //Inner boxes
    float tempX;
    float tempY = y - h/3;
    for(int row = 0; row < areaNearby.length; row++)
    {
      tempX = x - w/3;
      for(int col = 0; col < areaNearby.length; col++)
      {
        Zone temp = areaNearby[row][col];
        
        //Render box if already found
        if(temp != null)
        {
          fill(temp.getColor());
          rect(tempX,tempY,w/3,h/3);
        }
        tempX += w/3;
      }
      tempY += h/3;
    }
    
    //Outer box
    noFill();
    stroke(255);
    strokeWeight(10);
    rect(x,y,w,h);
    noStroke();
    
    //Render mini Player
    fill(255);
    circle(map(player.getX(),0,width,x-w/6,x+w/6),map(player.getY(),0,height,y-h/6,y+h/6),5);
  }
}

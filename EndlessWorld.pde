Player player;
Zone currentZone;
MiniMap miniMap;
HashMap<String, Zone> world;
boolean[] keys;

public void setup()
{
  //Settings
  fullScreen();
  frameRate(60);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER,CENTER);

  //Variable declaration
  player = new Player();
  currentZone = new Zone();
  miniMap = new MiniMap();
  world = new HashMap<String, Zone>();
  keys = new boolean[256];
  
  //Setup
  world.put(getCords(0,0),currentZone);
  miniMap.updateGrids();
}

public void draw()
{
  //Zone Render
  currentZone.render();
  
  //Player Render
  player.render();
  player.updateMovement();
  player.checkBounds();
  
  //Hud Render
  player.renderPlayerHUD();
  miniMap.render();
}

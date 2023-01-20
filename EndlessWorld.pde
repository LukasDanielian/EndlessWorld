Player player;
Zone currentZone;
MiniMap miniMap;
HashMap<String, Zone> world;
boolean[] keys;
boolean isDead;
WeaponFactory weaponFactory;

public void setup()
{
  //Settings
  fullScreen();
  frameRate(60);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  //Variable declaration
  weaponFactory = new WeaponFactory();
  player = new Player();
  currentZone = new Zone();
  miniMap = new MiniMap();
  world = new HashMap<String, Zone>();
  keys = new boolean[256];
  isDead = false;

  //Setup
  world.put(getCords(0, 0), currentZone);
  miniMap.updateGrids();
}

public void draw()
{
  //Alive
  if (!isDead)
  {
    //Zone Render
    currentZone.render();

    //Player Render
    player.render();
    player.updateMovement();
    player.checkBounds();
    if (player.isDead())
      isDead = true;

    //Hud Render
    player.renderPlayerHUD();
    miniMap.render();
  }
  
  //Dead
  else
  {
    background(0);
    textSize(100);
    text("DEAD\nR: Restart", width/2, height/2);
    
    if(keyPressed && keyDown('R'))
      setup();
  }
}

//Key down
public void keyPressed()
{
  if (keyCode >= 0 && keyCode < 256)
    keys[keyCode] = true;
}

//Key up
public void keyReleased() 
{
  if (keyCode >= 0 && keyCode < 256)
    keys[keyCode] = false;
}

//Grabs key
public boolean keyDown(int key) 
{
  return keys[key];
}

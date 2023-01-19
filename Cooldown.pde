public class Cooldown
{
  private float frames;
  private float tracker;
  private boolean canRun;
  
  public Cooldown(float frames)
  {
    this.frames = frames;
    tracker = frames;
    canRun = true;
  }
  
  //runs cooldown
  public void run()
  {
    if(!canRun)
    {
      tracker--;
      
      if (tracker < 0)
      {
        canRun = true;
        tracker = frames;
      }
    }
  }
  
  public void startCooldown()
  {
    canRun = false;
  }
  
  public boolean canRun()
  {
    return canRun;
  }
  
  public float getTracker()
  {
    return tracker;
  }
  
  public float getFrames()
  {
    return frames;
  }
}

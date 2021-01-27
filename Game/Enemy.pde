class Enemy
{
  int health;
  PVector pos;
  PVector vel;
  int timer=0;
  boolean hurt=false;
  boolean attacking=false;
  boolean dead=false;
  boolean damaged=false;
  boolean ducking;
  int attack_frame=0;
  int walk_frame=0;
  int dead_frame=0;
  int enemy_width;
  Enemy(int health,PVector pos, PVector vel, int enemy_width)
  {
    this.pos=pos;
    this.vel=vel;
    this.health=health;
    this.enemy_width=enemy_width;
  }
  void addTimer()
  {
    this.timer++;
    if (this.timer>=60)
    {
      this.timer=0;
    }
  }
  void move()
  {
    this.pos.x+=this.vel.x;
  }
 
  void checkDeath()
  {
    if (this.health<=0)
    {
      dead=true;
      attacking=false;
    }
  }
  void update()
  {
    imageMode(CENTER);
    drawMe();
    checkDeath();
    move();
    updateTimer();
    imageMode(CORNER);
  }
  void drawMe()
  {
    ellipse(this.pos.x,this.pos.y,250,250);
  }
  void updateTimer()
  {
    this.timer++;
    
    if (this.timer>=120)
    {
      this.timer=0;
      
    }
    
  }
  void take_damage()
  {
    this.health-=1;
  }
  void checkDamage(float Player_X)
  {
    
  }
  boolean isdodging()
  {
    return false;
  }
}
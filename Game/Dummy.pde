class Dummy extends Enemy
{
  //wooden dummy's animations
  PImage dummy_attack_1=loadImage("photos/enemy_dummy_attack_1.png");
  PImage dummy_attack_2=loadImage("photos/enemy_dummy_attack_2.png");
  PImage dummy_attack_3=loadImage("photos/enemy_dummy_attack_3.png");
  PImage dummy_attack_4=loadImage("photos/enemy_dummy_attack_4.png");
  PImage dummy_attack_5=loadImage("photos/enemy_dummy_attack_5.png");
  PImage dummy_attack_6=loadImage("photos/enemy_dummy_attack_6.png");
  PImage dummy_attack_7=loadImage("photos/enemy_dummy_attack_7.png");
  PImage dummy_attack_8=loadImage("photos/enemy_dummy_attack_8.png");
  
  PImage dummy_death_1=loadImage("photos/enemy_dummy_death_1.png");
  PImage dummy_death_2=loadImage("photos/enemy_dummy_death_2.png");
  PImage dummy_death_3=loadImage("photos/enemy_dummy_death_3.png");
  
  ArrayList<PImage> attack_frames=new ArrayList<PImage>();
  ArrayList<PImage> death_frames=new ArrayList<PImage>();
  
  
  
  
  
  
  
  Dummy(int health,PVector pos, PVector vel,int enemy_width)
  {
    super(health,pos,vel,enemy_width);
    attack_frames.add(dummy_attack_7);
    attack_frames.add(dummy_attack_8);
    attack_frames.add(dummy_attack_1);
    attack_frames.add(dummy_attack_2);
    attack_frames.add(dummy_attack_3);
    attack_frames.add(dummy_attack_4);
    attack_frames.add(dummy_attack_5);
    attack_frames.add(dummy_attack_6);
    death_frames.add(dummy_attack_1);
    death_frames.add(dummy_death_1);
    death_frames.add(dummy_death_2);
    death_frames.add(dummy_death_3);
    
  }
  
  void drawMe()
  {
    PImage currImage;
    
    if (this.attacking==true)
    {
      currImage=attack_frames.get(attack_frame);
      image(currImage,this.pos.x,this.pos.y);
    }
    else if (this.dead==true)
    {
      if (this.dead_frame==0)
      {
        totem_death.play();
        totem_death.rewind();
      }
      currImage=death_frames.get(this.dead_frame);
      image(currImage,this.pos.x,this.pos.y); 
      if(timer%3==0)
      {
        this.dead_frame++;
      }
      if (this.dead_frame>=4)
      {
        enemies.remove(this);
      }
    }
    else 
    {
      currImage=dummy_attack_7;
      image(currImage,this.pos.x,this.pos.y);
    }
  }
  void attack()
  {
    if (this.timer%3==0)
    {
      attack_frame++;
      
      if (attack_frame==3)
      {
        checkDamage();
      }
      if (attack_frame>=7)
      {
        
        attack_frame=0;
        attacking=false;
      }
      
    }
    
  }
  
  
  void update()
  {
    imageMode(CENTER);
    
    if (attacking==false&& this.timer%60==0&&this.dead==false)
    {
      attacking=true;
    }
    if (attacking==true&&this.dead==false)
    {
      attack();
    }
    drawMe();
    checkDeath();
    move();
    updateTimer();
    imageMode(CORNER);
    
  }
  void checkDamage()
  {
    if (this.pos.x-100<=Player.pos.x+78)
    {
      if (Player.damaged==false&&Player.ducking==false)
      {
        Player.takeDamage();
        
      }
    }
  }
  void take_damage()
  {
    this.health-=1;
    wood_chop.play();
    wood_chop.rewind();
  }
  
}
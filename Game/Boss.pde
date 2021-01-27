class Boss extends Enemy
{
  // various variables to track the boss' animations
  int attack_frame=0;
  int walk_frame=0;
  int death_frame=0;
  String direction;
  
  // various 'statuses'
  boolean walking=false;
  boolean attacking=false;
  boolean injured=false;
  boolean ducking=false;
  boolean exhausted=false;
  
  //tracks boss' stats as the battle keeps going
  int duckingTimer=0;
  int damagedTimer=0;
  int exhaustionTimer=0;
  int health=30;
  int death_timer=0;
  
  //boss animations
  PImage boss_attack_1=loadImage("photos/boss_attack_1.png");
  PImage boss_attack_2=loadImage("photos/boss_attack_2.png");
  PImage boss_attack_3=loadImage("photos/boss_attack_3.png");
  PImage boss_attack_4=loadImage("photos/boss_attack_4.png");
  PImage boss_attack_5=loadImage("photos/boss_attack_5.png");
  PImage boss_attack_6=loadImage("photos/boss_attack_6.png");
  PImage boss_attack_7=loadImage("photos/boss_attack_7.png");
  
  PImage boss_debug=loadImage("photos/boss_debug.png");
  
  PImage boss_walk_1=loadImage("photos/boss_walk_1.png");
  PImage boss_walk_2=loadImage("photos/boss_walk_2.png");
  PImage boss_walk_3=loadImage("photos/boss_walk_3.png");
  
  PImage boss_dead_1=loadImage("photos/boss_dead_1.png");
  PImage boss_dead_2=loadImage("photos/boss_dead_2.png");
  PImage boss_dead_3=loadImage("photos/boss_dead_3.png");
  PImage boss_dead_4=loadImage("photos/boss_dead_4.png");
  PImage boss_dead_5=loadImage("photos/boss_dead_5.png");
  PImage boss_dead_6=loadImage("photos/boss_dead_6.png");
  PImage boss_dead_7=loadImage("photos/boss_dead_7.png");
  
  PImage boss_duck=loadImage("photos/boss_duck.png");
  ArrayList<PImage> attack_frames=new ArrayList<PImage>();
  ArrayList<PImage> walk_frames=new ArrayList<PImage>();
  ArrayList<PImage> death_frames=new ArrayList<PImage>();
  boolean hasWon = false;
  Boss(int health,PVector pos, PVector vel,int width)
  {
    super(health,pos,vel,width);
    attack_frames.add(boss_attack_1);
    attack_frames.add(boss_attack_2);
    attack_frames.add(boss_attack_3);
    attack_frames.add(boss_attack_4);
    attack_frames.add(boss_attack_4);
    attack_frames.add(boss_attack_4);
    attack_frames.add(boss_attack_4);
    attack_frames.add(boss_attack_5);
    attack_frames.add(boss_attack_6);
    attack_frames.add(boss_attack_7);
    
    walk_frames.add(boss_walk_1);
    walk_frames.add(boss_walk_2);
    walk_frames.add(boss_walk_3);
    
    death_frames.add(boss_dead_1);
    death_frames.add(boss_dead_2);
    death_frames.add(boss_dead_3);
    death_frames.add(boss_dead_4);
    death_frames.add(boss_dead_5);
    death_frames.add(boss_dead_6);
    death_frames.add(boss_dead_7);
  }
  void attack()
  {
    int attackspeed=3;
    if (health<10)
    {
       attackspeed=1;
       
    }
    
    else if (health<20)
    {
       attackspeed=2;
       
    }
    else if (health<30)
    {
       attackspeed=3;
       
    }
    if (this.timer%attackspeed==0)
    {
      attack_frame++;
      
      if (attack_frame==7)
      {
        whoosh.play();
        whoosh.rewind();
        exhausted=true;
      }
      if (attack_frame>=7)
      {
        checkDamage();
      }
      if (attack_frame>=10)
      {
        
        attack_frame=0;
        attacking=false;
        
      }
      
    }
    
  }
  
  void checkDamage()
  {
    if (this.pos.x<=Player.pos.x+78)
    {
      if (Player.damaged==false&&Player.ducking==false)
      {
        Player.takeDamage();
        
      }
    }
  }
  
  void update()
  {
    if (level==3&& animation_done==true)
    {
      //println(this.health);
      image(BHP[this.health],600,-50);
    }
    if (dead==false)
    {
      if (Player.dead==false)
      {
        think();
      }
      drawMe();
      checkDeath();
      move();
      
      if (attacking==true)
      {
        attack();
      }
      stopWalk();
      updateDamagedTimer();
      
      updateExhaustionTimer();
      updateDuckingTimer();
      updateFrame();
    }
  else
    {
      PImage currImage;
      currImage=death_frames.get(death_frame);
      image(currImage,this.pos.x,this.pos.y);
      if (timer%20==0)
      {
        death_frame++;
        
        
      }
      
      if (victory == false){
            gameVictory();
        }
        
      if (death_frame>=6)
      {
        death_frame = 6;
        

      }
      
      
    }
    updateTimer();
  }
  void drawMe()
  {
    PImage currImage;
    
        
    if (this.walking==true)
    {
      currImage=walk_frames.get(walk_frame);
      
    }
    else if (this.ducking==true)
    {
      currImage=boss_duck;
      
    }
    else if (this.attacking==true)
    {
      currImage=attack_frames.get(attack_frame);
      
    }
    else 
    {
      currImage=boss_walk_1;
      
    }
    if (damaged==true)
    {
      if (damagedTimer%2==0)
      {
        image(currImage,this.pos.x,this.pos.y);
      }
    }
    else
    {
      image(currImage,this.pos.x,this.pos.y);
    }
  }
  
  void think()
  {
    
    if (attacking==false&&this.damaged==true)
    {
      walkRight();
    }
    else if (Player.attacking==true&&this.damaged==false&&exhausted==false)
    {
      duck();
    }
    else if (Player.pos.x+78>this.pos.x&&this.ducking==false&&exhausted==false)
    {
      attacking=true;
    }
    else if (attacking==false&&ducking==false)
    {
      walkLeft(); 
    }
  }
  void take_damage()
  {
    //println (health);
    this.health-=2;
    this.damaged=true;
    this.injured=true;
    slash.play();
    slash.rewind();
    
  }
  void updateDamagedTimer()
  {
    if (damaged==true)
    {
      damagedTimer++;
      if (damagedTimer>=80)
      {
        damaged=false;
        damagedTimer=0;
      }
    }
  }
  void updateFrame()
  {
    if (this.direction=="left")
    {
       if (this.timer%6==0)
        {
          
          this.walk_frame--;
          
          if (this.walk_frame==-1)
          {
            this.walk_frame=2;
          }
        }
    }
    if (this.direction=="right")
    {
       if (this.timer%6==0)
        {
         
          this.walk_frame++;
          
          if (this.walk_frame==3)
          {
            this.walk_frame=0;
          }
        }
    }
  }
  void walkLeft()
  {
    this.direction="left";
    
    this.walking=true;
    this.vel.x=-4;
   
  }
  
  void walkRight()
  {
    this.direction="right";
    
    this.walking=true;
    this.vel.x=4;

  }
  boolean checkBackCollision()
  {
    
    if (this.pos.x+152>=850)
    {
      return true;
    }
    
    return false;
  }
  void stopWalk()
  {
    this.walking=false;
    
    
    this.vel.x=0;
  }
  void duck()
  {
    if (this.attacking==false)
    {
      this.ducking=true;
      
    }
  }
  void updateDuckingTimer()
  {
    if (this.ducking==true)
    {
      this.duckingTimer++;
      
      if (this.duckingTimer>=30)
      {
        this.ducking=false;
        this.duckingTimer=0;
      }
    }
  }
  void move()
  {
    if (this.checkBackCollision()==true)
    {
      
      if (this.vel.x<=0)
      {
        this.pos.x+=this.vel.x;
        
      }
      
    }
    else if(this.checkFrontCollision()==true)
    {
      if (this.vel.x>=0)
      {
        this.pos.x+=this.vel.x;
        
      }
    }
    else
    {
      this.pos.x+=this.vel.x;
      
    }
  }
  boolean checkFrontCollision()
  {
    
    if (this.pos.x+100<=Player.pos.x+68)
    {
      return true;
    }
    
    return false;
  }
  void checkInjury()
  {
    if (injured==true&&damaged==false)
    {
      injured=false;
      stopWalk();
      
    }
  
  
  }
  boolean isdodging()
  {
    return this.ducking;
  }
  void updateExhaustionTimer()
  {
    int stamina=60;
    if (health<10)
    {
       stamina=45;
       
    }
    
    else if (health<20)
    {
       stamina=50;
       
    }
    else if (health<30)
    {
       stamina=60;
       
    }
    if (exhausted==true)
    {
      exhaustionTimer++;
      if (exhaustionTimer>=stamina)
      {
        exhausted=false;
        exhaustionTimer=0;
      }
    }
  }
  void checkDeath()
  {
    if (health<=0)
    {
      die();
    }
  }
  void die()
  {
    
    dead=true;
    
    boss_music.pause();
    victory_music.rewind();
    victory_music.play();
  }
  void seppuku()
  {
    this.health=2;
  }
}
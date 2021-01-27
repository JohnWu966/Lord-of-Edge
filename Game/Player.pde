class Player
{
  int health=20;
  //manages animations
  int attack_frame=0;
  int walk_frame=0;
  int duckingTimer=0;
  int damagedTimer=0;
  int timer=0;
  int death_frame=0;
  String direction="none";
  
  //statuses
  
  boolean walking=false;
  boolean attacking=false;
  boolean damaged=false;
  boolean ducking=false;
  boolean dead=false;
  
  //PVectors for position and velocity
  PVector pos=new PVector(50,175);
  PVector vel=new PVector(0,0);
  
  //Animations
  PImage player_idle=loadImage("photos/Main_Character_Idle.png");
  PImage player_idle_debug=loadImage("photos/Main_Character_Debug.png");
  
  PImage player_attack1=loadImage("photos/Main_Character_Attack_1.png");
  PImage player_attack2=loadImage("photos/Main_Character_Attack_2.png");
  PImage player_attack3=loadImage("photos/Main_Character_Attack_3.png");
  
  PImage player_attack1_debug=loadImage("photos/Main_Character_Attack_1_Debug.png");
  PImage player_attack2_debug=loadImage("photos/Main_Character_Attack_2_Debug.png");
  PImage player_attack3_debug=loadImage("photos/Main_Character_Attack_3_Debug.png");
  
  PImage player_walk1=loadImage("photos/Main_Character_Walk_1.png");
  PImage player_walk2=loadImage("photos/Main_Character_Walk_2.png");
  PImage player_walk3=loadImage("photos/Main_Character_Walk_3.png");
  
  PImage player_duck=loadImage("photos/Main_Character_Duck.png");
  
  PImage player_dead_1=loadImage("photos/Main_Character_Dead_1.png");
  PImage player_dead_2=loadImage("photos/Main_Character_Dead_2.png");
  PImage player_dead_3=loadImage("photos/Main_Character_Dead_3.png");
  PImage player_dead_4=loadImage("photos/Main_Character_Dead_4.png");
  
  ArrayList<PImage> walk_frames=new ArrayList<PImage>();
  ArrayList<PImage> attack_frames=new ArrayList<PImage>();
  ArrayList<PImage> death_frames=new ArrayList<PImage>();
  
  
  Player()
  {
    walk_frames.add(player_idle);
    walk_frames.add(player_walk1);
    walk_frames.add(player_walk2);
    walk_frames.add(player_walk3);
    
    attack_frames.add(player_idle);
    attack_frames.add(player_attack1);
    attack_frames.add(player_attack2);
    attack_frames.add(player_attack3);
    
    death_frames.add(player_dead_1);
    death_frames.add(player_dead_2);
    death_frames.add(player_dead_3);
    death_frames.add(player_dead_4);
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
  
  void stopWalk()
  {
    this.walking=false;
    
    this.walk_frame=0;
    this.vel.x=0;
  }
  
  void drawMe()
  {
    PImage currImage;
    if (this.walking==true)
    {
      currImage=walk_frames.get(walk_frame);
      image(currImage,this.pos.x,this.pos.y);
    }
    else if (this.ducking==true)
    {
      currImage=player_duck;
      image(currImage,this.pos.x,this.pos.y);
    }
    else if (this.attacking==true)
    {
      currImage=attack_frames.get(attack_frame);
      image(currImage,this.pos.x,this.pos.y);
    }
    else 
    {
      currImage=player_idle;
      image(currImage,this.pos.x,this.pos.y);
    }
    
  }
  
  void updateTimer()
  {
    this.timer++;
    if (this.timer>=60)
    {
      this.timer=0;
    }
    
  }
  
  void move()
  {
    if (this.checkFrontCollision()==true)
    {
      
      if (this.vel.x<=0)
      {
        this.pos.x+=this.vel.x;
      }
      
    }
    else if (this.checkBackCollision()==true)
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
  void attack()
  {
    if (timer%3==0)
    {
      attack_frame+=1;
      
      if (attack_frame>=4)
      {
        checkDamage();
        this.attack_frame=0;
        this.attacking=false;
        
      }
    }
  }
  void update()
  {
    if (dead==false)
    {
      Player.move();
      if (this.attacking==true)
      {
        attack();
      }
      if (damaged==true)
      {
        if (damagedTimer%2==0)
        {
          Player.drawMe();
        }
      }
      
      else
      {
        Player.drawMe();
      }
      updateFrame();
      
      updateDamagedTimer();
      updateDuckingTimer();
      checkDeath();
    }
    
    else
    {
      PImage currImage;
      currImage=death_frames.get(death_frame);
      image(currImage,this.pos.x,this.pos.y);
      if (timer%10==0)
      {
        death_frame++;
      }
      
      if (death_frame>=4)
      {
        death_frame=3;
        dieing_transition();
      }
    }
    Player.updateTimer();
  }
  void updateDamagedTimer()
  {
    if (damaged==true)
    {
      damagedTimer++;
      if (damagedTimer>=20)
      {
        damaged=false;
        damagedTimer=0;
      }
    }
  }
  void checkDamage()
  {
    for (int i=0;i<enemies.size();i++)
    {
      Enemy currenemy;
      currenemy=enemies.get(i);
      if ((this.pos.x+193>=currenemy.pos.x-currenemy.enemy_width/2&&currenemy.damaged==false))
      {
        if (currenemy.isdodging())
        {
        }
        else
        currenemy.take_damage();
      }
    }
        
       }
  void checkEnemyDamage()
  {
    for (int i=0;i<enemies.size();i++)
    {
      Enemy currenemy;
      currenemy=enemies.get(i);
      currenemy.checkDamage(this.pos.x);
      
    }
  }
  boolean checkFrontCollision()
  {
    for (int i=0;i<enemies.size();i++)
    {
      Enemy currenemy;
      currenemy=enemies.get(i);
      if (this.pos.x+102>=currenemy.pos.x-currenemy.enemy_width/2)
      {
        return true;
      }
    }
    if (this.pos.x+102>900&&level==3)
    {
      return true;
    }
    return false;
  }
  boolean checkBackCollision()
  {
    
    if (this.pos.x+102<=100)
    {
      return true;
    }
    
    return false;
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
            this.walk_frame=3;
          }
        }
    }
    if (this.direction=="right")
    {
       if (this.timer%6==0)
        {
         
          this.walk_frame++;
          
          if (this.walk_frame==4)
          {
            this.walk_frame=0;
          }
        }
    }
  }
  void takeDamage()
  {
    
    damaged=true;
    
    if (level==2)
    {
      this.health-=1;
      slash.play();
      slash.rewind();
    }
    if (level==3)
    {
      this.health-=2;
      whack.play();
      whack.rewind();
    }
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
    if (ducking==true)
    {
      duckingTimer++;
      if (duckingTimer>=30)
      {
        ducking=false;
        duckingTimer=0;
      }
    }
  }
  void die()
  {
    playMode=false;
    dead=true;
    background_music.pause();
    boss_music.pause();
  }
  void checkDeath()
  {
    if (health<=0)
    {
      die();
    }
  }
}
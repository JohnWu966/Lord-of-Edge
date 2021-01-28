Player Player;
Boss Boss;
PImage room;
import ddf.minim.*; 
ArrayList<Enemy> enemies=new ArrayList<Enemy>();
boolean playMode=false;
int level;

//variables for level transition
boolean transitioning=false;
int transition_timer=0;

// variables for the boss intro
int animation_timer=1;
int animation_frame=1;
int text_animation_timer=1;
int text_transparency=0;
boolean animating=false;
PImage[] animation;
PImage boss_text;
boolean animation_done=false;

//health bars
PImage[] HP;
PImage[] BHP;


// variables for dialogue boxes
int textCounter=1;
PImage boss_head;
int characterCounter=1;
boolean won;
int win_transparency=0;
int death_transparency=0;
boolean victory = false;
boolean fullyDead=false;
//dialogue lines
String text1_1="Ahahaha if isn't that classless oaf Lord Edge!";
String text1_2="You think you can defeat the Marvelous Masked Mustache Man? You're way out of your league!";
String text1_3="I bet you don't even know that you can destroy those pillars by attacking them with the \"Z\" button!";
String text1_4="Do you even know how to walk? It's quite simple you mindless buffoon you just press the left or right arrow keys, that is if your tiny brain even understands what those are!";
String text2_1="Oh wow! You sliced some rocks! I bet you think you're some hot s#!7 don't you?";
String text2_2="Let's see you handle some real minions! Face my wooden totems of doom!";
String text2_3="Scared of those swords aren't you? HAH! How long ago was it when you last dodged a strike?";
String text2_4="Be careful knave, if you press the Down Key too quickly, you might dodge too fast and slip! HAHAHA!";
String text3_1="Oh bullocks... you weren't supposed to actually make it over here- ER I MEAN";
String text3_2="YOU HAVE PASSED THE TEST OH KNIGHT OF SUCH SKILL AND DASHING GOOD LOOKS - second only to mine of course";
String text3_3="JOIN ME AND WE SHALL RULE THIS ENTIRE COUNTRY, AND THEN THE WORLD!";
String text3_4=".......";
String text3_5="Would that be a yes...? ...Ummmmmmm well then... IF YOU WON'T JOIN ME THEN DIE. Yeah, that sounded pretty cool and menacing.";

//used to play music and sound effects
Minim minim;
AudioPlayer background_music;
AudioPlayer boss_music;
AudioPlayer dialogue;
AudioPlayer crumbling;
AudioPlayer slash;
AudioPlayer wood_chop;
AudioPlayer totem_death;
AudioPlayer victory_music;
AudioPlayer whack;
AudioPlayer whoosh;
PFont font;

void setup()
{
  
  Boss Boss =new Boss(30,new PVector(2000,175),new PVector(0,0),-250);
  font = loadFont("ComicSansMS-48.vlw");
  textFont(font, 24);
  size(1000,500);
  level0();
  room=loadImage("photos/level_1_map.png");
  Player= new Player();
  boss_head=loadImage("photos/boss_head.png");
  
  setAnimation();
  setHealth();
  minim = new Minim(this);
  background_music= minim.loadFile("sounds/background_music.wav"); 
  boss_music= minim.loadFile("sounds/boss_music.wav");
  victory_music= minim.loadFile("sounds/victory_music.wav");
  wood_chop=minim.loadFile("sounds/wood_chop.wav");
  totem_death=minim.loadFile("sounds/totem_death.wav");
  dialogue=minim.loadFile("sounds/dialogue.wav");
  crumbling=minim.loadFile("sounds/crumbling.wav");
  slash=minim.loadFile("sounds/slash.wav");
  whack=minim.loadFile("sounds/whack.wav");
  whoosh=minim.loadFile("sounds/whoosh.wav");
  background_music.loop();
}

void draw()

{
  
    
    
    image(room,0,0);
    
    if (Player.health < 0){
      Player.health = 0;
    }
    image(HP[Player.health],0,-50);
    
    Player.update();
    
    for (int i=0; i<enemies.size();i++)
    {
      Enemy currEnemy=enemies.get(i);
      currEnemy.update();
    }
    
    if (Player.pos.x>=1000)
    {
      transitioning=true;
      
    }
    animation();
  if (won==false)
  {
  if (playMode==false&&Player.health>0)
  {
    if (level==0)
    {
      
        fill(0,0,255);
        rect(50,50,900,400);
        fill(255);
        if (textCounter==1)
        {
          text("Use Left+Right to move",75,100,width-10,900);
          text("Use Z to attack enemies and obstacles",75,200,width-10,900);
          text("Press Z to advance text",75,300,width-10,900);
        }
        if (textCounter==2)
        {
          text("This story is set in the year 1xxx, in the small medieval village of Villageville. You play the role of Lord Edge, a famous knight who had sworn off his sword long ago for reasons known only to him. Life in the village was peaceful, however disaster struck when the evil criminal Masked Moustache Man invades the village and lays waste to everything in sight. As the only knight in the area, Lord Edge takes it upon himself to deliver justice to this villain.",75,100,width-150,900);
        }
    }
    if (level==1)
    {
      
        fill(0,0,255);
        rect(50,0,900,150);
        fill(255);
        image(boss_head,850,25);
        if (textCounter==1)
        {
          String quote=text1_1.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text1_1.length())
          {
            characterCounter++;
          }
          if (characterCounter==text1_1.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==2)
        {
          String quote=text1_2.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text1_2.length())
          {
            characterCounter++;
          }
          if (characterCounter==text1_2.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==3)
        {
          String quote=text1_3.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text1_3.length())
          {
            characterCounter++;
          }
          if (characterCounter==text1_3.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==4)
        {
          String quote=text1_4.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text1_4.length())
          {
            characterCounter++;
          }
          if (characterCounter==text1_4.length())
          {
            dialogue.pause();
          }
        }
    }
    if (level==2)
    {
      
        fill(0,0,255);
        rect(50,0,900,150);
        fill(255);
        image(boss_head,850,25);
        if (textCounter==1)
        {
          String quote=text2_1.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text2_1.length())
          {
            characterCounter++;
          }
          if (characterCounter==text2_1.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==2)
        {
          String quote=text2_2.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text2_2.length())
          {
            characterCounter++;
          }
          if (characterCounter==text2_2.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==3)
        {
          String quote=text2_3.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text2_3.length())
          {
            characterCounter++;
          }
          if (characterCounter==text2_3.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==4)
        {
          String quote=text2_4.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text2_4.length())
          {
            characterCounter++;
          }
          if (characterCounter==text2_4.length())
          {
            dialogue.pause();
          }
        }
    }
    if (level==3&&animating==false&&animation_done==false)
    {
      
        fill(0,0,255);
        rect(50,0,900,150);
        fill(255);
        image(boss_head,850,25);
        if (textCounter==1)
        {
          String quote=text3_1.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text3_1.length())
          {
            characterCounter++;
          }
          if (characterCounter==text3_1.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==2)
        {
          String quote=text3_2.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text3_2.length())
          {
            characterCounter++;
          }
          if (characterCounter==text3_2.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==3)
        {
          String quote=text3_3.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text3_3.length())
          {
            characterCounter++;
          }
          if (characterCounter==text3_3.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==4)
        {
          String quote=text3_4.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text3_4.length())
          {
            characterCounter++;
          }
          if (characterCounter==text3_4.length())
          {
            dialogue.pause();
          }
        }
        if (textCounter==5)
        {
          String quote=text3_5.substring(0,characterCounter);
          text(quote,75,25,width-250,900);
          if (characterCounter<text3_5.length())
          {
            characterCounter++;
          }
          if (characterCounter==text3_5.length())
          {
            dialogue.pause();
          }
        }
     
    }
    if (level==3)
     {
       tint(255,text_transparency);
       fill(255,0,255,text_transparency);
       noStroke();
       rect(0,0,width,150);
      image(boss_text,0,0);
      tint(255,255);
     }
  }
  }
  if (Player.dead==true)
  {
    dieing_transition();
  }
  if (victory == true)
  {
      winning_transition();
   }

  if (transitioning==true)
      {
        
        fill(0,255-(abs(255-(transition_timer*255/60))));
        
        rect(0,0,1000,500);
        transition_timer++;
        
        
        if (transition_timer==60)
        {
          
          Player.pos.x=0;
          if (level==1)
          {
            
            level2();
            playMode=false;
            Player.stopWalk();
          }
          else if (level==2)
          {
            background_music.pause();
            background_music.rewind();
            startLevel3();
            playMode=false;
            Player.stopWalk();
          }
           else if (level==3)
          {
            
          }
          
        }
        if (transition_timer>=120)
        {
          transition_timer=0;
          transitioning=false;
          
          
        }
      }
   
}
void keyPressed()
{
  if (playMode)
  {
    if (Player.attacking==false&&Player.ducking==false)
    {
      if (key == CODED) 
      {
          
        if (keyCode == LEFT)  
        {
            Player.walkLeft();
        }
        
        if (keyCode == RIGHT) 
        {     
            Player.walkRight();
        }
        if (keyCode == DOWN) 
        {     
            Player.duck();
        }
      }
      if (key=='z'||key=='Z')
      {
        Player.attacking=true;
        Player.stopWalk();
      }
      
    }
  }
  else
  {
    if (key=='z'||key=='Z')
    {
      
      
      {
        if (fullyDead==true)
        {
          reset();
        }
        else if (level==0&&textCounter==2)
        {
          level1();
          textCounter=1;
        }
        else if (level==1&&textCounter==4)
        {
          playMode=true;
          dialogue.pause();
          dialogue.rewind();
          textCounter=1;
        }
        else if (level==2&&textCounter==4)
        {
          playMode=true;
          dialogue.pause();
          dialogue.rewind();
          textCounter=1;
        }
        else if (level==3&&textCounter==5)
        {
          animating=true;
          dialogue.pause();
          dialogue.rewind();
          boss_music.loop();
          textCounter=1;
        }
        
        else
        {
          if (animating==false)
          {
          textCounter++;
          if (level!=0)
          {
            dialogue.rewind();
            dialogue.play();
          }
          }
        }
        
        characterCounter=1;
      }
      
    }
  }
  
}
void keyReleased()
{
  if (playMode)
  {
    if (key == CODED) 
    {
      
      
      if (keyCode == LEFT)  
      {
        Player.stopWalk();
        Player.direction="none";
      }
      
      if (keyCode == RIGHT) 
      {
        Player.stopWalk();
        Player.direction="none";
      }
    }
    
  }
  
}

void level1()
{
  level=1;
  room=loadImage("photos/level_1_map.png");
  
  Pillar Pillar1= new Pillar(1,new PVector(500,210),new PVector(0,0),46);
  enemies.add(Pillar1);
  Pillar Pillar2= new Pillar(1,new PVector(800,210),new PVector(0,0),46);
  enemies.add(Pillar2);
  dialogue.rewind();
  dialogue.play();
  
}
void level2()
{
  level=2;
  room=loadImage("photos/level_2_map.png");
  Dummy dummy= new Dummy(3,new PVector(300,285),new PVector(0,0),-40);
  Dummy dummy2= new Dummy(3,new PVector(600,285),new PVector(0,0),-40);
  enemies.add(dummy);
  enemies.add(dummy2);
  Player.pos.x=50;
  dialogue.rewind();
  dialogue.play();
}
void level3()
{
  level=3;
  room=loadImage("photos/level_3_map.png");
  Boss Boss=new Boss(30,new PVector(600,175),new PVector(0,0),-250);
  enemies.add(Boss);
  Player.pos.x=50;
  
}
void level0()
{
  playMode=false;
  level=0;
}

void setAnimation()
{
  animation= new PImage[40];
  for (int i=1;i<40;i++)
  {
    animation[i]=loadImage("photos/boss_animation/boss_animation_"+i+".png");
  }
  boss_text=loadImage("photos/boss_text.png");
}

void startLevel3()
{
  level=3;
  room = animation[1];
  Player.pos.x=50;
  dialogue.rewind();
  dialogue.play();
}
void animation()
{
  if (animating==true)
  {
    
    room=animation[animation_frame];
    
    if (Player.timer%4==0)
    {
      animation_timer++;
    }
    
     
      
     
    if (text_transparency <255)
    {
      text_transparency+=10;
    }
    else if (text_transparency>255)
    {
      text_transparency=255;
    }
    if (animation_timer>=70)
    {
      animating=false;
      animation_timer=0;
      animation_done=true;
      playMode=true;
          level3();
          
    }
    if (animation_timer<40)
    {
    animation_frame=animation_timer;
    }
    else
    {
    animation_frame=39;
    }
  }
}
void reset()
{
  level0();
  playMode=false;
  animation_timer=1;
  text_animation_timer=1;
  text_transparency=0;
  textCounter=1;
  animating=false;
  room=loadImage("photos/level_1_map.png");
  Player= new Player();
 
  animation_done=false;
  
  for(int i=0;i<=enemies.size();i++)
  {
    enemies.remove(0);
  }
  dialogue.pause();
  dialogue.rewind();
  boss_music.pause();
  boss_music.rewind();
  background_music.rewind();
  background_music.play();
  fullyDead=false;
  death_transparency=0;
  animation_frame=1;
}
void dieing_transition()
{
  fill(0,death_transparency);
  
  rect(0,0,width,height);
  death_transparency+=2;
  println ("DED:" + death_transparency);
  if (death_transparency>=255)
  {
    death_transparency=255;
    fullyDead=true;
    fill(255);
    textFont(font, 60);
    text("Game Over. Press Z to restart",75,100,width-150,900);
    textFont(font,24);
  }
}
void setHealth()
{
  HP =new PImage[21];
  for (int i=0;i<=20;i++)
  {
    HP[i]=loadImage("photos/Main_Character_HP/HP"+i+".png");
   
  }
  BHP = new PImage[31];
  for (int i=0;i<=30;i++)
  {
    BHP[i]=loadImage("photos/Boss_HP/BHP"+i+".png");
  }
}
void winning_transition()
{
  fill(255,win_transparency);
  rect(0,0,width,height);
  win_transparency+=1;
  println("Win:"+ win_transparency);
  if (win_transparency>=255)
  {
    win_transparency=255;
    
    fill(0);
    textFont(font, 60);
    text("Congratulations! You've saved the village from the evil villain!",75,100,width-150,900);
    textFont(font,24);
  }
    
}
void gameVictory(){
  victory = true;
}
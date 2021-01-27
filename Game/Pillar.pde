class Pillar extends Enemy
{
  //mainly animations for the pillar's death animation
  PImage pillar_idle=loadImage("photos/enemy_pillar.png");
  PImage pillar_death_1=loadImage("photos/enemy_pillar_dead_1.png");
  PImage pillar_death_2=loadImage("photos/enemy_pillar_dead_2.png");
  PImage pillar_death_3=loadImage("photos/enemy_pillar_dead_3.png");
  PImage pillar_death_4=loadImage("photos/enemy_pillar_dead_4.png");
  PImage pillar_death_5=loadImage("photos/enemy_pillar_dead_5.png");
  PImage pillar_death_6=loadImage("photos/enemy_pillar_dead_6.png");
  PImage pillar_death_7=loadImage("photos/enemy_pillar_dead_7.png");
  PImage pillar_death_8=loadImage("photos/enemy_pillar_dead_8.png");
  PImage pillar_death_9=loadImage("photos/enemy_pillar_dead_9.png");
  ArrayList<PImage> death_frames=new ArrayList<PImage>();
  
  
  Pillar(int health,PVector pos, PVector vel,int enemy_width)
  {
    super(health,pos,vel,enemy_width);
    death_frames.add(pillar_idle);
    death_frames.add(pillar_death_1);
    death_frames.add(pillar_death_2);
    death_frames.add(pillar_death_3);
    death_frames.add(pillar_death_4);
    death_frames.add(pillar_death_5);
    death_frames.add(pillar_death_6);
    death_frames.add(pillar_death_7);
    death_frames.add(pillar_death_8);
    death_frames.add(pillar_death_9);
  }
  void drawMe()
  {
    PImage currImage;
    if (this.dead==true)
    {
      if (this.dead_frame==0)
      {
        crumbling.play();
        crumbling.rewind();
      }
      currImage=death_frames.get(this.dead_frame);
      image(currImage,this.pos.x,this.pos.y); 
      if(timer%3==0)
      {
        this.dead_frame++;
      }
      if (this.dead_frame>=10)
      {
        enemies.remove(this);
      }
    }
    else 
    {
      currImage=pillar_idle;
      image(currImage,this.pos.x,this.pos.y);
    }
  }
  
}
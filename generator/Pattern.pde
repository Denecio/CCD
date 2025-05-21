class Pattern{
  int size, ammount;
  PVector[] pos;
  float sizeDiversity;
  PImage[] imgs;
  
  Pattern(PImage[] imgs){
    for(int i = 0; i< imgs.length; i++)
      this.imgs[i] = imgs[i].copy();
    size = round(width/random(10,20));
    ammount = width/size;
  }
  
  void render(){
    
  }
}

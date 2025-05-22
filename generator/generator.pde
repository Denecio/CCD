import gab.opencv.*;
import processing.pdf.*;
import java.io.File;
import java.io.FilenameFilter;

OpenCV opencv;
PImage dst;
boolean record;

Population[] pops = new Population[4];
Pattern pattern;
boolean endEvolution = false;

PImage[] bases = new PImage[4];
ArrayList<PImage> imgs = new ArrayList<PImage>();
ArrayList<Contour> shapes = new ArrayList<Contour>();
IntList colors = new IntList();
File[] imageFiles;


PFont font;
PImage bg, logo, logoSmall, talao, bolso, sacos, fita, uploadIcon;
int page = 1;

void settings(){
  size(int(displayWidth * 0.9), int(displayHeight * 0.8), P2D);
  smooth(8);
}

void setup() {
  font = createFont("Inter-VariableFont.ttf", 20);
  textFont(font);
  textAlign(CENTER, CENTER);

  bg = loadImage("Group_1.png");
  logo = loadImage("Banca Criativa BR.png");
  logoSmall = loadImage("Layer_3.png");
  talao = loadImage("Talão.png");
  bolso = loadImage("Bolso.png");
  sacos = loadImage("Saco.png");
  fita = loadImage("Fita-cola.png");
  uploadIcon = loadImage("Asset 7.png");
  
  for(int i = 0; i < pops.length; i++){
    bases[i] = loadImage("teste" + i + ".png");
  }
  
  for(int i = 0; i < pops.length; i++){
    pops[i] = new Population(bases[i]);
  }
  
  String[] lines = loadStrings("images.txt");
  
  for(int i = 0; i < lines.length; i++){
    PImage img = loadImage(lines[i]);
    img.resize(300, 300*img.height/img.width);

    ArrayList<Contour> contours = findContours(img);
    
    if (contours.size() > 1) {
      contours.remove(contours.size() - 1);
    }
  
    if (contours.size() > 0) {
      Contour largest = contours.get(0);
      float maxArea = largest.area();
  
      for (Contour c : contours) {
        float area = c.area();
        if (area > maxArea) {
          maxArea = area;
          largest = c;
        }
      }
      
      shapes.add(largest);
      colors.append(findColor(largest, img));
    }
  }
}

void draw() {
  imageMode(CORNER);
  background(255);
  image(bg, 0, 0, width, height);
  if(page == 1)
    drawPage1();
  else if(page == 2)
    drawPage2();
  else if(page == 3)
    drawPage3();
  else if(page == 4)
    drawPage4();
  else if(page == 5){
    if(!endEvolution){
      evolve();  
    } else {
      imageMode(CENTER);
      image(pattern.getPattern(), width/2, height/2);
    }
  }
}

void mouseClicked(){
  float rx = width - 250;
  float ry = height - 120;
  float rh = 80;
  float rw = 200;
  if(endEvolution){
    pattern.export();
  }
  if(page==4 && mouseX > rx - rw/2 && mouseX < rx + rw/2 && mouseY > ry - rh/2 && mouseY < ry + rh/2){
    selectFolder("Select a folder to load images from:", "folderSelected");
  }
}

void evolve(){
  for(int i = 0; i < pops.length; i++){
    pops[i].evolve();
    imageMode(CENTER);
    Module best = pops[i].getIndiv(0); // Or however you track the best one
    image(best.getPhenotype(128), (i+1) * width/(pops.length+1), height/2);
    //best.savePhenotype("output/module" + i + ".png", 128);
    if(pops[3].getGenerations() == 100){
      endEvolution = true;
      PImage[] modules = {pops[0].getIndiv(i).getPhenotype(128), pops[1].getIndiv(0).getPhenotype(128), pops[2].getIndiv(0).getPhenotype(128), pops[3].getIndiv(0).getPhenotype(128),};
      pattern = new Pattern(modules);
    }
  }
}

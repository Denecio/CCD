import gab.opencv.*;
import processing.pdf.*;

OpenCV opencv;
PImage dst;
boolean record;

Population[] pops = new Population[4];
int population_size = 50;
int elite_size = 2;
int tournament_size = 4;
float crossover_rate = 0.7;
float mutation_rate = 0.05;

PImage[] bases = new PImage[4];
ArrayList<PImage> imgs = new ArrayList<PImage>();
ArrayList<Contour> shapes = new ArrayList<Contour>();
IntList colors = new IntList();

void settings(){
  size(int(displayWidth * 0.9), int(displayHeight * 0.8), P2D);
  smooth(8);
}

void setup() {
  frameRate(60);
  for(int i = 0; i < pops.length; i++)
    bases[i] = loadImage("teste" + i + ".png");
  
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
  background(125);

  evolve();  
}

void evolve(){
  for(int i = 0; i < pops.length; i++){
    if(pops[3].getGenerations() < 600){
      pops[i].evolve();
    }
    imageMode(CENTER);
    Module best = pops[i].getIndiv(0); // Or however you track the best one
    image(pops[i].getIndiv(i).getPhenotype(128), (i+1) * width/(pops.length+1), height/2);
    best.savePhenotype("output/module" + i + ".png", 128);
  }
}

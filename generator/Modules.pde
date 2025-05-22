float crossover_rate = 0.7;
float mutation_rate = 0.05;

class Module {
  int numShapes = 20;
  int genesPerShape = 5;
  float[] genes = new float[numShapes * genesPerShape];
  float fitness = 0; // Fitness value
  PImage img;

  Module(PImage img) {
    randomize();
    this.img = img;
  }

  Module(float[] genes_init, PImage img) {
    for (int i = 0; i < genes_init.length; i++) {
      genes[i] = genes_init[i];
    }
    this.img = img;
  }

  void randomize() {
    for (int i = 0; i < genes.length; i++) {
      genes[i] = random(0, 1);
    }
  }

  PImage getPhenotype(int resolution) {
    PGraphics canvas = createGraphics(resolution, resolution);
    canvas.beginDraw();
    canvas.background(255);
    canvas.noFill();
    canvas.stroke(0);
    canvas.strokeWeight(canvas.height * 0.002);
    render(canvas);
    canvas.endDraw();
    return canvas;
  }

  void render(PGraphics canvas) {
    canvas.pushMatrix();
    canvas.background(255);
    canvas.translate(canvas.width / 2, canvas.height / 2);
  
    for (int i = 0; i < numShapes; i++) {
      int offset = i * genesPerShape;
      float x = map(genes[offset], 0, 1, -canvas.width / 2, canvas.width / 2);
      float y = map(genes[offset + 1], 0, 1, -canvas.height / 2, canvas.height / 2);
      int shapeType = floor(genes[offset + 2] * (shapes.size() - 1)); // 0=circle, 1=rect, 2=triangle
      float size = map(genes[offset + 3], 0, 1, 0.05, 0.2);
      float angle = map(genes[offset + 4], 0, 1, 0, TWO_PI);
  
      canvas.pushMatrix();
      
      canvas.translate(x, y);
      canvas.rotate(angle);
      canvas.scale(size, size);
      canvas.fill(0);
      canvas.stroke(0);
      canvas.strokeWeight(1.5);
      
      if(shapes.size() > 0){
        drawShapes(canvas, shapes.get(shapeType), colors.get(shapeType), img);
      }
  
      canvas.popMatrix();
    }
    canvas.popMatrix();
  }
 
  Module uniformCrossover(Module partner) {
    Module child = new Module(img);
    for (int i = 0; i < numShapes; i++) {
      int offset = i * genesPerShape;
      boolean fromThis = random(1) < 0.5;
      for (int j = 0; j < genesPerShape; j++) {
        child.genes[offset + j] = fromThis ? this.genes[offset + j] : partner.genes[offset + j];
      }
    }
    return child;
  }


  void mutate() {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) <= mutation_rate) {
        //genes[i] = random(1); // Replace gene with a random one
        genes[i] = constrain(genes[i] + random(-0.2, 0.2), 0, 1); // Adjust the value of the gene
      }
    }
  }

  // Set the fitness value
  void setFitness(float fitness) {
    this.fitness = fitness;
  }

  // Get the fitness value
  float getFitness() {
    return fitness;
  }
  
  Module getCopy() {
    Module copy = new Module(genes, img);
    copy.fitness = fitness;
    return copy;
  }
  
  void savePhenotype(String filename, int resolution) {
    PImage img = getPhenotype(resolution);
    img.save(filename);
  }

}

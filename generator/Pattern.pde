class Pattern{
  int size, amount, rows, columns;
  ArrayList<PVector> grid = new ArrayList<PVector>();
  PVector[] points;
  float sizeDiversity;
  PImage[] imgs;
  
  Pattern(PImage[] imgs){
    this.imgs = new PImage[imgs.length];
    for(int i = 0; i < imgs.length; i++)
      this.imgs[i] = imgs[i].copy();
      
    rows = 3;
    columns = int(random(5,20));
    size = int(width * 0.8 / columns);
    amount = int(random(30, columns*rows));
    points = new PVector[amount];
    for(int i = 0; i < columns; i++){
      for(int j = 0; j < rows; j++){
        PVector p = new PVector(i*size, j*size);
        grid.add(p);
      }
    }
    
    for(int i = 0; i < amount; i++){
      points[i] = grid.get(int(random(grid.size())));
    }
  }
  
  void render(PGraphics pg){
    pg.imageMode(CORNER);
    for(int i = 0; i < points.length; i++){
      pg.image(imgs[i%4], points[i].x, points[i].y, size, size);
    }   
  }
  
  PImage getPattern() {
    PGraphics canvas = createGraphics(int(width*0.8), int(size*rows));
    canvas.beginDraw();
    canvas.background(255);
    render(canvas);
    canvas.endDraw();
    return canvas;
  }
  
  void export() {
    String output_filename = year() + "-" + nf(month(), 2) + "-" + nf(day(), 2) + "-" +
                             nf(hour(), 2) + "-" + nf(minute(), 2) + "-" + nf(second(), 2);
    String output_path = sketchPath("outputs/" + output_filename);
    println("Exporting Pattern to: " + output_path);
    
    getPattern().save(output_path + ".png");
    
    PGraphics pdf = createGraphics(int(width*0.8), int(size*rows), PDF, output_path + ".pdf");
    pdf.beginDraw();
    pdf.noFill();
    pdf.strokeWeight(pdf.height * 0.001);
    pdf.stroke(0);
    render(pdf);
    pdf.dispose();
    pdf.endDraw();
  }
}

void drawShapes(PGraphics pg, Contour contour, color c, PImage img){
    ArrayList <PVector> points = contour.getPolygonApproximation().getPoints();
    float x=0, y=0;
    
    for (PVector point : points) {
      x += point.x;
      y += point.y;
    }
    
    x = x/points.size();
    y = y/points.size();

    pg.noStroke();
    pg.fill(c);
    pg.pushMatrix();
    pg.translate(-img.width/2, -img.height/2);
    pg.beginShape();
    for (PVector point : points) {
      pg.vertex(point.x, point.y);
    }
    pg.endShape();
    pg.popMatrix();
}

ArrayList<Contour> findContours(PImage img){
  opencv = new OpenCV(this, img);
  
  opencv.gray();
  opencv.threshold(240); //aumentar este valor se não estiver a dar 
  dst = opencv.getOutput();
  
  return opencv.findContours();
}

color findColor(Contour contour, PImage img){
    ArrayList <PVector> points = contour.getPolygonApproximation().getPoints();
    float x=0, y=0;
    
    for (PVector point : points) {
      x += point.x;
      y += point.y;
    }
    
    x = x/points.size();
    y = y/points.size();
    
    PVector center = new PVector(x,y);
    
    if (!pointInPolygon(center, points)) {
      // Try random sampling inside bounding box
      PVector insidePoint = null;
      int attempts = 100;
      float minX = width, minY = height, maxX = 0, maxY = 0;
      for (PVector p : points) {
        minX = min(minX, p.x);
        minY = min(minY, p.y);
        maxX = max(maxX, p.x);
        maxY = max(maxY, p.y);
      }
  
      for (int i = 0; i < attempts; i++) {
        float testX = random(minX, maxX);
        float testY = random(minY, maxY);
        PVector testPoint = new PVector(testX, testY);
        if (pointInPolygon(testPoint, points)) {
          insidePoint = testPoint;
          break;
        }
      }
  
      if (insidePoint != null) {
        center = insidePoint;
      } else {
        println("Could not find inside point for color sampling.");
      }
    }
  
    return img.get(int(center.x), int(center.y));
}

boolean pointInPolygon(PVector point, ArrayList<PVector> polygon) {
  int i, j;
  boolean result = false;
  for (i = 0, j = polygon.size() - 1; i < polygon.size(); j = i++) {
    PVector pi = polygon.get(i);
    PVector pj = polygon.get(j);
    if ((pi.y > point.y) != (pj.y > point.y) &&
        (point.x < (pj.x - pi.x) * (point.y - pi.y) / (pj.y - pi.y) + pi.x)) {
      result = !result;
    }
  }
  return result;
}

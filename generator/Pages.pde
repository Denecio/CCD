void drawPage1() {
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("SOBRE", width - 200, 30); // Mantido
  text("CRIAR", width - 100, 30); // Mantido

  float logoMaxW = 600;
  float logoW = min(logo.width, logoMaxW);
  float logoH = logo.height * (logoW / logo.width);

  float x = 20;                 // mesma margem esquerda
  float y = height / 2 - 200;   // mesma lógica vertical

  image(logo, x, y, logoW, logoH);
  
  float rx = width - 150;
  float ry = height - 100;
  float rh = 100;
  float rw = 240;
  fill(255);
  stroke(0);
  rectMode(CENTER);
  rect(rx, ry, rw, rh); // ajustado pela nova altura

  fill(0);
  textSize(20);
  text("CRIA AQUI\nOS TEUS\nMATERIAIS", width - 150, height - 100);
  
  if(mouseX > width - 200 - 25 && mouseX < width - 200 + 25 && mouseY > 30 - 10 && mouseY < 30 + 10){
    if(mousePressed)
      page = 2;
  }else if(mouseX > width - 100 - 25 && mouseX < width - 100 + 25 && mouseY > 30 - 10 && mouseY < 30 + 10){
    if(mousePressed)
      page = 3;
  } else if(mouseX > rx - rw/2 && mouseX < rx + rw/2 && mouseY > ry - rh/2 && mouseY < ry + rh/2){
    if(mousePressed)
      page = 3;
  }
}

void drawPage2() {
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("SOBRE", width - 200, 30); // Mantido
  text("CRIAR", width - 100, 30); // Mantido
  rectMode(CORNER);
  textAlign(LEFT, TOP);

  float w = 80;  // largura original
  float h = logoSmall.height * (w / logoSmall.width);
  image(logoSmall, 40, 30, w, h);  // posição e tamanho originais

  fill(0);
  textSize(16);
  float x = 160;      // levemente ajustado para centralizar melhor em 1280px
  float y = 240;      // subido um pouco para manter proporção vertical

  String paragraph = 
    "A publicidade é essencial para os vendedores de mercados tradicionais, pois permite atrair clientes e destacar produtos. " +
    "No entanto, muitos vendedores do Mercado Municipal de Coimbra (D. Pedro V) não têm acesso a designers ou conhecimento em ferramentas de edição. " +
    "A utilização de inteligência artificial (IA) na criação automática de materiais gráficos pode resolver este problema. " +
    "O nosso projeto visa desenvolver um sistema de IA capaz de gerar material gráfico automaticamente a partir de uma imagem fornecida pelo utilizador, " +
    "representando a identidade da sua marca ou até os seus produtos. O sistema permitirá que o utilizador edite títulos e descrições, garantindo flexibilidade e personalização.";

  text(paragraph, x, y, 800, 300);  // bloco com mais largura para o novo canvas

  textSize(14);
  String credits = 
    "CRIATIVIDADE COMPUTACIONAL PARA DESIGN\n" +
    "AUTORES: JOANA NUNES E VASCO BASTOS\n" +
    "SUPERVISORES:\n" +
    "ANO: 2024/2025";

  text(credits, x, y + 260);  // espaçamento ajustado proporcionalmente
  
  if(mouseX > width - 200 - 25 && mouseX < width - 200 + 25 && mouseY > 30 - 10 && mouseY < 30 + 10){
    if(mousePressed)
      page = 2;
  } else if(mouseX > width - 100 - 25 && mouseX < width - 100 + 25 && mouseY > 30 - 10 && mouseY < 30 + 10){
    if(mousePressed)
      page = 3;
  }
}

void drawPage3() {
  float w = 80;
  float h = logoSmall.height * (w / logoSmall.width);
  image(logoSmall, 40, 30, w, h);  // POSIÇÃO E TAMANHO ORIGINAIS

  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("SOBRE", width - 200, 30); // Mantido
  text("CRIAR", width - 100, 30); // Mantido
  textAlign(LEFT, TOP);

  float escL = 1280.0 / 1000.0;  // escala largura = 1.28
  float escA = 720.0 / 600.0;    // escala altura = 1.2

  // Ícones
  float iconW = 200 * escL;

  // Talão
  float talaoW = iconW;
  float talaoH = talao.height * (talaoW / talao.width);
  float talaoX = width * 0.3;
  float talaoY = height * 0.2;

  fill(255);
  noStroke();
  rectMode(CENTER);
  rect(talaoX + talaoW / 2, talaoY + talaoH / 2, talaoW + 20 * escL, talaoH + 20 * escA);

  image(talao, talaoX, talaoY, talaoW, talaoH);

  // Bolso
  float bolsoW = iconW;
  float bolsoH = bolso.height * (bolsoW / bolso.width);
  float bolsoX = width * 0.7;
  float bolsoY = talaoY;

  image(bolso, bolsoX, bolsoY, bolsoW, bolsoH);

  // Sacos
  float sacosW = 250 * escL;
  float sacosH = sacos.height * (sacosW / sacos.width);
  float sacosX = width * 0.05;
  float sacosY = height * 0.55;

  image(sacos, sacosX, sacosY, sacosW, sacosH);

  // Fita
  float fitaW = 230 * escL;
  float fitaH = fita.height * (fitaW / fita.width);
  float fitaX = width * 0.5;
  float fitaY = sacosY;
  image(fita, fitaX, fitaY, fitaW, fitaH);
  
  if(mouseX > width - 200 - 25 && mouseX < width - 200 + 25 && mouseY > 30 - 10 && mouseY < 30 + 10){
    if(mousePressed)
      page = 2;
  } else if(mouseX > width - 100 - 25 && mouseX < width - 100 + 25 && mouseY > 30 - 10 && mouseY < 30 + 10){
    if(mousePressed)
      page = 3;
  } else {
    if(mousePressed)
      page = 4;
  }
}

void drawPage4() {
  float logoX = 85;  // ajuste horizontal
  float logoY = 100;  // ajuste vertical
  image(logo, logoX, logoY, logo.width * 0.5, logo.height * 0.5);  // ajuste o scale
  
  fill(0);
  textSize(16);
  textAlign(LEFT, TOP);
  text("PASSO 1: ENCONTRA IMAGENS QUE ADORES", 125, 550);
  text("PASSO 2: COLOCA-AS TODAS NUMA PASTA", 125, 580);
  text("PASSO 3: PRESSIONA O BOTÃO INDICADO E ESCOLHE A PASTA COM AS TUAS IMAGENS", 125, 610);
  text("PASSO 4: VÊ A MAGIA ACONTECER", 125, 640);

  float w = 80;
  float h = logoSmall.height * (w / logoSmall.width);
  image(logoSmall, 40, 30, w, h);

  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("SOBRE", width - 200, 30); // Mantido
  text("CRIAR", width - 100, 30); // Mantido

  fill(255);
  stroke(0);
  strokeWeight(2);
  float rx = width - 250;
  float ry = height - 120;
  float rh = 80;
  float rw = 200;
  rect(rx, ry, rw, rh);
  
  fill(0);
  textSize(16);
  rectMode(CORNER);
  text("CARREGAR\nIMAGEM", rx + rw/2, ry + rh/2);
  
  image(uploadIcon, width - 90, height - 105, 55, 50);
  
  if(mouseX > width - 200 - 25 && mouseX < width - 200 + 25 && mouseY > 30 - 10 && mouseY < 30 + 10){
    if(mousePressed)
      page = 2;
  } else if(mouseX > width - 100 - 25 && mouseX < width - 100 + 25 && mouseY > 30 - 10 && mouseY < 30 + 10){
    if(mousePressed)
      page = 3;
  }
}

void folderSelected(File folder) {
  if (folder == null) {
    println("No folder was selected.");
    exit();
  } else {
    // Filter image files (jpg, png, etc.)
    imageFiles = folder.listFiles();
    imageFiles = folder.listFiles(new FilenameFilter() {
      public boolean accept(File dir, String name) {
        name = name.toLowerCase();
        return name.endsWith(".jpg") || name.endsWith(".jpeg") || name.endsWith(".png") || name.endsWith(".gif");
      }
    });
    shapes = new ArrayList<Contour>();
    colors = new IntList();
  
    for (int i = 0; i < imageFiles.length; i++) {
      PImage img = loadImage(imageFiles[i].getAbsolutePath());
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
  
    page = 5;
  }
}

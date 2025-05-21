// This class enables the evaluation of individuals (harmonographs).
class Evaluator {
  
  PImage target_image; // Image of the target image
  int[] target_pixels_brightness; // Array with the brigness values of the target images
  
  Evaluator(PImage image) {
    target_image = image.copy(); // Get a clean copy of the target image
    target_pixels_brightness = getPixelsBrightness(target_image); // Get brightness values of the target image
  }
  
  // Calculate the fitness of a given individual (this is the fitness function)
  float calculateFitness(Module indiv) {
    PImage phenotype = indiv.getPhenotype(target_image.height);
    int[] phenotype_pixels_brightness = getPixelsBrightness(phenotype);
    float structureScore = getSimilarityRMSE(target_pixels_brightness, phenotype_pixels_brightness, 255);
    float colorScore = getSimilarityRMSE_RGB(target_image, phenotype, 255);
    return 0.7 * structureScore + 0.3 * colorScore;
  }
  
  // Calculate the brighness values of a given image
  int[] getPixelsBrightness(PImage image) {
    int[] pixels_brightness = new int[image.pixels.length];
    for (int i = 0; i < image.pixels.length; i++) {
      pixels_brightness[i] = image.pixels[i] & 0xFF; // Use the blue channel to estimate brighness (very fast to calculate)
    }
    return pixels_brightness;
  }
  
  // Calculate the normalised similarity between two samples (pixels brighenss values)
  float getSimilarityRMSE(int[] sample1, int[] sample2, double max_rmse) {
    float rmse = 0;
    float diff;
    for (int i = 0; i < sample1.length; i++) {
      diff = sample1[i] - sample2[i];
      rmse += diff * diff;
    }
    rmse = sqrt(rmse / sample1.length);
    rmse /= max_rmse; // Normalise rmse
    return 1 - rmse; // Invert the result since we want the similarity and not the difference
  }
  
  float getSimilarityRMSE_RGB(PImage img1, PImage img2, float max_rmse_per_channel) {
    img1.loadPixels();
    img2.loadPixels();
    
    float total_rmse = 0;
    for (int i = 0; i < img1.pixels.length; i++) {
      color c1 = img1.pixels[i];
      color c2 = img2.pixels[i];
      
      float dr = red(c1) - red(c2);
      float dg = green(c1) - green(c2);
      float db = blue(c1) - blue(c2);
      
      total_rmse += dr * dr + dg * dg + db * db;
    }
    
    total_rmse = sqrt(total_rmse / (img1.pixels.length * 3));
    total_rmse /= max_rmse_per_channel;
    return 1 - total_rmse;
  }

}

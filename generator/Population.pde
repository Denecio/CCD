import java.util.*; // Needed to sort arrays

int population_size = 50;
int elite_size = 2;
int tournament_size = 4;

class Population {
  Module[] individuals;
  Evaluator eval;
  int generations;
  PImage baseImage;
  
  Population(PImage base) {
    baseImage = base.copy();
    individuals = new Module[population_size];
    eval = new Evaluator(baseImage);
    initialize();
  }
  
  void initialize(){
    
    for (int i = 0; i < individuals.length; i++){
      individuals[i] = new Module(baseImage);
    }
    
    for (int i = 0; i < individuals.length; i++){
      float fitness = eval.calculateFitness(individuals[i]);
      individuals[i].setFitness(fitness);
    }
    
    sortIndividualsByFitness();
    
    generations = 0;
  }
  
  void evolve(){
    Module[] new_gen = new Module[individuals.length];
    
    for(int i = 0; i < elite_size; i++){
      new_gen[i] = individuals[i].getCopy();
    }
    
    for(int i = elite_size; i < new_gen.length; i++){
      if (random(1) <= crossover_rate){
        Module p1 = tournamentSelection();
        Module p2 = tournamentSelection();
        Module child = p1.uniformCrossover(p2);
        new_gen[i] = child;
      } else {
        new_gen[i] = tournamentSelection().getCopy();
      }
    }
    
    for(int i = elite_size; i <new_gen.length; i++){
      new_gen[i].mutate();
    }
    
    for(int i = elite_size; i <new_gen.length; i++){
      float f = eval.calculateFitness(new_gen[i]);
      new_gen[i].setFitness(f);
    }
    
    for(int i = 0; i < individuals.length; i++){
      individuals[i] = new_gen[i];
    }
    
    sortIndividualsByFitness();
    
    generations++;
  }
  
  Module tournamentSelection(){
    Module [] tournament = new Module[tournament_size];
    
    for(int i = 0; i < tournament.length; i++){
      int index = int(random(0, individuals.length));
      tournament[i] = individuals[index];
    }
    
    Module fittest = tournament[0];
    for(int i = 1; i< tournament.length; i++){
      if(tournament[i].getFitness() > fittest.getFitness()){
        fittest = tournament[i];
      } 
    }
    return fittest;
  }
  
 
  void sortIndividualsByFitness(){
    Arrays.sort(individuals, new Comparator<Module>(){
      public int compare(Module indiv1, Module indiv2){
        return Float.compare(indiv2.getFitness(), indiv1.getFitness());
      }
    });
  }
  
  Module getIndiv(int index){
    return individuals[index];
  }
  
  int getSize(){
    return individuals.length;
  }
  
  int getGenerations(){
    return generations;
  }
}

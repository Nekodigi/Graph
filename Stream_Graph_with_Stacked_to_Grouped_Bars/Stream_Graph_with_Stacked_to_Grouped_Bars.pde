//inspired by these site https://observablehq.com/@d3/streamgraph-transitions
//https://observablehq.com/@d3/stacked-to-grouped-bars
int res = 100;
int ng = 10;//number of graph
float nsize = 1;//noise size 0.1
float zoff = 0;
ArrayList<Graph> graphs = new ArrayList<Graph>();

void setup(){
  size(500, 500);
  //fullScreen();
  noiseDetail(2);
  blendMode(ADD);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
  for(int i=0; i<ng; i++){
    graphs.add(new Graph());
  }
}

void keyPressed(){
  if(key == 'r'){
    graphs = new ArrayList<Graph>();
    for(int i=0; i<ng; i++){
      graphs.add(new Graph());
    }
  }
}

void draw(){
  background(0);
  for(Graph graph : graphs){
    graph.update();
  }
  for(Graph graph : graphs){
    //graph.show();
  }
  float[] biases = new float[res+1];
  for(int i=0; i<ng; i++){
    Graph graph = graphs.get(i);
    biases = graph.showBiasedData(biases,0.5+sin(float(frameCount)/100)*0.5);
  }
  zoff += 0.01;
}

class Graph{
  color col;
  float toff;//this graph zoffset
  float[] datas = new float[res+1];
  
  Graph(){
    col = color(random(360), 100, random(20, 100));
    toff = random(10);
  }
  
  void update(){
    for(int i=0; i<=res; i++){
      float x = map(i, 0, res, 0, width);
      float y = noise(x/res*nsize+toff, zoff)*height/5;
      datas[i] = y;
    }
  }
  
  float[] showBiasedData(float[] biases, float fac){
    float[] results = new float[res+1];
    for(int i=0; i<=res; i++){
      results[i] = datas[i] + biases[i];
    }
    fill(col);
    beginShape();
    for(int i=0; i<=res; i++){
      float x = map(i, 0, res, 0, width);
      float y = biases[i]*fac;
      vertex(x, height-y);
    }
    for(int i=res; i>=0; i--){
      float x = map(i, 0, res, 0, width);
      float y = datas[i] + biases[i]*fac;
      vertex(x, height-y);
    }
    endShape();
    return results;
  }
  
  void show(){
    fill(col);
    beginShape();
    vertex(0, height);
    for(int i=0; i<=res; i++){
      float x = map(i, 0, res, 0, width);
      float y = datas[i];
      vertex(x, height-y);
    }
    vertex(width, height);
    endShape();
  }
}

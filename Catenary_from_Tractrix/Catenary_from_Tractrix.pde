//based on this site jp https://ja.wikipedia.org/wiki/%E3%83%88%E3%83%A9%E3%82%AF%E3%83%88%E3%83%AA%E3%83%83%E3%82%AF%E3%82%B9
//en https://en.wikipedia.org/wiki/Tractrix
float scale = 100;
float range = 4;

void setup(){
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
  background(360);
  translate(width/2, 0);
  noFill();
  beginShape();
  for(float t=-range; t<range; t+=0.01){
    PVector pos = tractrix(1, t);
    println(pos);
    vertex(pos.x*scale, height-pos.y*scale);//show tractrix
  }
  endShape();
  beginShape();
  for(float t=-range; t<range; t+=0.01){
    PVector pos = catenary(1, t);
    println(pos);
    vertex(pos.x*scale, height-pos.y*scale);//catenary ground truth
  }
  endShape();
  beginShape();
  for(float t=-range; t<range; t+=0.1){
    if(abs(t) < EPSILON)continue;//to avoid wired result.
    PVector post = tractrix(1, t);
    
    //catenary from evolute
    PVector pos = evolute(1, t);
    //vertex(pos.x*scale, height-pos.y*scale);
    
    //catenary from normal
    PVector normalv = normal(1, t).mult(-10);//for comparing. We can estimate using normal    
    float hue = map(t, -range, range, 0, 360);
    stroke(hue, 100, 100);
    line(post.x*scale, height-post.y*scale, (post.x+normalv.x)*scale, height-(post.y+normalv.y)*scale);
  }
  stroke(0, 100, 100);
  endShape();
}

PVector evolute(float a, float t){//tractrix's evolute
  PVector p0 = tractrix(a, t-EPSILON*10);
  PVector p1 = tractrix(a, t);
  PVector p2 = tractrix(a, t+EPSILON*10);
  return circle3p(p0, p1, p2);
}

PVector normal(float a, float t){//tractrix's normal
  PVector p0 = tractrix(a, t-EPSILON);
  PVector p1 = tractrix(a, t+EPSILON);
  return new PVector(-(p0.y-p1.y), (p0.x-p1.x)).normalize();
}

PVector tractrix(float a, float t){//https://mathworld.wolfram.com/Tractrix.html
  float x = a*(t - (float)Math.tanh(t));
  float y = a/(float)Math.cosh(t);//sech = 1/cosh
  return new PVector(x, y);
}
//for ground truth
PVector catenary(float a, float t){//https://mathworld.wolfram.com/Tractrix.html
  float x = t;
  float y = a*(float)Math.cosh(t/a);//sech = 1/cosh
  return new PVector(x, y);
}

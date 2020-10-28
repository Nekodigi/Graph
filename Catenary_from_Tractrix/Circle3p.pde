//based on this site https://www.geeksforgeeks.org/equation-of-circle-when-three-points-on-the-circle-are-given/#:~:text=Equation%20of%20circle%20in%20general,and%20r%20is%20the%20radius.&text=Radius%20%3D%201-,The%20equation%20of%20the%20circle,2%20%2B%20y2%20%3D%201.
PVector circle3p(PVector a, PVector b, PVector c){//circle passing through 3 point
  float x12 = a.x - b.x;
  float x13 = a.x - c.x;
  
  float y12 = a.y - b.y;
  float y13 = a.y - c.y;
  
  float y31 = c.y - a.y;
  float y21 = b.y - a.y;
  
  float x31 = c.x - a.x;
  float x21 = b.x - a.x;
  
  float sx13 = a.x*a.x - c.x*c.x;
  float sy13 = a.y*a.y - c.y*c.y;
  float sx21 = b.x*b.x - a.x*a.x;
  float sy21 = b.y*b.y - a.y*a.y;
  
  float f = (sx13*x12 + sy13 * x12 + sx21 * x13 + sy21 * x13) 
            / (2 * (y31 * x12 - y21 * x13)); 
  float g = (sx13 * y12 + sy13 * y12 + sx21 * y13 + sy21 * y13) 
          / (2 * (x31 * y12 - x21 * y13)); 

  float ct = -a.x*a.x - a.y*a.y - 2 * g * a.x - 2 * f * a.y; 

  // eqn of circle be x^2 + y^2 + 2*g*x + 2*f*y + c = 0 
  // where centre is (h = -g, k = -f) and radius r 
  // as r^2 = h^2 + k^2 - c 
  float h = -g; 
  float k = -f; 
  float sqr_of_r = h * h + k * k - ct; 

  // r is the radius 
  float r = sqrt(sqr_of_r); 
  
  return new PVector(h, k, r);//use z as r
}

float[] xHeptPoints = new float[8];    // x values of heptagon points
float[] yHeptPoints = new float[8];    // y values of heptagon points
int[] plotOrder = {1,4,7,3,6,2,5,1};   //order of heptagon points for black dots to follow

//y and y values for the moving black dots
float[] tempX = new float[12];
float[] tempY= new float[12];

int[] distTravelled = new int[12]; //array to store % distance between the points to plot the circles
int[] frms = new int[12];  //variable counts #frames up in hundreds

//12 moving dots - hold x and y locations
float[][] xLocationDots = new float[12][2];

int counter1[] = new int[12];  //counts which of the 7 lines the circle moves along
int counter2[] = new int[12];  //counts the number of times the circle moves along all 7 lines
int counterTravelled[] = new int[12];  //counts the number of lines already travelled for all circles > 0

void setup()
{
  size(600,600);    //canvas size
  
  for (int i=1; i<12; i++) {
    int val = ((700/12)*i);
    counterTravelled[i] = val / 100;
    distTravelled[i] = val % 100;
  }
}

void draw()
{
  background(155);
  fill(256);
  pushMatrix();
  translate(width*0.5, height*0.5);
  polygon(0, 0, 200, 7);                // call polygon method
  drawPolyGuides();  //draw the guides for the dots to move along
  blackDots();
  popMatrix();  
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  int counter = 0;  // variable for switching between heptagon points
  for (float a = 0; a < TWO_PI; a += angle)
  {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
    xHeptPoints[counter] = sx;    // store x values of heptagon points in array
    yHeptPoints[counter] = sy;    // store y values of heptagon points in array
    counter++;
  }
  endShape(CLOSE);
}

void drawPolyGuides()
{
  stroke(0);
  for (int i=0; i<7; i++)
  {
    line(xHeptPoints[(plotOrder[i])], yHeptPoints[(plotOrder[i])], xHeptPoints[(plotOrder[i+1])], yHeptPoints[(plotOrder[i+1])]);
  }
}



void blackDots(){
  
  for (int a = 0; a<2 ; a++)
  {
  
    //old solution - works with one dot
    
    int i = counter1[a];    //easier to use i as a variable for the if statement below :)
  
    if(counter2[0] < 1){
      frms[0] = (frameCount - (100*counter1[0]));
    }
  
    if(counter2[0] > 0){
      frms[0] = (frameCount - (100*counter1[0]) - (700*counter2[0]));
    }
  
  
    if((frms[0]+distTravelled[a])*0.01 < 1){
      tempX[a] = xHeptPoints[(plotOrder[i])] + (frms[0]+distTravelled[a])*0.01*(xHeptPoints[(plotOrder[i+1])] -xHeptPoints[(plotOrder[i])]);
      tempY[a] = yHeptPoints[(plotOrder[i])] + (frms[0]+distTravelled[a])*0.01*(yHeptPoints[(plotOrder[i+1])] -yHeptPoints[(plotOrder[i])]);
  }
  
    if((frms[0]+distTravelled[a])*0.01 > 1){
    tempX[a] = xHeptPoints[(plotOrder[i])] + (frms[0]+distTravelled[a])*0.01*(xHeptPoints[(plotOrder[i+1])] -xHeptPoints[(plotOrder[i])]);
    tempY[a] = yHeptPoints[(plotOrder[i])] + (frms[0]+distTravelled[a])*0.01*(yHeptPoints[(plotOrder[i+1])] -yHeptPoints[(plotOrder[i])]);
  }
  
    if(((frms[0]+distTravelled[a])*0.01) >= 1){
      counter1[a]++;
    }
  
    if(counter1[a] == 7){
      counter2[a] ++;
      counter1[a] = 0;
    }
    
    fill(0);
    for (int b = 0; b<12 ; b++){
      ellipse(tempX[b], tempY[b], 7, 7);    //draw circle
    }
  }
}

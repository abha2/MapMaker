int tempX[]={1087,980,955,1114, 1040};
int tempY[]={515,515,435,435,380};

//diversity,transport,skills,funding,leisure,middle
int vertX[]={1064,987,964,1087,1026,1026};
int vertY[]={522,522,450,450,407,469};
void drawSpiderPlot(int no)
{
    PImage img;
    textFont(f);
    fill(200);
    textAlign(CENTER);
    for (int i=0; i<5; i++)
    {
      img=loadImage(variables[i]);
      img.resize(varHt[i]*7/10,varLen[i]*7/10);
      tint(150);
      image(img, tempX[i]*0.982,tempY[i]);
    }
    polygon(5,1025,467,130,130,-PI/2.0);
    polygon(5,1025,467,100,100,-PI/2.0);
    polygon(5,1025,467,70,70,-PI/2.0);
    polygon(5,1025,467,40,40,-PI/2.0);
    addTriangle(no);
}


void polygon(int n, float cx, float cy, float w, float h, float startAngle) 
{
  float angle = TWO_PI/ n;

  // The horizontal "radius" is one half the width,
  // the vertical "radius" is one half the height
  w = w / 2.0;
  h = h / 2.0;

  beginShape();
  for (int i = 0; i < n; i++) 
  {
    vertex(cx + w * cos(startAngle + angle * i), cy + h * sin(startAngle + angle * i));
    fill(40);
    strokeWeight(1);
    stroke(170);
  }
  endShape(CLOSE);
}

void addTriangle(int no)
{
    float val[]={values.getFloat(no,"demo"),values.getFloat(no,"transport"), values.getFloat(no,"sked"), 
     values.getFloat(no,"funding"), values.getFloat(no,"leisure")};
    float a,b;
    float P[]=new float[5], Q[]=new float[5];
    for(int i=0;i<5;i++)
    {
      if(val[i]==-1)
        val[i]=0;
      b=val[i]*(vertX[i]-vertX[5]);
      a=val[i]*(vertY[i]-vertY[5]);
      P[i]=vertX[5]+b;
      Q[i]=vertY[5]+a;
    }
    stroke(200);
    fillTriangle((val[0]+val[1])/2);
    triangle(P[0], Q[0], vertX[5], vertY[5], P[1],Q[1]); //Demo and Trans
    fillTriangle((val[0]+val[3])/2);
    triangle(P[0], Q[0], vertX[5], vertY[5], P[3],Q[3]); //Demo and Funding
    fillTriangle((val[1]+val[2])/2);
    triangle(P[2], Q[2], vertX[5], vertY[5], P[1],Q[1]); //Skills and Trans
    fillTriangle((val[2]+val[4])/2);
    triangle(P[2], Q[2], vertX[5], vertY[5], P[4],Q[4]);//Skills and Leisure
    fillTriangle((val[3]+val[4])/2);
    triangle(P[3], Q[3], vertX[5], vertY[5], P[4],Q[4]); //Leisure and funding
}

void fillTriangle(float val)
{
    
  if(val<0)
  {
      fill(colors[11],100);
  }
  else if(val<=0.25)
  {
      fill(colors[2],100);
  }
  else if(val<=0.5)
  {
      fill(colors[4],100);
  }
  else if(val<=0.75)
  {
      fill(colors[7],100);
  }
  else if(val<=1)
  {
      fill(colors[10],100);
  }
}

float distTwoPoints(int px, int py, int qx, int qy)
{
  return (float)Math.sqrt((py-qy)*(py-qy) + (px-qx)*(px-qx));
}
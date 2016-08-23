//create and store the shapes for all the neighborhoods
void drawPolygons(int special, boolean black)
{
  int shapeNo=0;
  print("poly");
  shapes[shapeNo]=createShape();
  shapes[shapeNo].beginShape();
  shapes[shapeNo].colorMode(RGB);
  fillColor(shapes[shapeNo], shapeNo,180, black);
  shapes[shapeNo].stroke(0); 
  shapes[shapeNo].strokeWeight(1.25);
  if(special==shapeNo)
  {
    shapes[shapeNo].stroke(250);  
    shapes[shapeNo].strokeWeight(1.75);
  }
  for(int i = 0; i<map.getRowCount()-1; i++)
  {
         if(map.getFloat(i, "shapeid") == map.getFloat(i+1, "shapeid"))
         {
           PVector Start = mercatorMap.getScreenLocation(new PVector(map.getFloat(i, "y"), map.getFloat(i, "x")));
           shapes[shapeNo].vertex(Start.x, Start.y);
         }
         else
         {
           shapes[shapeNo].endShape(CLOSE);
           shapeNo++;
           shapes[shapeNo]=createShape();
           shapes[shapeNo].beginShape();
           //shapes[shapeNo].colorMode(RGB);
           //depending on value of creativity fill with different colors
           //pick color as per creativity index
           fillColor(shapes[shapeNo], shapeNo, 180, black);
           shapes[shapeNo].strokeWeight(1.25);
           shapes[shapeNo].stroke(0);
           if(special==shapeNo)
           {
             shapes[shapeNo].stroke(250);
             shapes[shapeNo].strokeWeight(1.75);
           } 
           
         }
  }
  shapes[shapeNo].endShape(CLOSE);
  drawShapes();
}

//loop through shape array to print all of them
void drawShapes()
{
  for(int i=0;i<neighborhoods;i++)
    shape(shapes[i]);
}

//decide the color of each neighborhood depending on creativity potential
void fillColor(PShape sh, int no, float alpha, boolean black)
{
  float ele=scaledCr[no];
  //for the weird hands of south boston
  if(no==31)
  {
    sh.fill(0);
    return;
  }
 if(ele==-1 || allFalse()==true || black==true)
   sh.fill(colors[11]);
 else if(ele<0) 
    sh.fill(colors[0],alpha);
  else if(ele<=0.1) 
    sh.fill(colors[1],alpha);
  else if(ele<=0.2) 
    sh.fill(colors[2],alpha);
  else if(ele<=0.3) 
    sh.fill(colors[3],alpha);
  else if(ele<=0.4)
    sh.fill(colors[4],alpha);
  else if(ele<=0.5) 
    sh.fill(colors[5],alpha);
  else if(ele<=0.6)  
    sh.fill(colors[6],alpha);
  else if(ele<=0.7) 
    sh.fill(colors[7],alpha); 
  else if(ele<=0.8) 
    sh.fill(colors[8],alpha);
  else if(ele<=0.9) 
    sh.fill(colors[9],alpha);
  else if(ele>0.9 && ele<=1.1)
    sh.fill(colors[10],alpha);
  else
  {
    sh.fill(255,alpha);
  }
}

//Draw the option list lower right corner
void chooseOptions()
{
  
  //rect(870,10,320,680,25);

  int tempX[]={820,820,823,823,823,820};
  int tempY[]={80,110,145,180,215, 30};
    stroke(150);
    line(815,70, 855, 70);
    PImage img;
    for (int i=0; i<variables.length; i++)
    {
      //x[i]=1190;
      x[i]=tempX[i];
      y[i]=tempY[i];  //110+(sum+20*i);
      img=loadImage(variables[i]);
      img.resize(varHt[i],varLen[i]);
      tint(150);
      image(img, x[i],y[i]);
    }
}


void printInterventions(int no)
{
  String s= " Proposed Interventions: "+values.getString(no,"name");
  String i1=values.getString(no, "Idemo"), i2=values.getString(no, "Itrans"), i3=values.getString(no, "Iskills");
  String i4=values.getString(no, "Ifund"), i5=values.getString(no, "Ileis"), i6=values.getString(no,"Icreative");
  printInfo(no);
  stroke(0);
  fill(230);
  textAlign(CENTER);
  textSize(12);
  text(s, 1070-s.length(),360);
  textAlign(LEFT);
  textSize(9);
  //text(deets, 630, 535);
  text(i1, 900, 550);
  text(i2, 900, 575);
  text(i3, 900, 600);
  text(i4, 900, 625);
  text(i5, 900, 650);
  text(i6, 900, 678);
  drawSpiderPlot(no);

}

void printInfo(int no)
{
  int i;
  PImage img;
  float val;
  for(i=0;i<variables.length;i++)
  {
    img=loadImage(variables[i]);
    img.resize(varHt[i]*6/10,varLen[i]*6/10);
    //Get value for each dimension
    if(i==0)
      val=values.getFloat(no,"demo");
    else if(i==1)
       val=values.getFloat(no,"transport");
    else if(i==2)
      val=values.getFloat(no,"sked");
    else if(i==3)
      val=values.getFloat(no,"funding");
    else if(i==4)
      val=values.getFloat(no,"leisure");
    else
      val=values.getFloat(no,"total");
    //fill color as per value
    if(val<0)
      tint(colors[11]);
    else if(val<=0.25)
      tint(colors[2]);
    else if(val<=0.5)
      tint(colors[4]);
    else if(val<=0.75)
      tint(colors[7]);
    else if(val<=1)
      tint(colors[10]);
    image(img, 880, 540+i*25);
  }
}

void printIntroduction()
{
  PImage img;
  int i;
  String intro="Creativity Potential in Boston and Cambridge Neighborhoods";
  String matter[]=loadStrings("CreativeCities.txt");
  textAlign(CENTER);
  textSize(12);
  fill(250);
  text(intro, 885, 25, 290, 100);
  textSize(10.5);
  textAlign(LEFT);
  text(matter[0], 885, 70, 300, 200);
  textSize(9.5);
  fill(200);
  text(matter[1],885, 110, 290, 500);
  for(i=0;i<variables.length;i++)
  {
    img=loadImage(variables[i]);
    img.resize(varHt[i]*6/10,varLen[i]*6/10);
    image(img, 950, 210+i*20);
    textAlign(LEFT);
    text(tagLines[i], 970, 223+i*20);
  }
}

void clearArea()
{
  fill(40);
  stroke(40);
  rect(870,10,320,680,25);
  
  printIntroduction();

}

void clearChoices(int i)
{
  fill(32);
  stroke(32);
  rect(x[i]-3,y[i]-4,varLen[i]+10,varHt[i]+4);
}

//draw key explaining colors upper right corner
void drawKey()
{
    int latitude=650, longitude=555;
    fill(32);
    rect(335,640,275,100,10);
    textFont(g);
    fill(#E8E7E3);
    textAlign(LEFT);
    println("key printed");
    text("CREATIVITY", 355,latitude+17.5);
    text("POTENTIAL", 355,latitude+32.5);
    longitude=longitude-125;
    latitude=latitude+10;
    //-1
    fill(colors[11]);
    rect(longitude+150,latitude,10,10);
    fill(#E8E7E3);
    text("N/A", longitude+145, latitude+25);
    for(int i=0;i<11;i++)
    {
      fill(colors[i],200);
      rect(longitude+((i+1)*10),latitude,10,10);
    }
    fill(#E8E7E3);
    text("0", longitude+10, latitude+25);
    text("0.5 ", longitude+55, latitude+25);
    text("1", longitude+115, latitude+25);   
}


void drawWater()
{
  int no=0;
  print("poly");
  water[no]=createShape();
  water[no].beginShape();
  fill(#19B5FE,150);
  for(int i = 0; i<waterMap.getRowCount()-1; i++)
  {
         if(waterMap.getFloat(i, "shapeid") == waterMap.getFloat(i+1, "shapeid"))
         {
           PVector Start = mercatorMap.getScreenLocation(new PVector(waterMap.getFloat(i, "y"), waterMap.getFloat(i, "x")));
           water[no].vertex(Start.x, Start.y);
         }
         else
         {
           water[no].endShape(CLOSE);
           no++;
           println(no);
           water[no]=createShape();
           water[no].beginShape();
         }
  }
  water[no].endShape(CLOSE);
  drawWaters();
}

void drawWaters()
{
  for(int i=0;i<1314;i++)
    shape(water[i]);
}

void drawLines()
{
  println("lines rendering");
      for(int i = 0; i<waterMap.getRowCount()-1; i++)
      { 
         if(waterMap.getInt(i, "shapeid") == waterMap.getInt(i+1, "shapeid") && int(waterMap.getInt(i, "shapeid"))==waterMap.getInt(i, "shapeid"))
         {
                stroke(#00ffff);
                strokeWeight(.5);
                PVector Start = mercatorMap.getScreenLocation(new PVector(waterMap.getFloat(i, "y"), waterMap.getFloat(i, "x")));
                PVector End = mercatorMap.getScreenLocation(new PVector(waterMap.getFloat(i+1, "y"), waterMap.getFloat(i+1, "x")));
                line(Start.x, Start.y, End.x, End.y);
            }
         }
               
  println("lines drawn");
}

void drawColleges()
{
  PVector MIT = mercatorMap.getScreenLocation(new PVector(42.36, -71.09)),
  harvard=mercatorMap.getScreenLocation(new PVector(42.377, -71.1167)),
  bu=mercatorMap.getScreenLocation(new PVector(42.3505, -71.1054)),
  northeastern=mercatorMap.getScreenLocation(new PVector(42.3398, -71.089)),
  umb=mercatorMap.getScreenLocation(new PVector(42.3122, -71.035));
  
  fill(#9B59B6); //purple
  //fill(#40BEFF); //light blue
  //fill(#0805FA); //dark blue
  noStroke();
  ellipse(MIT.x, MIT.y,7,7);
  ellipse(harvard.x, harvard.y,7,7);
  ellipse(bu.x, bu.y,7,7);
  ellipse(northeastern.x, northeastern.y,7,7);
  ellipse(umb.x, umb.y,7,7);
  fill(250);
  textSize(11);
  textAlign(CENTER);
  text("MIT", MIT.x, MIT.y);
  text("Harvard University",harvard.x, harvard.y);
  text("Boston University",bu.x, bu.y);
  text("Northeastern University",northeastern.x, northeastern.y);
  text("U. of Massachussets, Boston",umb.x, umb.y);
}
  
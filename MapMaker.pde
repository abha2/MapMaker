import javax.swing.JFrame;

PImage Map;
MercatorMap mercatorMap;

boolean initialized = false;
boolean corners = true;
boolean center = false;
boolean pixilizer = false;
boolean found=false;

//Past clicks to see if a neighborhood has been clicked 
int pastClick=-1;

float Top_lat, Bottom_lat, Right_lon, Left_lon;

//Values for canvas
float aspect = .666;
float areawidth, areaheight;

//center values
PVector Center, top_left_corner, bottom_right_corner, top_right_corner, bottom_left_corner;
PFont f,g;

//Dimensions
String variables[] = {"demo.png" , "transport.png", "skills.png", "funds.png", "leis.png", "creative.png"};
String tagLines[]={"More differences, more ideas", "Stuck in traffic or thoughts?", "Mind, hand, and creativity",
"Resources for creativity", "Breathe, relax, and be creative", "Creativity Potential"};
int varLen[]= {21,21,23,23,23,33}, varHt[]={29,29,23,23,23,33};
int x[]=new int[6], y[]=new int[6];
boolean activate[]= {false, false , false , false , false, false};
int[][]expansions = {{1078,523},{1114,548}, {1145,570}, {1124,597}};

color[] colors=new color[12];

//no of neighborhoods
int neighborhoods; 

//coordinates of neighborhoods
PShape[] shapes,water;

//Needed Java classes
import java.util.Set;
import java.util.HashSet;

void setup() {
  
    //boston map
    Top_lat = 42.4064;
    Bottom_lat = 42.2270;
    Left_lon = -71.1945; 
    Right_lon = -70.8744;
    
    //San Fran map
    /*Left_lon= -122.5484;
    Right_lon= -122.3389;
    Top_lat= 37.8553;
    Bottom_lat= 37.6836;*/

  top_left_corner = new PVector(Top_lat, Left_lon);
  top_right_corner = new PVector(Top_lat, Right_lon);
  bottom_left_corner = new PVector(Bottom_lat, Left_lon);
  bottom_right_corner = new PVector(Bottom_lat, Right_lon);
  f = createFont("Garamond Bold", 13);
  g= createFont("Garamond Bold", 10);
  size(1200, 700); 
      
  initData();
  neighborhoods=values.getRowCount();
  shapes= new PShape[neighborhoods];
  water= new PShape[1314];
  colors[0]=#D91E18; //Thunderbird
  colors[1]=#EF4836; //Flamingo
  colors[2]=#EC644B; //Soft Red
  colors[3]=#E87E04; //Tahiti Gold
  colors[4]=#F89406; //California
  colors[5]=#F39C12; //Buttercup
  colors[6]=#F9BF3B; //Sandstorm
  colors[7]=#F7CA18; //Ripe Lemon
  colors[8]=#87D37C; //Gossip
  colors[9]=#2ECC71; //Shamrock
  colors[10]=#00B16A; //Jade
  colors[11]=#ABB7B7; //gray
  constructor();
  smooth();
}

void draw() { 
  if(!initialized)
  {
    //background images
      background(0);
      //mercatorMap 
       mercatorMap = new MercatorMap(960, 660, Top_lat, Bottom_lat, Left_lon, Right_lon);
       //drawWater();
       drawPolygons(-1, true);
        println(frameRate);
        drawKey();
        fill(32);
        stroke(32);
        rect(800, 10, 100, 245, 25);
        fill(40);
        rect(870,10,320,680,25);
        fill(200);
        text("by Abha Laddha, MIT Media Lab: Changing Places", 10,690);
        chooseOptions();
        printIntroduction();
        drawColleges();
        println("Initialized");
        initialized = true;  
    }
    for(int i=0;i<neighborhoods;i++)
    {
      if(containsPoint(shapes[i], mouseX,mouseY)==true && found==false)
      {
        clearArea();
        printInterventions(i);
      }
    }
}

void mouseClicked()
{
  PImage img;
  int i;
  for(i=0;i<variables.length;i++)
  {
    if(mouseX > x[i] - varLen[i] && mouseX< x[i]+varLen[i] && 
       mouseY > y[i] - varHt[i]  && mouseY < y[i]+varHt[i])
    {
      //clearing old space before new goes in  
      clearChoices(i);
      img=loadImage(variables[i]);
      img.resize(varHt[i],varLen[i]);
        //if not selected then select
        if(activate[i]==false)
        {
          activate[i]=true;
          tint(250);
          fill(250);
        }
        //if already selected then desselect
        else //<>//
        {
          activate[i]=false;
          tint(150);
          fill(150);
        }
        textAlign(CENTER);
        textSize(8.5);
        if(i==5)
          clickedAll(true,activate[i]);
        else
        {
          image(img, x[i],y[i]);
          callFunc(i);
          calcCreativity();
          clickedAll(false,activate[i]);
        }
        drawPolygons(-1, true);
        drawPolygons(-1, false);
        drawColleges();
        return;
    }
  }
   for(i=0;i<neighborhoods;i++)
   {
     if(containsPoint(shapes[i], mouseX,mouseY)==true)
     {
       drawPolygons(-1, true);
       if(found==true && pastClick==i)
       {
         found=false;
         drawPolygons(-1, false);
         drawColleges();
       }
       else 
       {
         clearArea();
         printInterventions(i);
         drawPolygons(i, false);
         shape(shapes[i]);
         drawColleges();
         found=true;
         pastClick=i;
       }
     }
   }
   if(found==false)
      clearArea();
}

//if they click the creativity potential button or unclick it or false if they clicked something else
void clickedAll(boolean fate, boolean active)
{
  int j;
  PImage img;
  if(fate==true)
  {
    reset();
    for(j=0;j<variables.length;j++)
    {
      clearChoices(j);
      if(active==true)
      {
        tint(250);
        fill(250);
        activate[j]=true;
      }
      else
      {
        tint(150);
        fill(150);
        activate[j]=false;
      }
      img=loadImage(variables[j]);
      img.resize(varHt[j],varLen[j]);
      image(img, x[j],y[j]);
      callFunc(j);
    }
    calcCreativity();
  }
  else
  {
    if(allFalse()==true || allTrue()==true)
    {
      clearChoices(5);
      img=loadImage(variables[5]);
      img.resize(varHt[5],varLen[5]);
      image(img, x[5],y[5]);
      if(active==false)
        fill(150);
      else
        fill(250);
      activate[5]=false;
    }
  }
  return;
}

boolean containsPoint(PShape shape,float px,float py)
  {
    int num = shape.getVertexCount();
    int i, j = num - 1;
    boolean contains = false;
    for (i = 0; i < num; i++) 
    {
      PVector vi = shape.getVertex(i);
      PVector vj = shape.getVertex(j);
      if (vi!=null && vj!=null)
      {
        if(vi.y < py && vj.y >= py || vj.y < py && vi.y >= py) 
        {
          if (vi.x + (py - vi.y) / (vj.y - vi.y) * (vj.x - vi.x) < px) 
          {
            contains=!contains;
          }
        }
      }
      j=i;
    }
    return contains;
}

void callFunc(int i)
    {
      switch(i) 
      {
        case 0:
          demographic();
          break;
          
        case 1:
          transport();
          break;
        
        case 2:
          skills();
          break;
        
        case 3:
          funding();
          break;
          
        case 4:
          leisure();
          break;
        case 5:
          break;
        }
    }
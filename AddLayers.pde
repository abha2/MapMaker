float creativity[], scaledCr[];

void constructor()
{
  creativity=new float[neighborhoods];
  scaledCr=new float[neighborhoods];
  for (int i=0;i<neighborhoods;i++)
  {
      creativity[i]=0;
      scaledCr[i]=0;
  }
}
    
void demographic()
{
    float val;
    for(int i = 0; i<neighborhoods; i++)
    {
        val= values.getFloat(i, "demo");
        if(activate[0]==true)
          creativity[i]+=val;
        else
        {
          if(creativity[i]<=0)
            creativity[i]=0;
          else
            creativity[i]-=val;
        }
    }
  //on or off
}

void transport()
{
    float val;
    for(int i = 0; i<neighborhoods; i++)
    {
        val= values.getFloat(i, "transport");
        if(activate[1]==true)
          creativity[i]+=val;
        else
        {
          if(creativity[i]<=0)
            creativity[i]=0;
          else
            creativity[i]-=val;
        }
    }
}


void skills()
{
    float val;
    for(int i = 0; i<neighborhoods; i++)
    {
        val= values.getFloat(i, "sked");
        if(activate[2]==true)
          creativity[i]+=val;
        else
        {
          if(creativity[i]<=0)
            creativity[i]=0;
          else
            creativity[i]-=val;
        }
    }
}

void funding()
{
    float val;
    for(int i = 0; i<neighborhoods; i++)
    {
        val= values.getFloat(i, "funding");
        if(activate[3]==true)
          creativity[i]+=val;
        else
        {
          if(creativity[i]<=0)
            creativity[i]=0;
          else
            creativity[i]-=val;
        }
    }
}

void leisure()
{
    float val;
    for(int i = 0; i<neighborhoods; i++)
    {
        val= values.getFloat(i, "leisure");
        if(activate[4]==true)
          creativity[i]+=val;
        else
        {
          if(creativity[i]<=0)
            creativity[i]=0;
          else
            creativity[i]-=val;
        }
    }
}

void calcCreativity()
{
  int i, count=0;
  for(i=0; i<variables.length-1;i++)
  {
    if(activate[i]==true)
      count++;
  }
  for(i=0;i<neighborhoods;i++)
  {
    if(count!=0)
      scaledCr[i]=creativity[i]/count;
    else
      scaledCr[i]=0;
  }
}

boolean allFalse()
{
  for(int i=0;i<5;i++)
    if(activate[i]==true)
      return false;
  return true;
}

boolean allTrue()
{
  for(int i=0;i<5;i++)
    if(activate[i]==false)
      return false;
  return true;
}

void reset()
{
  for(int i=0;i<neighborhoods;i++)
  {
      creativity[i]=0;
      scaledCr[i]=0;  
  }
}
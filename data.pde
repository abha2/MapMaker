Table map, names, values,waterMap;

void initData(){
     
     //Boston map
     map= loadTable("boston-nodes.csv", "header");
     waterMap=loadTable("water.csv","header");
     values= loadTable("values.csv", "header");
     names=loadTable("boston-attributes.csv","header");
     println("data loaded");
}
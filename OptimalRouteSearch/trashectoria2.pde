//Checar API de mapas Open Map o algo así
//Guardar en .txt el origen y destino
import controlP5.*;
int vExit=8;
int cnt=0;
//Output text
PrintWriter output, starter, ruta;
//Dropdownlist
ControlP5 cp5;
Button btn, btn2;
Button btnGrafica;
//Button
ControlP5 cpB;
DropdownList d1, d2;
//Image object to draw background
PImage img;
//Flags for selected destiny and origin
boolean dest=false;
boolean orig= false;
boolean flagD=false;
int count=0;
//Variables - destiny and origin (x, y)
int [] iniX= new int [2];
int [] iniY= new int[2];
//Location of cities (x, y)
String [] arrX, arrY;
//File with cities
String [] ids;
String[] cities;
String [] route= new String[100];
Float origin, destiny;
boolean flagB =false;
//Exception e;
//Trajectory to follow



void setup(){
  size(1407,717);
  //Loads image to be drawn as background. 
  img= loadImage("mapa.jpg.png"); 
  //Cargo nombres de ciudades
  cities= loadStrings("cities.txt");
  //Cargo coordenadas - mismo orden que cities (cities[0] corresponde a (arrX[0],arrY[0])
  arrX= loadStrings("coordenaxasX.txt");
  arrY= loadStrings("coordenadasY.txt");
  ids= loadStrings("id.txt");
  cp5 = new ControlP5(this);
  //create ddl
  d1= cp5.addDropdownList("ORIGEN").setPosition(100, 400);
  customize(d1);
  d2= cp5.addDropdownList("DESTINO").setPosition(200, 400);
  customize(d2);
  d2.close();
  d1.close();
  //creates button
  btn=cp5.addButton("BUSCAR RUTA").setValue(0).setPosition(100,370).setSize(200,19);
  btnGrafica=cp5.addButton("LIMPIA RUTA").setValue(0).setPosition(100,470).setSize(200,19);

  //comienzo con OUT.TXT en limpio
  starter= createWriter("OUT.TXT");
  starter.print("");
  starter.flush();
  starter.close();
  ruta =createWriter("ruta.txt");
}
void draw(){
    //Draw background
  background(0);
  image(img,0,0,1407,717);
  origin = d1.getValue();
  destiny = d2.getValue();

  if(btn.isPressed()){
    flagB=false;
    output = createWriter("datos.txt");
    output.println(ids[Math.round(origin)]);
    output.println(ids[Math.round(destiny)]);
    output.flush();
    output.close();

    traceRoute();
    flagD=true;
  }

    if(flagD==true){
     route=loadStrings("OUT.TXT"); //recibo IDS que fueron creados por LISP
     ruta =createWriter("ruta.txt");
     beginShape();
     drawRoute();
     endShape();
     drawPoints();
    }
    if(btnGrafica.isPressed()){
      flagB=true;
      flagD=false;
        starter= createWriter("OUT.TXT");
        starter.print("");
        starter.flush();
        starter.close();
        ruta =createWriter("ruta.txt");
    }
}

void drawPoints(){
  int aux=-1;
  noFill();
  strokeWeight(7);
  stroke(255,0,0);
  
  for( int i=0;i< route.length;i++){
      aux= busqueda(route[i]);
        if(aux!= -1){
          points(arrX[aux], arrY[aux]);
        }
        
        else{
          //throw new Exception(); 
          println("ERROR FATAL");
        }
    }
}
void drawRoute(){
  int aux=-1;
  for( int i=0;i< route.length;i++){
      aux= busqueda(route[i]);
        if(aux!= -1){
          if(i==0){
            noFill();
             strokeWeight(4);
             stroke(random(1.f) * 255, random(1.f) * 255, random(1.f) * 255, 255);
            graph(arrX[aux], arrY[aux]);
            
          }if(i==route.length-1){
            noFill();
             strokeWeight(4);
             stroke(random(1.f) * 255, random(1.f) * 255, random(1.f) * 255, 255);
            graph(arrX[aux], arrY[aux]);
          }
              noFill();
             strokeWeight(4);
             stroke(random(1.f) * 255, random(1.f) * 255, random(1.f) * 255, 255);
          graph(arrX[aux], arrY[aux]);
          ruta.println(cities[aux]);
        }
        
        else{
          //throw new Exception(); 
          println("ERROR FATAL");
        }
    }
    ruta.close();
}
 
void traceRoute(){
Runtime r=Runtime.getRuntime();
Process p1;
//if(vExit!=0){
  try{
    p1 = r.exec("cmd /c start C:/Users/Mariana/Documents/trashectoria2/puto.bat");
    //Thread.sleep(2500);
    vExit=p1.waitFor();
    flagD=true;
  }catch(Exception e){
    println("ERROR CORRE MULISP");
  }
if(vExit!=0){
 println("ERROR EN LA EJECUCION"); 
}
}
//}
void customize(DropdownList ddl){
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.addItems(cities);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}
int busqueda(String ciudad){
  int index=0;
  int res=-1;
  while(index < ids.length && ! ids[index].equals(ciudad))
    index++;
  if(index < cities.length){
    res= index;
  }
  return res;
}
void graph(String x, String y){
  float x1= Float.parseFloat(x);
  float y1= Float.parseFloat(y);

  curveVertex(x1, y1); // the first control point
}
void points(String x, String y){
  float x1= Float.parseFloat(x);
  float y1= Float.parseFloat(y);
  point(x1, y1);
}
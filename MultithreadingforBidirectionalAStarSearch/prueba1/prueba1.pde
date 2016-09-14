import java.io.*;
boolean f=true;
boolean flag=true;
int inicio=1;
int fin=50;
int medio=(inicio+fin)/2;   //la escala
boolean escalas=false;
void setup(){
  size(400,400);
  background(70,60);
  frameRate(100);
  
}

void draw(){
  if(!escalas){
    if(f){
      thread("hilo");
      String[] datos1=loadStrings("DONDE1.TXT");
      String[] datos2=loadStrings("DONDE2.TXT");
      println(datos1[datos1.length-1]);
      println(datos2[datos2.length-1]);
      if(datos1[datos1.length-1].equals(datos2[datos2.length-1])){
        println("chance y funciona");
        f=false;
      }
      datos1=loadStrings("OUT1.TXT");
      datos2=loadStrings("OUT2.TXT");
      if(int(datos1[datos1.length-1])==fin && int(datos2[datos2.length-1])==inicio){
        f=false;
       }
    }else{
      pintaRuta();
    }
  }else{
    if(f){
      thread("hiloE");
      String [] datos1=loadStrings("OUT1.TXT");
      String[] datos2=loadStrings("OUT2.TXT");
      if(int(datos1[datos1.length-1])==medio && int(datos2[datos2.length-1])==fin){
        f=false;
      }
    }else{
      pintaRutaE();
    }
  }
  
}

  




void pintaRuta(){
   String [] datos1=loadStrings("COSTO1.TXT");
   String[] datos2=loadStrings("COSTO2.TXT");
    if(int(datos1[0])>int(datos2[0])){
      //pintar datos 2
      println("pinto datos2");
    }else{
     //pintar datos 1 
      println("pinto datos1");
    }
}

void pintaRutaE(){
   String [] datos1=loadStrings("OUT1.TXT");
   String[] datos2=loadStrings("OUT2.TXT");
    //pintar datos1 y datos2
    printArray(datos1);
    printArray(datos2);
}

void mousePressed(){
  if(mouseButton== RIGHT){

    try{
     Process p=Runtime.getRuntime().exec("wscript.exe C:/Users/Dana/Desktop/mejora/invisible.vbs C:/Users/Dana/Desktop/mejora/corre.bat");
     int end=p.waitFor();
     System.out.println("listo "+end);
    }catch(Exception e){
      System.out.println("Algo fslló: "+e.getMessage());
    }
  
}
}

public void hilo(){
 if(flag){
  thread("enorden"); 
  thread("sinorden");
  flag=false;
 }
}
 public void hiloE(){
 if(flag){
  thread("enordenE"); 
  thread("sinordenE");
  flag=false;
 }
 
}

void enorden(){
  println("hilo en orden");
  PrintWriter output=createWriter("datos1.txt");
  output.println(inicio);
  output.println(fin);
  output.println(1);
  output.flush();
  output.close();
  try{
     Process p=Runtime.getRuntime().exec("wscript.exe C:/Users/Dana/Desktop/mejora/prueba1/invisible.vbs C:/Users/Dana/Desktop/mejora/prueba1/corre1.bat");
     //int end=p.waitFor();
     //System.out.println("listo "+end);
    }catch(Exception e){
      System.out.println("Algo falló: "+e.getMessage());
    }
        
  String linea[]=loadStrings("OUT1.TXT");
  println("hilo en orden: "+linea[0]);
}

void sinorden(){
  println("hilo sin orden");
  PrintWriter output=createWriter("datos2.txt");
  output.println(inicio);
  output.println(fin);
  output.println(2);
  output.flush();
  output.close();
  try{
    Process p=Runtime.getRuntime().exec("wscript.exe C:/Users/Dana/Desktop/mejora/prueba1/invisible.vbs C:/Users/Dana/Desktop/mejora/prueba1/corre2.bat");
     //int end=p.waitFor();
     //System.out.println("listo "+end);
    }catch(Exception e){
      System.out.println("Algo falló: "+e.getMessage());
    }
    
  String linea[]=loadStrings("OUT2.TXT");
  println("hilo sin orden: "+linea[0]); 
}

//escalas

void enordenE(){
  println("hilo en orden");
  PrintWriter output=createWriter("datos1.txt");
  output.println(inicio);
  output.println(medio);
  output.println(1);
  output.flush();
  output.close();
  try{
     Process p=Runtime.getRuntime().exec("wscript.exe C:/Users/Dana/Desktop/mejora/prueba1/invisible.vbs C:/Users/Dana/Desktop/mejora/prueba1/corre1.bat");
     //int end=p.waitFor();
     //System.out.println("listo "+end);
    }catch(Exception e){
      System.out.println("Algo falló: "+e.getMessage());
    }
        
  String linea[]=loadStrings("OUT1.TXT");
  println("hilo en orden: "+linea[0]);
}

void sinordenE(){
  println("hilo sin orden");
  PrintWriter output=createWriter("datos2.txt");
  output.println(fin);
  output.println(medio);
  output.println(2);
  output.flush();
  output.close();
  try{
    Process p=Runtime.getRuntime().exec("wscript.exe C:/Users/Dana/Desktop/mejora/prueba1/invisible.vbs C:/Users/Dana/Desktop/mejora/prueba1/corre2.bat");
     //int end=p.waitFor();
     //System.out.println("listo "+end);
    }catch(Exception e){
      System.out.println("Algo falló: "+e.getMessage());
    }
    
  String linea[]=loadStrings("OUT2.TXT");
  println("hilo sin orden: "+linea[0]); 
}
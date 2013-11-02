
///////////////////////////////////////// Imports/////////////////////////////////
import java.awt.Toolkit;
import java.awt.GraphicsEnvironment;
import java.awt.GraphicsDevice;
import java.awt.DisplayMode;
import java.awt.*;

import grafica.*;                    // For chart classes.
import controlP5.*;                  // for buttons and txt boxes
import processing.serial.*;          // for serial
import java.io.*;                    // for file stuff
import com.shigeodayo.pframe.*;      // for extra windows
///////////////////////////////////////////////////////////////Classes///////////////
public GPlot plot1, plot2;
GPointsArray data = new GPointsArray(768);
GPointsArray newdata = new GPointsArray(768);
GPointsArray intergration_data = new GPointsArray(768);

ControlP5 cp5,cp5b,cp5c;
Serial serial;
Textarea myTextarea;   // com port and status window
Textarea myTextarea2;   // save file path window
Textarea warningtxt;  // text for warning window
Textfield Run_Intervale,Number_of_Runs, Intergration_Time;
DropdownList ports, mode;              //Define the variable ports and mode as a Dropdownlist.
CheckBox checkbox;

SecondApplet secondApplet = null;
PFrame win = null;
ThirdApplet thirdApplet = null;
PFrame warning = null;

//////////////////////////////////variables//////////////////////////////////////////
String[] wavedata = loadStrings("wavelength_on_pda_element.csv");
float[] wavelength  = new float[wavedata.length-1];
////////////////////////////////////////////////////////////////////////////////////
int LINE_FEED=10; 
boolean winshow = false;
boolean overlaydata = false;
float[] yscale = new float[2];
int numrun = 0;
//String Nor;                    // # of runs variable
//int iNor;                        // # of runs int varialbe
//String Rint;                   // run interval 
//int iRint;                      // int run interval
String sData3 ="";
char[] strtochar;
int updatechart;
boolean gotparams = false;
float wdth;
float higt;
boolean mousest = false;
boolean nxtpt = false;
int Ss;                          //The dropdown list will return a float value, which we will connvert into an int. we will use this int for that).
String[] comList ;               //A string to hold the ports in.
String[] comList2;               // string to compare comlist to and update
boolean serialSet;               //A value to test if we have setup the Serial port.
boolean Comselected = false;     //A value to test if you have chosen a port in the list.
int Modi; 
boolean Modesel = false;
String Modetorun;
int xacu;
int yacu;
float xspace;
float yspace;
ArrayList qdat;
boolean bool = false;
float p1;
float p2;
String IntTime;
int iIntTime;
String NumRuns;
int iNumRuns;
String RunInt;
int iRunInt;
int xPos = 150; 
String ComP;
int serialPortNumber;
String file1 = "logdata.txt";//"C:/Users/Ben/Documents/Voltammetry Stuff/log/data.txt";  //"C:/Users/Public/Documents/Electrochem/logfiletest/TestLog.txt"
String file2;
String file;
//String[] sData = new String[3];  //String sData;
String sData;
String sData2 = " ";
char cData;
int logDelay = 1000;
String Go = "*";
String Absorbancemode = "1";
String Transmitancemode = "2";
String Seriesmode = "3";
int i =0;
float [] dataraw = {0};
float [] newdataraw = {0};
float [] blank = {0};
float [] newblank = {0};
boolean runblank = false;
///intergration variables///////////////////////
ArrayList pvector_dat = new ArrayList();
float bx1;
float by1;
float bbtm;
float bwdth;  //
PVector XY1;   // baseline point 1
PVector XY2;  // baseline pooint 2
float area;  // peak area
float areabase;  // baseline area (subtracted from peak area)
float peaktest;  // variable for peak height
float peakheight;  // variable for peak height
//////////////font varialbes///////////////////////////////
  PFont font = createFont("arial", 20);
  PFont font2 = createFont("arial", 16);
  PFont font3 = createFont("arial",12); 
  PFont font4 = createFont("andalus",16);
/////************************////////

///////////////////////////////Setup////////////////////////////////////////////////////
void setup() {

  frameRate(2000);
  size(800, 675); // (800, 700)
  textFont(font2);
  frame.setResizable(true);
  charts_grafica_setup();
  cp5_controllers_setup();
  
  secondApplet = new SecondApplet();
  win = new PFrame(secondApplet, 210, 0);
  win.setTitle("Intergration Window");
  win.setSize(550,500);
  win.hide();
  
  thirdApplet = new ThirdApplet();
  warning = new PFrame(thirdApplet, 500, 200);
  warning.setTitle("Warning!!");
  warning.setSize(250,250);
  warning.hide();
  
  for(int i=0; i<wavedata.length-1; i++){
    String[] tokens = wavedata[i+1].split(",");
    wavelength[i]  = Float.parseFloat(tokens[1]);   
  }
}////////////////////End Setup/////////////////////////////
/////////////////////////////////////////////////Draw//////////////////////////////////////////////    

void draw() {
  try{
    background(58, 2, 67); 
  
    cp5.controller("Blank").setPosition(20, height-80);
    cp5.controller("Start_Run").setPosition(150, height-80);
    Run_Intervale.setPosition(410, height-80);
    Number_of_Runs.setPosition(520, height-80);
    Intergration_Time.setPosition(300, height-80);   
   
   textFont(font4,18); 
   pushMatrix();
   fill(#DEC507);
   text("Western",width-190,height-67);
   text("Carolina",width-186,height-53);
   popMatrix(); 
   pushMatrix();
   textFont(font2,12);
   fill(#080606);
   text("WheeSci",width-180,height-30);
   popMatrix(); 
   textFont(font2); 
   
     float wdth = width-140;
     float hgt = height-300;
     plot2.beginDraw();
      plot2.setPos(new float[] {20, 80});
      plot2.setDim(wdth, hgt);
      plot2.drawBackground();
      plot2.drawBox();
      plot2.drawXAxis();
      plot2.drawYAxis();
      plot2.drawTitle();
      plot2.setPointColors(new int[] {0});
      //plot2.drawGridLines(GPlot.BOTH);
      plot2.drawLines();
      plot2.drawPoints();
    plot2.endDraw(); 
 }
 catch(Exception e){
   println("main window");
 }
 
  comList2 = Serial.list();
  if (comList.length != comList2.length) {          //if(comList.equals(comList2)==false){ // if (comList.length != comList2.length) {
    ports.clear();
    comList = comList2;
    for (int i=0; i< comList.length; i++){
      ports.addItem(comList2[i], i);                 // add available serial ports
    }
  }
  if(comList.length == 0){
    myTextarea2.setText("NOT CONN.");
    ports.clear();                                   // clear ports dropdown list 
    ports.captionLabel().set("Select COM port");
    try{
      serial.stop();                                   // stop the serial port so a new connection can be established
    }
    catch(Exception e){}
    Comselected = false;
  } 

  if (Modesel==false) {
    Run_Intervale.hide();
    Number_of_Runs.hide();
    Intergration_Time.hide();
    cp5.controller("Start_Run").hide();
    cp5.controller("Intergrate_Data").hide();
    cp5.controller("Blank").hide();
  }
  if (Modesel==true) {
      if (Modetorun=="Absorbance" || Modetorun=="Transmitance") {
        Run_Intervale.hide();
        Number_of_Runs.hide();
        Intergration_Time.show();
      }
      if (Modetorun=="Series") {
        Run_Intervale.show();
        Number_of_Runs.show();
        Intergration_Time.show();
      }
      cp5.controller("Start_Run").show();
      cp5.controller("Blank").show();
      cp5.controller("Intergrate_Data").show(); 
  } 
  
  if (bool == true && Comselected == true) {    // start run//////////////////////////  
    if (gotparams == false) {    
      data = newdata;  //float[]
      println("com "+Comselected);

    if (Modetorun.equals("Absorbance")) {
      Intergration_Time();
      serial.write(Absorbancemode);
      delay(100);
      serial.write(IntTime);
      delay(100);
      serial.write(Go);
      println(IntTime);
      println(Go);
    }
    
   if (Modetorun.equals("Transmitance")) {
      Intergration_Time();
      serial.write(Transmitancemode);
      delay(100);
      serial.write(IntTime);
      delay(100);
      serial.write(Go);
      println(IntTime);
      println(Go);
    }

    if (Modetorun.equals("Series")) {
      Run_Intervale();
      Number_of_Runs();
      Intergration_Time();
      serial.write(Seriesmode);
      delay(100);
      serial.write(IntTime);
      delay(100);
      serial.write(NumRuns);
      delay(100);
      serial.write(RunInt);
      delay(100);
      serial.write(Go);
      println(IntTime);
      println(NumRuns);
      println(RunInt);
      println(Go);
    }
          
          data = new GPointsArray(768);  ///////////////////////read paramaters///////// //////////////////////////////
          i = 0;
          if (overlaydata == true || Modetorun=="Series"){ 
            if(numrun == 0){
            logData(file1, "", false);                                            //clear data file for new data
            }
          }
          else{
            logData(file1, "", false);                                            //clear data file for new data
          }
          while (cData!='&') {                             
            if (serial.available() > 0) { 
              cData =  serial.readChar();//cData =  serial.readChar();
              sData2 = str(cData);
              logData(file1, sData2, true); 
              if (cData == '&') {
                if (Modetorun.equals("Absorbance")) {
                  println("paramaters recieved Absorbance");
                }
                if (Modetorun.equals("Transmitance")) {
                  println("paramaters recieved Transmitance");
                }
                if (Modetorun.equals("Series")) {
                  println("paramaters recieved Series");
                }
                }
              }
            }
          
       cData = 'a';
      }  // lvsr == false
    gotparams = true;
    ///////////////////////////////////////////////////////////////////////////read serial data //////////////////////////////////////////////////////////
    while (cData!='@') {   
      read_serial();   
     }  // end if(cData!='@')
  /////////////////////////////////////////////////////////////////////////////// graph datat//////////////////////////////////////////////////////////////  
    graph_data();
  }// end of run //////////////////////////////////////////////////******************************////////////////////////////////////  
   
    if (bool == true && comList.length==0) {
      bool = false;  
      warning.show();
      warningtxt.setText("No COM port connection");
      println("comm not connected");
    }
}///////////////////////////End Draw////////////////////////





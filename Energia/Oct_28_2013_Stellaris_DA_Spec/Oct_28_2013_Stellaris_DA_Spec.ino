

/* Pulsed stripping, cyclic, timed, and loged stripping voltammetry sketch
   for use with the processing GUI 
   Based on BHickman work --current sketch assumes hardware defined pulse size
   Energia help and download (http://energia.nu/)
 
/*/////////////////////////sub-programs used in main loop///////////////////*/ 

//#include "wiring_analog.c"
//PWMWrite(pwm_pin,1000,500,1000);
/**********USER DEFINED VARIABLES*******************/


/*********NON-USER VARIABLES*********************/
long place[6]={100000,10000,1000,100,10,1};           /* {serial read conversions. each incoming byte in multiplied 
                            by the corrosponding place value then summed to get the
                            original vlaue} */
long incomingByte[6] = {0,0,0,0,0,0};                 // serial read variable. each incoming byte (multiplied by the place)
                                                      // is stored here. later the get summed to obtain the correct number      
int pgm;                                              // 0: absorbance, 1: transmitance, 2: series
int ard;
int aread[4][768];                                    // used for 4 run average
int itteration = 0;                                   //
int inttime = 0;                                      //0-500
int runinterval;
int numruns;
//#define  pwm_pin  9            // Pin 23
#define  CLK  PD_0//PF_2//PD_0                         // Pin 24
#define  SI  PD_1//PF_3//PD_1                          // Pin 25/PD2
#define  ARD  A5


/**********************************************/
void setup() {

  pinMode (CLK,OUTPUT);      // set pin 2.1 for output   
  pinMode (SI,OUTPUT);      // set pulse pin as output
  pinMode (ARD,INPUT);
  //pinMode (Iread_pin,INPUT);
  //pinMode (Offset_read_pin,INPUT); 
  //pinMode (stir_pin,OUTPUT);      /// set pin 2.4 for output
  //analogResolution(1023);         // divide the full duty cycle into 1024 steps
  //analogFrequency(5000);          // set the full duty cycle to 0.2 ms
 // Serial.begin(9600);             // begin serial comm. at 9600 baud

}


void loop() {
    Serial.begin(9600);
    delay(100);    
  //while (Serial.read() >= 0);            // clear serial available
  Serial.flush();
  setup_run();
  conversions ();
  while (Serial.available()<= 0) {       // do nothing if no GO signal
  }
  if (Serial.read() == '*'){           // start if recieved GO signal from GUI
   //Serial.println("Start");
     for(itteration = 0; itteration < 4; itteration++){
       D_array();
     }
   for(int i =768;i>0;i--){
          ard = 0;
     for(int j =0;j<4;j++){
       ard += aread[j][i];
     }
     ard = ard/4;
     Serial.println(ard);
     //Serial.print('\n');
     delay(1);
   }  
 /*  for(int i =768;i>0;i--){
   Serial.println(ard[i]);
   }*/
  }
  //else{} 
  delay(10);
  Serial.println("@");                     // signal GUI to end run
  delay(10);
  Serial.flush();
  delay(10);
  Serial.end();

}  // end loop


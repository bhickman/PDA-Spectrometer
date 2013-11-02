void cp5_controllers_setup(){
 ////////////////////////////////////////////////Text Fields//////////////////////////////
  cp5 = new ControlP5(this);  //cp5 = new ControlP5(this);
  PFont font = createFont("arial", 14);
  PFont font2 = createFont("arial", 16);
  PFont font3 = createFont("arial",12); 
  
  
  Intergration_Time = cp5.addTextfield("Intergration_Time")
    .setColor(#030302) 
      //.setColorActive(#AA8A16)
      .setColorBackground(#CEC6C6)//(#FFFEFC) 
        //.setColorCaptionLabel(#F01B1B) 
        .setColorForeground(#AA8A16) 
          //.setColorValueLabel(#F01B1B)
          //.setPosition(20, 100)
            .setSize(80, 30)
              .setFont(font)
                .setFocus(false)
                  //.setLabel("initial voltage (mV)")                
                    .setText("100");
                      controlP5.Label svl = Intergration_Time.captionLabel(); 
                        svl.setFont(font);
                          svl.toUpperCase(false);
                            svl.setText("Intergration(sec)");
  ;

  
    Number_of_Runs = cp5.addTextfield("Number_of_Runs")  // time based txt field
    .setColor(#030302) 
      //.setColorActive(#AA8A16)
      .setColorBackground(#CEC6C6) 
        //.setColorCaptionLabel(int) 
        .setColorForeground(#AA8A16) 
          //.setColorValueLabel(int)  
         // .setPosition(20, 380)
            .setSize(80, 30)
              .setFont(font)
                .setFocus(false)
                  //.setLabel("concentration time (sec)")
                    .setText("60");
                      controlP5.Label norl = Number_of_Runs.captionLabel(); 
                        norl.setFont(font);
                          norl.toUpperCase(false);
                            norl.setText("#Runs");                    
  ;
  
    Run_Intervale = cp5.addTextfield("Run_Intervale")  // time based txt field
    .setColor(#030302) 
      //.setColorActive(#AA8A16)
      .setColorBackground(#CEC6C6) 
        //.setColorCaptionLabel(int) 
        .setColorForeground(#AA8A16) 
          //.setColorValueLabel(int)  
          //.setPosition(20, 450)
            .setSize(80, 30)
              .setFont(font)
                .setFocus(false)
                  //.setLabel("concentration time (sec)")
                    .setText("60");
                      controlP5.Label ril = Run_Intervale.captionLabel(); 
                        ril.setFont(font);
                          ril.toUpperCase(false);
                            ril.setText("Interval(sec)");                    
  ;

  ///////////////////////////////////////text area//////////////////////////

 /* myTextarea = cp5.addTextarea("txt")  // save path text area
    .setPosition(280, 5)
      .setSize(300, 45)
        .setFont(font3)
          .setLineHeight(20)
            .setColor(#030302)
              .setColorBackground(#CEC6C6)
                .setColorForeground(#AA8A16)//#CEC6C6
                    ;  */

  myTextarea2 = cp5.addTextarea("txt2")  // status and com port text area
    .setPosition(300, 10)
      .setSize(100, 30)
        .setFont(createFont("arial", 12)) //(font)
          .setLineHeight(10)
            .setColor(#030302)
              .setColorBackground(#CEC6C6)
                .setColorForeground(#AA8A16)//#CEC6C6                 
                    ;


  /////////////////////////////Bang's///////////////////////////////////////////////////////////
  cp5.addBang("Start_Run")
    .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)
          .setColorActive(#06CB49)
            //.setPosition(100, height-20)
              .setSize(120, 40)
                .setTriggerEvent(Bang.RELEASE)
                  .setLabel("Start Run") //
                    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                      ;

 cp5.addBang("Connect")
    .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)  
          .setPosition(240, 10)
            .setSize(40, 20)
              .setTriggerEvent(Bang.RELEASE)
                .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                  ;

  cp5.addBang("Save_run")
    .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)  
          .setPosition(420, 10)
            .setSize(100, 20)
              .setTriggerEvent(Bang.RELEASE)
                .setLabel("Save Run")
                  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                    ;
                    
   cp5.addBang("Intergrate_Data")                 
      .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)  
          .setPosition(420, 45)
            .setSize(80, 20)
              .setTriggerEvent(Bang.RELEASE)
                .setLabel("Intergrate Peaks")
                  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                    ;
                    
     cp5.addBang("Blank")                 
      .setColorBackground(#FFFEFC)//#FFFEFC 
        .setColorCaptionLabel(#030302) //#030302
          .setColorForeground(#AA8A16)  
         // .setPosition(60, height-20)
            .setSize(120, 40)
              .setTriggerEvent(Bang.RELEASE)
                .setLabel("Blank")
                  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)  //.setLabel("Start_Run")
                    ;               
                    

  //////////////////////////////////////////Dropdownlist////////////////////////////////////////
  ports = cp5.addDropdownList("list-1", 130, 30, 100, 84)
    .setBackgroundColor(color(200))
      .setItemHeight(20)
        .setBarHeight(20)
          .setColorBackground(color(60))
            .setColorActive(color(255, 128))
              .setUpdate(true)
                ;
  ports.captionLabel().set("Select COM port");
  ports.captionLabel().style().marginTop = 3;
  ports.captionLabel().style().marginLeft = 3;
  ports.valueLabel().style().marginTop = 3;
  comList = serial.list(); 
  for (int i=0; i< comList.length; i++)
  {
    ports.addItem(comList[i], i);
  } 

  mode = cp5.addDropdownList("list-2", 10, 30, 100, 84)  //mode = cp5.addDropdownList("list-2", 650, 30, 100, 84) 
    .setBackgroundColor(color(200))
      .setItemHeight(40)//.setItemHeight(20
          .setBarHeight(20)//.setBarHeight(15)
          .setColorBackground(color(60))
            .setColorActive(color(255, 128))
              .setUpdate(true)
                ;
  mode.captionLabel().set("Select Mode");
  mode.captionLabel().style().marginTop = 3;
  mode.captionLabel().style().marginLeft = 3;
  mode.valueLabel().style().marginTop = 3;
  mode.setScrollbarWidth(10);
  mode.addItem("Absorbance", 0);
  mode.addItem("Transmitance", 1);
  mode.addItem("Series",2);
  ////////////////////////////////////////////////////////////check box/////////////////////////////////////////////
  checkbox = cp5.addCheckBox("checkBox")
    .setColorForeground(color(120))
      .setColorActive(#297C1D)
        .setColorLabel(color(255))  
          .setPosition(600, 10)
            .setSize(20, 20)
               .addItem("Overlay Runs?",0);
                      
}//////////////////////////////////end cp5_controllers-setup/////////////////////////////////////////////////

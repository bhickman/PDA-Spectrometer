void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    if (theEvent.name().equals("list-1")) {//if (theEvent.getGroup().equals("list-1")) {

      float S = theEvent.group().value();
      Ss = int(S);
      //Comselected = true;
    }
    
    if (theEvent.name().equals("list-2")) {
      float Mod = theEvent.group().value(); //float Mod = theEvent.group().value();
      Modi = int(Mod);
      String [][] Modetype = mode.getListBoxItems(); //  String [] Modetype = theEvent.group().Items();
      Modetorun = Modetype[Modi][0]; //Modetorun = Modetype[Modi][Modi];
      Modesel = true;
      println(Modetorun);
    }
  }
  
   if (theEvent.isFrom(checkbox)) {
     if(checkbox.getState("Overlay Runs?")==true){
     overlaydata = true;
     }
     else{
       overlaydata = false;
       for(int i = 1; i<=numrun;i++){
          plot2.removeLayer("layer_"+str(i));
          println("removed "+i);
        }
        numrun = 0;
     }
     println(overlaydata);
   }
} // end control events


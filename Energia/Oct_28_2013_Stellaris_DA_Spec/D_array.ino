void D_array(){
  
  if(itteration == 0){
    digitalWrite(SI,1);            // Start reading data
    digitalWrite(CLK,1);
    delayMicroseconds(80);
    //ard[0] = analogRead(ARD);
    int dumy = analogRead(ARD);
    digitalWrite(SI,0);
    digitalWrite(CLK,0);
    delayMicroseconds(90);
  for(int i=0;i<767;i++)
  {
    digitalWrite(CLK,1);         
    delayMicroseconds(90);
    //ard[i+1] = analogRead(ARD);
    int dumy = analogRead(ARD);
    digitalWrite(CLK,0);
    delayMicroseconds(90);
  } 
  for(int i = 0;i<inttime;i++){    // added intergration time
      digitalWrite(CLK,1);         
      delayMicroseconds(90);
      digitalWrite(CLK,0);
      delayMicroseconds(90);
      }
  } // end initial array clear

    
  /*  digitalWrite(SI,1);            // Start signal intergration for n+1 clock cycles
    digitalWrite(CLK,1);
    delayMicroseconds(90);
    digitalWrite(SI,0);            // 
    digitalWrite(CLK,0);
    delayMicroseconds(90);
   for(int i=0;i<768;i++)
    {
      digitalWrite(CLK,1);         
      delayMicroseconds(90);
      digitalWrite(CLK,0);
      delayMicroseconds(90);
    } 
    //delayMicroseconds(30);         // delay to allow last pixle to trasnfer charge  
    int inttime = 6500;
    for(int i = 0;i<inttime;i++){
      digitalWrite(CLK,1);         
      delayMicroseconds(90);
      digitalWrite(CLK,0);
      delayMicroseconds(90);
      }   */
   
    
    digitalWrite(SI,1);            // Start reading data
    digitalWrite(CLK,1);
    delayMicroseconds(80);
    aread[itteration][0] = analogRead(ARD);
    digitalWrite(SI,0);
    digitalWrite(CLK,0);
    delayMicroseconds(90);
  for(int i=0;i<767;i++)
  {
    digitalWrite(CLK,1);         
    delayMicroseconds(90);
    aread[itteration][i+1] = analogRead(ARD);
    digitalWrite(CLK,0);
    delayMicroseconds(90);
  } 
  for(int i = 0;i<inttime;i++){    // adjust intergration time
      digitalWrite(CLK,1);         
      delayMicroseconds(90);
      digitalWrite(CLK,0);
      delayMicroseconds(90);
      }
    
    
}

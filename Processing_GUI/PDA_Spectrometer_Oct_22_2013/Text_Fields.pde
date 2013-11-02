public void Run_Intervale() {              //get start voltage from text box
  RunInt = cp5.get(Textfield.class, "Run_Intervale").getText();
  iRunInt = round(float(RunInt));
  //iStartV=iStartV+1852;
  RunInt = nf(iRunInt, 6);   // make StartV have 4 digits. pad with zero if no digits
}
public void Number_of_Runs() {               // get end voltage from text box
  NumRuns = cp5.get(Textfield.class, "Number_of_Runs").getText();
  iNumRuns = round(float(NumRuns));
  //iEndV=iEndV+1852;
  NumRuns = nf(iNumRuns, 6);   // make EndV have 4 digits. pad with zero if no digits
}
public void Intergration_Time() {                 // get scan rate from text box
  IntTime = cp5.get(Textfield.class, "Intergration_Time").getText();
  iIntTime = round(float(IntTime));
  IntTime = nf(iIntTime, 6);   // make ScanR have 3 digits. pad with zero if no digits
}


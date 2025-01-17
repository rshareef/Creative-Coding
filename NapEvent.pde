class NapEvent
{
  // instance data fields.
  int day; // Day of occurrence - abstracted the date recorded to just be represented as a 'day' of recording nap data.
  String where; // Location of nap.
  
  int when; // Time of day nap took place in 24-hour clock -> time converted to number of minutes past 00:00 through method 'convertTimeToInt'.
  int duration; // Length of nap in minutes.
  
  String reason; // Reason for taking the nap.
  int quality; // How good was the nap? On a scale of 1-5. (1 = not good, 5 = excellent).
  
  boolean caffeine; // Did I drink caffeine that day? Yes(true)/No(false).
  float nightSleep; // How many hours did I sleep that preceeding night?
  
  
 
  // 'constructor' method is called when we instantiate a new 'NapEvent' object and initialises its state.
  // accepts an array of tokens from one line of the text file.*/
  NapEvent(String[]napTokensArray)
  {
    day = int(napTokensArray[0]); // convert day e.g.: String "1" to int 1.
    where = napTokensArray[1];
    when = convertTimeToInt(napTokensArray[2]); 
    duration = int(napTokensArray[3]); // convert minutes long of nap e.g.: String "90" to int 90.
    reason = napTokensArray[4];
    quality = int(napTokensArray[5]);
    caffeine = determineBooleanValue(napTokensArray[6]); // convert 'Y/N' string into a boolean value with 'determineBooleanValue' method.
    nightSleep = float(napTokensArray[7]); // convert number of hours slept into a float value.
  }
  
  // VALUE CONVERSION METHODS (INVOKED IN CONSTRUCTOR).
  // method to convert the 'time' value passed in as an argument, to an integer value showing where on a 24-hour scale (0 - 24*60) in minutes that time falls.
  int convertTimeToInt(String time){
    // create substrings of hours and minutes
    int minutes = int(time.substring(3));
    int hours = int(time.substring(0,2));
    // total minutes since midnight that day = (hours*60) + minutes.
    int timeInt = (hours*60) + minutes;
    return timeInt;
  }
  
  // method to determine boolean value (true/false) based on (Y/N) value 'option' passed in.
  boolean determineBooleanValue(String option){
    boolean result = false;
    if (option.equals("Y")){
      result = true;
    }
    return result;
  }
  
  // method to return number of 
}

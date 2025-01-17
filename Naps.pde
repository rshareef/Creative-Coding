// Dear Data Diary: Naps.
// NOTE: decided to omit access modifiers for simplictity.
/*
1 - Load data from text file.
2 - Create an object of the 'NapEvent' class from each line of data's tokens.
3 - Draw and Interact with sketch.
*/

// GLOBAL VARIABLE DECLARATIONS.

// ArrayList of 'NapEvent' objects (for each nap that was recorded).
ArrayList<NapEvent> napObjects = new ArrayList();
// Hashmap for storing key:value pairs of reasons for taking a nap and their mapped colours.
HashMap<String,Integer> reasonColour = new HashMap();
// Hashmap for storing key:value pairs of locations for taking a nap and their mapped shapes to be drawn.
HashMap<String,Integer> locationShape = new HashMap();

// Does the user want to see which days caffeine was consumed?
boolean caffeineShake = false;
// Does the user want to reveal nightSleep variable?
boolean nightTime = false;

// SETUP: code that runs once at start of program.
void setup(){
  size(1000,600); // sketch window size.
  textSize(20); // size of any text displayed in sketch.
  
  // initilialise hashmap colours (reason for nap : representing colour).
  reasonColour.put("Tired",#87CBE3); // cornflower blue
  reasonColour.put("Sleepy",#a31aff); // light purple
  reasonColour.put("Headache",#e62e00); // red
  
  // initialise hashmap shape numbers (location of nap : number representing shape to draw).
  locationShape.put("Train",0); // 0 will represent an underground roundel.
  locationShape.put("In-bed",1); // 1 will represent a triangle.
  locationShape.put("On-bed",2); // 2 will represent a square.
  locationShape.put("Library",3); // 2 will represent a book-like rectangle.
  
  // load text from file into an array of strings 'napRecords' (each element of the array is a line of text).
  String[] napRecords = loadStrings("naps.txt");
  // loop through each element of 'napRecords' array:
  for (int i=0; i< napRecords.length; i++) {
      // put the output of split() function into an array 'napTokens' (with local scope to this for loop):
      String[] napTokens = split(napRecords[i],",");
      // pass the local array 'napTokens' which holds all of the data for one nap event in as an argument to the constructor to create a new 'NapEvent'.
      NapEvent nap = new NapEvent(napTokens);
      // add the created 'NapEvent' object to an ArrayList of nap objects called 'napObjects'.
      napObjects.add(nap);
  }
}

// DRAW: code that runs continuously until termination/loop cancellation.
void draw(){
  colorMode(HSB,1,1,1); // change colorMode (default is RGB).
  background(0.12, 0.11, 0.95); // draw background colour.
  fill(#003682); // default shape & text fill colour = dark blue.

  // calculate sketch scaling offset.
  float x = map(7, 0,100, 0,width); // coordinate of 7% into the sketch (can be applied as an offset/value to either horizontal or vertical coordinates).
  
  // draw axis lines.
  stroke(#003682); // colour of axis lines to match labels = dark blue.
  line(x,10,x,(height-x)); // vertical line.
  line(x,(height - x),width,(height-x)); // horizontal line.
  stroke(0); // stroke colour to black for drawing shapes.
  
  // draw axis labels.
  textAlign(CENTER);
  // vertical label.
  text("Day",x/2,(height-x)/2);
  // horizontal labels.
  text("00:00",x ,(height-(x/2)));
  text("06:00",((width-x)/4)+ x ,(height-(x/2))); 
  text("12:00",((width-x)/2) + x ,(height-(x/2)));
  text("18:00",(3*(width-x)/4) + x,(height-(x/2)));
    
  // draw rectangles downwards (Day 1 drawn at the top, Day n at the bottom - of the 'graph').
  int lastDay = napObjects.get(napObjects.size()-1).day; //get value of last day recorded in array to determine how many day rows to represent.
  float section = (height - x - 20)/lastDay; // uniform vertical height of each row (or specifically, each rectangle drawn).
  float gridStartPos = 20 - section; // top-left corner coordinate of rectangle to be drawn.
  int prevDay = 1; // initialise a variable to hold value of previous day to 1.
  
  // for each nap object, draw a rectangle on the sketch.
  for (NapEvent n:napObjects){
    // check if the day of the previous rectangle drawn, is the same as the day for the current selected object.
    if (prevDay != n.day){
      // if it isn't (i.e. this nap event is on a new day), change the value of the day counter to the new day value (i.e. same effect as incrementing).
      prevDay = n.day;
      // and offset the rectangle y-coordinate (i.e. to start a new row).
      gridStartPos = gridStartPos + section;
    }
    
    // pass the 'reason' value for this object as an argument to the HashMap 'reasonColour's get method ( i.e. acts as the key), to get the corresponding value (the colour hex code).
    int rectColour = reasonColour.get(n.reason);  // colour of rectangle to draw
    // determine opacity of rectangle to draw based on quality of 'napObject' instance. 
      // 1 = poor quality = more transparent.
      // 5 = best quality = more opaque.
    float opacity = map(n.quality,1,5,0,254); 
    fill(rectColour,opacity); // set colour and opacity.
    
    // check if the rectangle should shake, and if yes, add random jitter on y-value:
    float randomY = 0; // random amount to shake.
    // if caffeine was consumed that day AND if the user is pressing down on the 'c' key (interaction handled in 'keyPressed'/'keyReleased' methods):
    if (n.caffeine && caffeineShake){
      // generate a small random value.
      randomY = random(-10,10);
    }
    
    // drawn nap event rectangle.
    rect(map(n.when, 0,(24*60), 0,width), gridStartPos, map(n.duration, 0,(24*60), 0,width), section*0.9-randomY);
    
    // draw shape on corner of rectangle to represent location.
    drawCornerShape((locationShape.get(n.where)),map(n.when, 0,(24*60), 0,width), gridStartPos, rectColour);
    
    // draw an overlapping rectangle based on proportion of nightsleep.
    /* (NOTE: the 'darker' the 'nightSleep' rectangle appears, the more naps were taken that day (because each rectangle drawn for a day overlaps). 
        Initially unintentional but I liked the effect, so kept it). */
    if (nightTime){
      fill(#0f2b69,100);
      rect(x,gridStartPos,width-x,map(n.nightSleep,0,12,0,section*0.9-randomY));
    }
  }
}

// INTERACTION: user interaction with the sketch.
// NOTE: made allowances for uppercase versions of letters too.
void keyPressed() {
  if (key == 'c'|| key == 'C') {
    caffeineShake = true; // make flag variable true if 'c' is pressed.
  }
  if (key == 'n'|| key == 'N'){
    nightTime = !nightTime; //switch the value of boolean variable so user can use key as a toggle.
  }
}

void keyReleased(){
  if (key == 'c'|| key == 'C') {
    caffeineShake = false; // make flag variable false if 'c' is released.
  }
}

Maxim maxim;

// Last letter used.
int lastLetter = 26;  

// This will store the audio clips
short[][] AudioClips = new short [lastLetter][];

// Audio Files
String[] audioFileArray = {"LtrA96K.wav","LtrB32K.wav",
                           "LtrC48K.wav","LtrD16K.wav",
                           "LtrE.wav","LtrF.wav",
                           "LtrG.wav","LtrH.wav",
                           "LtrI.wav","LtrJ.wav",
                           "LtrK.wav","LtrL.wav",
                           "LtrM.wav","LtrN.wav",
                           "LtrO.wav","LtrP.wav",
                           "LtrQ.wav","LtrR.wav",
                           "LtrS.wav","LtrT.wav",
                           "LtrU.wav","LtrV.wav",
                           "LtrW.wav","LtrX.wav",
                           "LtrY.wav","LtrZ.wav"};
                           
// Image files
String[] imageArray = {"Letter-A-blue-icon.png","Letter-B-blue-icon.png",
                       "Letter-C-blue-icon.png","Letter-D-blue-icon.png",
                       "Letter-E-blue-icon.png","Letter-F-blue-icon.png",
                       "Letter-G-blue-icon.png" ,"Letter-H-blue-icon.png",
                       "Letter-I-blue-icon.png","Letter-J-blue-icon.png",
                       "Letter-K-blue-icon.png","Letter-L-blue-icon.png",
                       "Letter-M-blue-icon.png", "Letter-N-blue-icon.png",
                       "Letter-O-blue-icon.png","Letter-P-blue-icon.png",
                       "Letter-Q-blue-icon.png","Letter-R-blue-icon.png",
                       "Letter-S-blue-icon.png" ,"Letter-T-blue-icon.png",
                       "Letter-U-blue-icon.png","Letter-V-blue-icon.png",
                       "Letter-W-blue-icon.png","Letter-X-blue-icon.png",
                       "Letter-Y-blue-icon.png" ,"Letter-Z-blue-icon.png"
                     };
                
AudioPlayer player;

// this will contain an array of all the letter images
PImage[] Letter = new PImage[lastLetter];

// Index into letters.  
boolean random = false;  // determine weather or not to generate display letters randomly or incrementally

int start = 0;  // start position;
int myIndex=-1; // start index.  -1 in case we are incrementing so we can start at A

void displayLetter()
{
 
  if(random) {  
   int lastIndex = myIndex;
  
// Get random number between 0 and last letter  
// Avoid repeating letters
    while(myIndex == lastIndex){
      myIndex = int(random (lastLetter));
    }
  }else{

    myIndex++;
  
    if(myIndex > 25){
      myIndex = start;
    }
  }  

// Load new letter sound into player  
  player.selectAudioClip(myIndex);
  
// Play letter sound  
  player.setLooping(false);
  player.volume(1);
  player.cue(0);
  player.speed(1);
  player.play();
}  

void setup()
{
  
  size(640, 960);
  maxim = new Maxim(this); 
  
  player = maxim.createEmptyPlayer();
  
 
  background(0);

  for(int i = 0;i<lastLetter;i++) {
    Letter[i] = loadImage(imageArray[i]);   
  }  
  player.loadAudioClips(audioFileArray, this);
  displayLetter();
}

void draw()
{
  
// code that happens every frame
  background(0);
  
// Ensure image is centered  
  imageMode(CENTER);
  
// paste letter  
  image(Letter[myIndex],width/2,height/2,width-10, height-10);
}

void mouseDragged()
{
// code that happens when the mouse moves
// with the button down
}

void mousePressed()
{
// code that happens when the mouse button
// is pressed

// stop player
player.stop();

// clear screen
fill(0);
rect(width/2, height/2, width, height);

// generate new letter and play sound
displayLetter();
}

void mouseReleased()
{
// code that happens when the mouse button
// is released
}


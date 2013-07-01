//***************************************************************************************************************************************
// LetterDisplay
// This class handles the showing the image and sound for each letter
//***************************************************************************************************************************************

class LetterDisplay {
  
  private Maxim maxim;
  private int stage;          // stage of display.  0 for moving in, 1 for stationary, 2 for moving away
  private int scale;          // relative scale of image

  private int fullWidth;      // Maximum image width
  private int fullHeight;     // Maximum image height
  
  // Last letter used.
  private int lastLetter = 26;  
  

// This will store the audio clips
  private short[][] AudioClips;

// Audio Files
  private String[] audioFileArray = {"LtrA96K.wav","LtrB32K.wav",
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
  private String[] imageArray = {"Letter-A-blue-icon.png","Letter-B-blue-icon.png",
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

// this will be the AudioPlayer that handles the sounds.                
  private AudioPlayer player;
  private AudioPlayer[] players;

// this will contain an array of all the letter images
  private PImage[] Letter = new PImage[lastLetter];

// Index into letters.  
  private boolean random = false;  // determine weather or not to generate display letters randomly or incrementally
  private boolean singlePlayer;    // Whether we  use a single player or multiple ones

  private boolean retreat = false; // Indicates whether image is retreating from the screen
  private int step = 0;

  private int start = 0;    // start position;
  private int myIndex = -1; // start index.  -1 in case we are incrementing so we can start at A

 // constructor for LetterDisplay 
  public LetterDisplay(PApplet processing, boolean singlePlayer){
    
  maxim = new Maxim( processing);
  
  this.singlePlayer = singlePlayer;
  
  if(singlePlayer){
    AudioClips = new short [lastLetter][];
    player = maxim.createEmptyPlayer();
    player.loadAudioClips(audioFileArray, processing);
  }  else {
    players = new AudioPlayer[lastLetter];
  }  

  for(int i = 0;i<lastLetter;i++) {
    Letter[i] = loadImage(imageArray[i]); 
    if(!singlePlayer) {
       players[i] = maxim.loadFile(audioFileArray[i]); 
       players[i].setLooping(false);
    }   
  }  
  ChangeLetter();
}
  

public void startMovingLetterIn(){
    stage = 0;  
    scale = 60;   
  }  
  
  public void movingLetterIn(){
    scale--;
    if(scale == 1){
      finishedMovingLetterIn();
    }  
  }  
  
  public void finishedMovingLetterIn(){
    stage = 1;
    sayLetter();
    scale = 1;
  }  
  
  public void startMovingLetterOut(){
    if(stage == 1){    
      stage = 2;
      scale = 1;
    }
  }  
  public void movingLetterOut(){
    scale++;
    if(scale == 60){
      finishedMovingLetterOut();
    }  
  }  
  
    public void finishedMovingLetterOut(){
      stage = 0;
      ChangeLetter();
      scale = 60;
  }  
   
  
  
  public void sayLetter() {
    
   // Load new letter sound into player  
   if(singlePlayer) {
      player.selectAudioClip(myIndex);
  
    // Play letter sound  
      player.setLooping(false);
      player.volume(1);
      player.cue(0);
      player.speed(1);
      player.play();
   }  else {
      players[myIndex].play();
   }   
  } 
  
  public void ChangeLetter(){
 
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
   startMovingLetterIn();
}  

public void updateDisplay(){
  if(stage != 1)
  {
// code that happens every frame
  background(0);
  
// Ensure image is centered  
  imageMode(CENTER);

  float xtran = map(scale,60, 1,0, width/2);
  float ytran = map(scale,60, 1,0, height/2);
   translate(xtran,ytran);
  if(stage == 0){
    movingLetterIn();
  }else{
  movingLetterOut();
  }  
 float rotation;
 if((scale == 1)||(scale==60))
 {
    rotation = 0;
 } else{   
  rotate(TWO_PI/15*scale);
 } 

// paste letter  
  scale (1.0/scale);
  image(Letter[myIndex],0,0,(width-10), (height-10));
  }
}
}
  

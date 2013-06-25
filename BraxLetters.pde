//***************************************************************************************************************************************
// BraxLetters
// An app to help my 19 month old with his letters
// Written in Processing 2.0 June 2013
// Martin Bruner
//***************************************************************************************************************************************

LetterDisplay letterDisplay;
Maxim maxim; 
void setup()
{
  
   size(640, 960,OPENGL);

   letterDisplay = new LetterDisplay(this, true);
}

void draw()
{
  letterDisplay.updateDisplay();
  
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

  letterDisplay.startMovingLetterOut();

}

void mouseReleased()
{
// code that happens when the mouse button
// is released
}


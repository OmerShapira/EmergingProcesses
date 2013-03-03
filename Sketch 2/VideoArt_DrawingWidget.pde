/**
 *  Type 1,2 for different 'flame' modes
 *	type 'c' to turn clipping on/off
 *	@author Omer Shapira
 */

import processing.video.*;

Capture video;
PImage img;
boolean clip = true;
int type = 0;


void setup(){
  size(640, 480);
  video = new Capture(this);
  video.start();
  img = createImage(640,480, RGB);
  img.loadPixels();
}

void draw(){
  update();
  image(img,0,0);
}

void update(){
  if (video.available() == true) {
    video.read();
    video.loadPixels();

    int ix,iy;
    for (int i = width*height-1; i>=0; i--){
      ix = i%width;
      iy = i/width;
      if (iy >= height-2){
        img.pixels[i] = video.pixels[i];
        } else {
        	switch (type){
        		case 0 :
        			img.pixels[i] = averageColors(clip, img.pixels[i+width - 1], img.pixels[i+width] ,(ix==width-1? img.pixels[i+width - 1] : img.pixels[i+width + 1]), img.pixels[i+width*2]);
        		break;	
        		case 1 :
        			img.pixels[i] = averageColors(clip, img.pixels[i], img.pixels[i+width]);		
        		break;	
        		
        	}
      }
  }
  img.updatePixels();
}
}

int averageColors(boolean clip, color... colors){
  float tempfloat = 0;
  int tempColor = 0;
  
  for (int i = 0; i<4; i++){
    int range = 255<<(8*i);
    for (color c : colors){
          tempfloat += (c&range);
      }

    tempfloat /= (float) colors.length;
    tempColor += (!clip ? int(tempfloat) : int(tempfloat)&range);
    tempfloat = 0;
    }
return tempColor;
}

void keyTyped(){
	if (key < '9' && key > '0'){
	type = int(key)%2;	
	} else if (key=='c') {
		clip = !clip;
	}
}
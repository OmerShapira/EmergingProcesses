import processing.video.*;

Capture video;
PImage img;

void setup(){
	size(640, 480);
	video = new Capture(this);
	video.start();
	img = createImage(640,480, RGB);
}

void draw(){
	update();
	image(img,0,0);
}

void update(){
	if (video.available() == true) {
		video.read();
		video.loadPixels();
		img.loadPixels();

		int ix,iy;
		for (int i = width*height-1; i>=0; i--){
			ix = i%width;
			iy = i/width;
			if (iy >= height-2){
				img.pixels[i] = video.pixels[i];
				} else {
					img.pixels[i] = int((img.pixels[i+width - 1 ] + img.pixels[i+width] + (ix==width-1? img.pixels[i+width - 1] : img.pixels[i+width + 1]) + img.pixels[i+width*2])/4.0);
				}
			}
			img.updatePixels();
		}
	}
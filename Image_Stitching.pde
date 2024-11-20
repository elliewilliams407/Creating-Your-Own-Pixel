// take pictures from an artists and make that artists face
//take photos from this trip and make something
//make it user friendly and have it so that users can upload their own to make something 
// all pictures from belvedere to make the building

int smallest_image;
int smallest_num;

PImage[] smallerImages; // class array to store smaller images
PImage largeImage;
int numImages = 70; // Number of smaller images (change this according to your images)

int chunkWidth= 12; //CHANGES WIDTH OF SMALL PICS
int chunkHeight= 12; //CHANGES HEIGHT OF SMALL PICS

float[] diff= new float[numImages];

void setup() {
  size(1000,800); //PLAY WITH GRID SIZE

  smooth(0);
  

  
  // Load the smaller images into the array
   smallerImages = new PImage[numImages]; //initialize PImage object 
  
  for (int i = 0; i < numImages; i++) { 
    String filename = "image_" + (i+1) + ".png"; //name each image this so that processing can read it
    smallerImages[i] = loadImage(filename); //loads each image
    smallerImages[i].resize(chunkWidth, chunkHeight); //this causes the images to become blurry??
    smallerImages[i].updatePixels();
  }
  
  //largeImage= new PImage();
  largeImage= loadImage("image_12.png"); //WHAT YOU WANT THE FINAL IMAGE TO BE
  largeImage.resize(width,height);
  
  comparePixelChunks();
  
  
   /*Calculate the dimensions of each smaller image based on the grid layout
  int gridSize = 8; // Number of rows and columns in the grid
  int smallerImageSize = width / (gridSize); // Assuming the grid is square
  //int space= smallerImageSize/2;
  int index = 0;
  
  // Loop to arrange the smaller images in a grid
  for (int y = 0; y < height; y += smallerImageSize) {
    for (int x = 0; x < width; x += smallerImageSize) {
      image(smallerImages[index], x, y, smallerImageSize, smallerImageSize);
      index++;
      if (index >= numImages) {
        break;
      }
    }
    if (index >= numImages) {
      break;
    }
  }
  
  */
}


void comparePixelChunks() {
  // Define the position of the top-left corner of the chunks
  int x1 = 0; //x coordinate of large image
  int y1 = 0; //y coordinate of large image
  int x2 = 0; //x coordinate of smaller images
  int y2 = 0; //x coordinate of smaller images
  
  int avgrL=0;
  int avggL=0;
  int avgbL=0;
  int totalpixelsL=0;
  
  int avgr=0;
  int avgg=0;
  int avgb=0;
  int totalpixels=0; 
  

  /* each chunk of space in the large image (chunkWidth) is compared to each small image
    1. average red blue and green is taken of the pixels in the chunk and image by getting the color
    and adding to a variable then dividing
    2. use the distance function to see the difference between that image and the chunk
    3. the smallest distance determines what image is used to replace that chunk
    4. that small image is placed in that section overtop of the large image //<>//
 */
  // Loop through the chunks
  for(int largeChunkx=0; largeChunkx<width; largeChunkx+=chunkWidth){
    for  (int largeChunky=0; largeChunky<height; largeChunky+= chunkHeight){
       avgrL=0;
       avggL=0;
       avgbL=0;
       totalpixelsL=0;
       smallest_image=0;

      for (int x=0; x< chunkWidth; x++){
            for (int y=0; y< chunkHeight; y++){
              color c= largeImage.get(x1+x, y1+y);
              avgrL+= red(c);
              avggL+= green(c);
              avgbL+= blue(c);
              totalpixelsL+=1;
            }
            
      }  
      for(int i = 0; i < numImages; i++){ // loop that cycles through small images
         avgr=0;
         avgg=0;
         avgb=0;
         totalpixels=0; 
         
        for (int j = 0; j<smallerImages[i].width ; j++) { //loop that goes through rows of pixels in small image
          for (int k= 0; k < smallerImages[i].height; k++) { //loop that goes through column of pixels in small image
            color c2= smallerImages[i].get(x2+j, y2+k);
            avgr+= red(c2);
            avgg+= green(c2);
            avgb+= blue(c2);
            totalpixels+=1;

            }
          }
        float diffr= abs(avgr/totalpixels-avgrL/totalpixelsL);
        float diffg= abs(avgg/totalpixels-avggL/totalpixelsL);
        float diffb= abs(avgb/totalpixels-avgbL/totalpixelsL);
        diff[i]=diffr+diffg+diffb;
        //diff[i] = abs(dist(avgrL/totalpixelsL, avggL/totalpixelsL, avgbL/totalpixelsL, avgr/totalpixels, avgg/totalpixels, avgb/totalpixels));
        //diff[i]=abs((((avgrL/totalpixelsL)+(avggL/totalpixelsL)+(avgbL/totalpixelsL))/3)-(((avgr/totalpixels)+(avgg/totalpixels)+(avgb/totalpixels))/3));
        if (i==0){
          smallest_image=0;

                    
        }
        else if (diff[i]<diff[smallest_image]){
          smallest_image=i;
          
        }
        
      }
      image(smallerImages[smallest_image], x1,y1);
       y1+=chunkHeight;
       
    }
    y1=0;
    x1+=chunkWidth;
    
  }    
}

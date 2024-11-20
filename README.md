# Creating Your Own Pixel Image Machine 

## Goal of Project
Create flexible code that allows a select group of photos to be used in the creation of a larger image. 

## Inspiration:
I created this during my month long visit to Vienna, Austria which consisteted of numerous days of exploring museum after museum. I wanted to use all of the artworks of a particular museum, the Belvedere, as pixels making up an image of the Belvedere itself. However, it can be used to draw any image with any group of images. 

## How it Works:
- Takes the average of RGB values in all of the pixels in the smaller images and compares it to the average RGB values in a chunk of the larger image 
- The smallest difference in shade is the picture that gets chosen to replace that chunk (placed over).

## Example Image
![image](https://github.com/user-attachments/assets/3dfa2097-4d6d-4d3f-a6e3-a2f06fd6d2df)

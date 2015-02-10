String[] morphFiles;
String morphDir;
PImage morphImg;

void setup() {
  size(640, 480);
  frame.setResizable(true);
  
  morphDir = sketchPath+"/../kaleidomorph/output";
  
  textFont(createFont("Georgia", 36));
}

void draw() {
  morphFiles = listFileNames(morphDir);

  background(255);
  
  if(morphFiles == null ||morphFiles.length <= 0)
  {
    fill(0);
    println("Error: no images found in dir "+morphDir);
    text("I can't find any images", 10, height/2.0);
    return;
  }
  
  if(morphImg == null || frameCount%50 == 0)
  morphImg = loadImage(morphDir + "/" + morphFiles[int(random(morphFiles.length))]);
  //image(morphImg, width/2.0 - (morphImg.width/2.0), height/2.0-(morphImg.height/2.0));
  
  println(width + "  "+morphImg.height*(width/(1.0*morphImg.width)));
  println(morphImg.width);
  image(morphImg, 0,0,width, morphImg.height*(width/(1.0*morphImg.width)));
}

String[] listFileNames(String dir) {
  println("reading filenames in dir " + dir);
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    println("found "+names.length+" files");
    return names;
  } else {
    // If it's not a directory
    println("Warning: this is not a directory:"+dir);
    return null;
  }
}

import java.util.Comparator;
import java.util.Arrays;
import java.io.File;

String[] morphFiles;
String morphDir;
PImage morphImg;
int prevNrFiles = 0;
int counter = 0;
Comparator<File> byModificationDate = new ModificationDateCompare();

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
  
  if(morphImg == null || counter%100 == 0 || prevNrFiles < morphFiles.length)
  {
    counter = 0;
    morphImg = loadImage(morphDir + "/" + morphFiles[int(random(morphFiles.length))]);
    if(prevNrFiles < morphFiles.length)
    {
      morphImg = loadImage(morphDir + "/" + morphFiles[morphFiles.length-1]);
    }
  }
  image(morphImg, 0,0,width, morphImg.height*(width/(1.0*morphImg.width)));
  prevNrFiles = morphFiles.length;
  counter++;
}

String[] listFileNames(String dir) {
  println("reading filenames in dir " + dir);
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    Arrays.sort(files, byModificationDate);
    
    String[] names = new String[files.length];
    for(int i = 0; i < files.length;i++)
    {
      names[i] = files[i].getName();
    }
    
    println("found "+names.length+" files");
    
    return names;
  } else {
    // If it's not a directory
    println("Warning: this is not a directory:"+dir);
    return null;
  }
}

class ModificationDateCompare implements Comparator<File> {
  public int compare(File f1, File f2) {
    return Long.valueOf(f1.lastModified()).compareTo(f2.lastModified());    
  }
}

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require turbolinks

// For slideshow in homepage
var slideshowInterval = 2000; // image will change every 2 seconds
var slideshowImageDir = "assets/images/brighthearts/"; // directory where image is stored.
var slideshowImageNum = 0; // which image to show.

slideshowImages = new Array(); // array to store the slide show images

for(numImage = 0; numImage < 9; numImage++)
{
    // add images into the array
    slideshowImages[numImage] = new imageObject(slideshowImageDir + (numImage+1) + ".jpg");
}                     
// create new images
function imageObject(imageLocation)
{
    this.image_item = new Image();
        this.image_item.src = imageLocation;
}
// get the image location
function getImageLocation(imageObject)
{
    return(imageObject.image_item.src);
}

function nextImage()
{
    // no more images beyond that index. start from beginning.
    if(slideshowImageNum == images.length-1)         
        slideshowImageNum = 0;
    else
        imageNum++;
    var newImage = getImageLocation(slideshowImages[imageNum]);
    return(newImage);
}

function switchImage(place)
{
    document[place].src = nextImage();
    var recur_call = "switchImage('"+place+"')";
    timerID = setTimeout(recur_call,slideshowInterval);
}

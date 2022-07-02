import 'dart:math';
import 'package:flutter/material.dart';


// Declare model
class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  final Function(int) onExpandClicked;

  // ignore: use_key_in_widget_constructors
  const PhotoGrid(
      {required this.imageUrls,
        required this.onImageClicked,
        required this.onExpandClicked,
        this.maxImages = 4,
      });

  @override
  State<StatefulWidget> createState() => PhotoGridState();
}

// Display image and Shortcut image list
class PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();
    // check length of list report image
    if(widget.imageUrls.isEmpty) {
      // if no, nothing
      return const SizedBox(
      );
    }
    //if one, display single image
    else if (widget.imageUrls.length == 1) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
              widget.imageUrls.first,
              fit: BoxFit.cover, alignment: Alignment.center)
      );
    }
    // display max 4 image and shortcut the remaining image
    else {
      return GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        children: images,
      );
    }
  }
  // build image widget
  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () => widget.onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => widget.onExpandClicked(index),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(imageUrl, fit: BoxFit.cover),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: const TextStyle(color: Colors.white ,fontSize: 32),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () => widget.onImageClicked(index),
        );
      }
    });
  }
}

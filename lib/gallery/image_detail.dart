
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';




class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<String> urlImages;
  final int index;

  GalleryWidget({Key? key,
    required this.urlImages,
    this.index = 0,
  }) : pageController = PageController(initialPage: index), super(key: key)  ;

  @override
  State<StatefulWidget> createState() => GalleryWidgetState();
}

class GalleryWidgetState extends State<GalleryWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late int index = widget.index;
  void closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            PhotoViewGallery.builder(
              pageController: widget.pageController,
              scrollDirection: Axis.horizontal,
              scrollPhysics: const BouncingScrollPhysics(),
              itemCount: widget.urlImages.length,
              builder: (context, index) {
                final urlImage = widget.urlImages[index];
                return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(urlImage),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 4
                );
              },
              onPageChanged: (index) => setState(() => this.index = index),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.white, // Button color
                      child: InkWell(
                        splashColor: Colors.red, // Splash color
                        onTap: closeDrawer,
                        child: const SizedBox(width: 30, height: 30, child: Icon(Icons.close)),
                      ),
                    ),
                  ),

                  Text(
                    '${index + 1}/${widget.urlImages.length}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),

                  const Text(''),
                ],
              ),
            )
          ],
        ),
        // drawerEnableOpenDragGesture: false,
      ),
    );
  }
}
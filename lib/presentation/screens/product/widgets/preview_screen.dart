import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:revest/presentation/screens/product/widgets/image_widget.dart';

class PreviewMediaGallery extends HookWidget {
  final List<String> images;
  final int initialIndex;

  const PreviewMediaGallery({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(initialPage: initialIndex);

    final currentIndex = useState(initialIndex);

    useEffect(() {
      pageController.addListener(() {
        int page = pageController.page?.round() ?? 0;
        if (currentIndex.value != page) {
          currentIndex.value = page;
        }
      });
      return null;
    }, [pageController]);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${currentIndex.value + 1} / ${images.length}',
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
            heroAttributes: PhotoViewHeroAttributes(
              tag: images[index] + ImageWidget.calculateHeroOffset.toString(),
              transitionOnUserGestures: true,
            ),
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Colors.black,
        ),
        loadingBuilder: (context, event) => SizedBox.expand(
          child: ColoredBox(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(
                value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
        ),
        pageController: pageController,
      ),
    );
  }
}

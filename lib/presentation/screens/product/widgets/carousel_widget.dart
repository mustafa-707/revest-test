import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:revest/presentation/screens/product/widgets/image_widget.dart';
import 'package:revest/presentation/screens/product/widgets/preview_screen.dart';
import 'package:revest/utils/extensions/context.dart';

class CarouselWithDots extends HookWidget {
  final List<String> imageUrls;

  const CarouselWithDots({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState<int>(0);

    useEffect(() {
      if (imageUrls.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          precacheImage(NetworkImage(imageUrls[0]), context);
        });
      }
      return null;
    }, [imageUrls]);

    useEffect(() {
      listener() {
        int nextPage = pageController.page?.round() ?? 0;
        if (currentPage.value != nextPage) {
          currentPage.value = nextPage;
          precacheImage(NetworkImage(imageUrls[nextPage]), context);
        }
      }

      pageController.addListener(listener);

      return () => pageController.removeListener(listener);
    }, [pageController]);
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.navigator.push(
                    MaterialPageRoute(
                      builder: (context) => PreviewMediaGallery(
                        images: imageUrls,
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: imageUrls[index] + ImageWidget.calculateHeroOffset.toString(),
                  transitionOnUserGestures: true,
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        if (imageUrls.length > 1)
          SizedBox(
            height: 30,
            child: imageUrls.length > 5
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        5,
                        (index) => AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage.value == index ? 12 : 8,
                          height: currentPage.value == index ? 12 : 8,
                          decoration: BoxDecoration(
                            color: currentPage.value == index ? context.primaryColor : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      if (imageUrls.length > 5)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 12,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      imageUrls.length,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: currentPage.value == index ? 12 : 8,
                        height: currentPage.value == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: currentPage.value == index ? context.primaryColor : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
          ),
      ],
    );
  }
}

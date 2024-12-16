import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revest/data/models/product_model.dart';
import 'package:revest/presentation/screens/product/details/product_details.dart';
import 'package:revest/presentation/screens/product/widgets/image_widget.dart';
import 'package:revest/utils/extensions/context.dart';

class ProductWidget extends HookWidget {
  final ProductModel product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (product.images.first.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          precacheImage(NetworkImage(product.images.first), context);
          if (product.thumbnail != null) {
            precacheImage(NetworkImage(product.thumbnail!), context);
          }
        });
      }
      return null;
    }, [product.images.first]);

    return GestureDetector(
      onTap: () {
        context.navigator.pushNamed(
          ProductDetails.routeName,
          arguments: product.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.onSurfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Center(
                  child: ImageWidget(
                    imageUrl: product.thumbnail ?? '',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.quicksand(
                  color: context.surfaceColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          color: context.surfaceColor.withValues(alpha: .8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

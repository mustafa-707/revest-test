import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revest/presentation/screens/product/widgets/carousel_widget.dart';
import 'package:revest/provider/products.dart';
import 'package:revest/utils/extensions/context.dart';

class ProductDetails extends HookConsumerWidget {
  static const routeName = '/product';
  final int productId;

  const ProductDetails({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productData = ref.watch(productProvider(productId));

    return Scaffold(
      backgroundColor: context.surfaceColor,
      appBar: AppBar(
        title: Text(
          productData.when(
            data: (data) => data.title,
            loading: () => 'Loading...',
            error: (err, stack) => 'Error',
          ),
        ),
      ),
      body: productData.when(
        data: (product) {
          return Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: 250,
                    child: CarouselWithDots(
                      imageUrls: product.images.isEmpty ? [product.thumbnail ?? ''] : product.images,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: context.width * 0.72,
                                child: Text(
                                  product.title,
                                  style: context.titleLarge,
                                ),
                              ),
                              Visibility(
                                visible: product.category != null,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: context.secondaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      product.category ?? '',
                                      style: GoogleFonts.gabarito(
                                        color: context.onSecondaryColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          product.brand?.isEmpty ?? true ? 'Unknown Brand' : product.brand!,
                          style: context.bodyLarge,
                        ),
                        SizedBox(height: 12),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.secondaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 20),
                                  SizedBox(width: 4),
                                  Text(
                                    '${product.rating}',
                                    style: context.titleMedium.copyWith(
                                      color: context.onPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        Text(
                          product.description,
                          style: GoogleFonts.robotoCondensed(
                            height: 2,
                            color: context.onSurfaceColor,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 132),
                ],
              ),
              Positioned.fill(
                top: null,
                child: SizedBox(
                  height: 120,
                  child: ClipPath(
                    clipper: RoundedDiagonalPathClipper(),
                    child: Container(
                      color: context.secondaryColor,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 22),
                          child: Text(
                            "${product.price} \$ ",
                            style: GoogleFonts.lobster(
                              height: 2,
                              color: context.onSecondaryColor,
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Product Not Found')),
      ),
    );
  }
}

/// Diagonal clipper with rounded borders
class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..quadraticBezierTo(size.width, 0.0, size.width - 20.0, 0.0)
      ..lineTo(40.0, 70.0)
      ..quadraticBezierTo(10.0, 85.0, 0.0, 120.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

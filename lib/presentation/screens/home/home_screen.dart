import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revest/presentation/screens/product/product_widget.dart';
import 'package:revest/provider/app_settings.dart';
import 'package:revest/provider/products.dart';
import 'package:revest/utils/extensions/context.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // Call to AutomaticKeepAliveClientMixin

    // Keep the scroll controller across rebuilds
    final scrollController = useScrollController();
    final productState = ref.watch(productControllerProvider);
    final themeProvider = ref.watch(currentThemeProvider);
    final stream = ref.watch(productsStreamProvider);

    return Scaffold(
      backgroundColor: context.surfaceColor,
      body: productState.isLoading
          ? Center(child: CircularProgressIndicator())
          : productState.errorMessage.isNotEmpty
              ? Center(child: Text('Error: ${productState.errorMessage}'))
              : stream.when(
                  error: (error, stackTrace) => Center(child: Text('Error: $error')),
                  loading: () => Center(child: CircularProgressIndicator()),
                  data: (data) => PrimaryScrollController(
                    controller: scrollController,
                    child: Scrollbar(
                      thumbVisibility: true,
                      radius: const Radius.circular(8),
                      thickness: 20,
                      interactive: true,
                      child: CustomScrollView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 150.0,
                            floating: false,
                            pinned: true,
                            backgroundColor: context.surfaceColor,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Text(
                                'Products',
                                style: GoogleFonts.lobster(
                                  color: context.primaryColor,
                                  fontSize: 42,
                                ),
                              ),
                              titlePadding: const EdgeInsets.all(16.0),
                            ),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  ref.read(appSettingsProvider.notifier).updateTheme(
                                        themeProvider == ThemeMode.dark.name
                                            ? ThemeMode.light.name
                                            : ThemeMode.dark.name,
                                      );
                                },
                                icon: Icon(
                                  themeProvider == ThemeMode.dark.name ? Icons.dark_mode : Icons.light_mode,
                                  color: context.primaryColor,
                                ),
                              ),
                              SizedBox(width: 12),
                            ],
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            sliver: SliverGrid.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return RepaintBoundary.wrap(
                                  ProductWidget(
                                    product: data[index],
                                  ),
                                  index,
                                );
                              },
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 84,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

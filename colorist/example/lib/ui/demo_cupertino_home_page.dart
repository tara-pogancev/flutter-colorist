import 'package:colorist/colorist.dart';
import 'package:example/theme/color_themes.dart';
import 'package:example/ui/colorist_theming_widgets_demo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Image, BoxFit, CircleAvatar, Divider; // For Image.asset only

class DemoCupertinoHomePage extends StatelessWidget {
  const DemoCupertinoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: context.cupertinoColors.canvas,
      navigationBar: CupertinoNavigationBar(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Hello, Colorist!'),
            Text(
              'Let\'s explore color palettes',
              style: context.textTheme.labelLarge!.copyWith(
                color: context.cupertinoColors.textSecondary,
              ),
            ),
          ],
        ),
        trailing: const CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/cat.jpg'),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  const SliverToBoxAdapter(child: _DemoCardCupertino()),
                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Divider(
                          height: 48,
                        ),
                        ColoristThemingWidgetsDemo(),
                        Divider(
                          height: 48,
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Traditional paint',
                        style: context.textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 8)),
                  SliverList.list(
                    children: const [
                      _ArtCardCupertino(
                        assetPath: 'assets/the_creation_of_adam.jpg',
                        artist: 'Michelangelo',
                        title: 'The Creation of Adam',
                        year: 1512,
                      ),
                      _ArtCardCupertino(
                        assetPath: 'assets/the_lady_of_sharlott.jpg',
                        artist: 'Tate Britain',
                        title: 'The Lady Of Sharlott',
                        year: 1888,
                      ),
                      _ArtCardCupertino(
                        assetPath: 'assets/girl_with_a_pearl_earring.jpg',
                        artist: 'Johannes Vermeer',
                        title: 'Girl with a Pearl Earring',
                        year: 1665,
                      ),
                    ],
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 64)),
                ],
              ),
            ),
            CupertinoTabBar(
              height: 70,
              backgroundColor: context.cupertinoColors.canvas,
              currentIndex: context.themeManager.themes.indexOf(context.themeManager.currentTheme),
              onTap: (index) {
                context.themeManager.setTheme(context.themeManager.themes[index]);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.drop),
                  label: 'Ocean\n(Light)',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.sun_max),
                  label: 'Desert\n(Light)',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.tree),
                  label: 'Forest\n(Dark)',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoCardCupertino extends StatelessWidget {
  const _DemoCardCupertino();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              context.cupertinoColors.cardGradientStart,
              context.cupertinoColors.cardGradientEnd,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/michelangelo.jpg'),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    borderRadius: BorderRadius.circular(20),
                    color: context.cupertinoColors.white.withAlpha(50),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.globe,
                          size: 18,
                          color: context.cupertinoColors.white,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'ITALY',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: context.cupertinoColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Michelangelo Buonarroti',
                style: context.textTheme.titleLarge!.copyWith(
                  color: context.cupertinoColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sculptor, painter, architect, and poet',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.cupertinoColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArtCardCupertino extends StatelessWidget {
  const _ArtCardCupertino({
    required this.assetPath,
    required this.title,
    required this.artist,
    required this.year,
  });

  final String assetPath;
  final String title;
  final String artist;
  final int year;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: context.cupertinoColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium!.copyWith(
                      color: context.cupertinoColors.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    artist,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.cupertinoColors.textSecondary,
                    ),
                  ),
                  Text(
                    year.toString(),
                    style: context.textTheme.labelMedium!.copyWith(
                      color: context.cupertinoColors.textTernary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 90,
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

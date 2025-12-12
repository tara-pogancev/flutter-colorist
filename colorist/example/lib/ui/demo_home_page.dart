import 'package:colorist/colorist.dart';
import 'package:example/theme/color_themes.dart';
import 'package:example/ui/colorist_theming_widgets_demo.dart';
import 'package:flutter/material.dart';

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hello, Colorist!'),
            Text(
              'Let\'s explore color palettes',
              style: context.textTheme.labelLarge!.copyWith(color: context.colors.textSecondary),
            ),
          ],
        ),
        centerTitle: false,
        actionsPadding: const EdgeInsets.all(12),
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/cat.jpg'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _DemoCard(),
          const Divider(
            height: 48,
          ),
          const ColoristThemingWidgetsDemo(),
          const Divider(
            height: 48,
          ),
          Text(
            'Traditional paint',
            style: context.textTheme.headlineMedium,
          ),
          const _ArtCard(
            assetPath: 'assets/the_creation_of_adam.jpg',
            artist: 'Michelangelo',
            title: 'The Creation of Adam',
            year: 1512,
          ),
          const _ArtCard(
            assetPath: 'assets/the_lady_of_sharlott.jpg',
            artist: 'Tate Britain',
            title: 'The Lady Of Sharlott',
            year: 1888,
          ),
          const _ArtCard(
            assetPath: 'assets/girl_with_a_pearl_earring.jpg',
            artist: 'Johannes Vermeer',
            title: 'Girl with a Pearl Earring',
            year: 1665,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.colors.canvas,
        currentIndex: context.themeManager.themes.indexOf(context.themeManager.currentTheme),
        onTap: (index) {
          context.themeManager.setTheme(context.themeManager.themes[index]);
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.water),
            label: 'Ocean\n(Light)',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: 'Desert\n(Light)',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.nature),
            label: 'Forest\n(Dark)',
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            context.colors.cardGradientStart,
            context.colors.cardGradientEnd,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/michelangelo.jpg'),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.travel_explore),
                  label: const Text(
                    'ITALY',
                  ),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.colors.white,
                    side: BorderSide(
                      color: context.colors.white,
                      width: 1.5,
                    ),
                    textStyle: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Michelangelo Buonarroti',
                        style: context.textTheme.titleLarge!.copyWith(
                          color: context.colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sculptor, painter, architect, and poet',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ArtCard extends StatelessWidget {
  const _ArtCard({required this.assetPath, required this.title, required this.artist, required this.year});

  final String assetPath;
  final String title;
  final String artist;
  final int year;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 32,
          children: [
            Expanded(
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: context.colors.text, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      artist,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: context.colors.textSecondary),
                    ),
                    Text(
                      year.toString(),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: context.colors.textTernary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                width: 100,
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

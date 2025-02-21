import 'package:dsr/ui/widgets/today_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/bible_text.dart';

final fontSizeProvider = StateNotifierProvider<FontSizeNotifier, double>((ref) {
  return FontSizeNotifier();
});

class FontSizeNotifier extends StateNotifier<double> {
  FontSizeNotifier() : super(20.0); // Default font size

  void setFontSize(double size) {
    state = size;
  }
}

final fontFamilyProvider =
    StateNotifierProvider<FontFamilyNotifier, String>((ref) {
  return FontFamilyNotifier();
});

class FontFamilyNotifier extends StateNotifier<String> {
  FontFamilyNotifier() : super('Roboto'); // Default font

  void setFontFamily(String family) {
    state = family;
  }
}

class Today extends ConsumerStatefulWidget {
  const Today({Key? key}) : super(key: key);

  @override
  ConsumerState<Today> createState() => _TodayState();
}

class _TodayState extends ConsumerState<Today> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            pinned: false,
            delegate: TodayHeader(
              minExtent: 150,
              maxExtent: 250,
              vsync: this,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BibleText(
                            verse: 'John 14:12',
                            content:
                                'Very truly I tell you, whoever believes in me will do the works I have been doing, and they will do even greater things than these, because I am going to the Father.',
                          ),
                          SizedBox(width: 8),
                          BibleText(
                            verse: 'Mark 16:17-18',
                            content:
                                'And these signs will accompany those who believe: In my name they will drive out demons; they will speak in new tongues; they will pick up snakes with their hands; and when they drink deadly poison, it will not hurt them at all; they will place their hands on sick people, and they will get well.',
                          ),
                          SizedBox(width: 8),
                          BibleText(
                            verse: 'Matthew 10:8',
                            content:
                                'Heal the sick, raise the dead, cleanse those who have leprosy, drive out demons. Freely you have received; freely give.',
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Consumer(
                                builder: (context, ref, child) {
                                  return Container(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: Text('Font Size'),
                                          subtitle: Row(
                                            children: [
                                              Icon(
                                                Icons.text_decrease,
                                                size: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              Expanded(
                                                child: Slider(
                                                  value: ref
                                                      .watch(fontSizeProvider),
                                                  min: 16.0,
                                                  max: 30.0,
                                                  divisions: 7,
                                                  label: ref
                                                      .watch(fontSizeProvider)
                                                      .round()
                                                      .toString(),
                                                  onChanged: (double value) {
                                                    ref
                                                        .read(fontSizeProvider
                                                            .notifier)
                                                        .setFontSize(value);
                                                  },
                                                ),
                                              ),
                                              Icon(
                                                Icons.text_increase,
                                                size: 20,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          title: Text('Font Family'),
                                          trailing: DropdownButton<String>(
                                            value:
                                                ref.watch(fontFamilyProvider),
                                            items: [
                                              'Roboto',
                                              'Merriweather',
                                              'Lora',
                                              'Source Serif 4',
                                              'Crimson Pro'
                                            ].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                ref
                                                    .read(fontFamilyProvider
                                                        .notifier)
                                                    .setFontFamily(newValue);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        customBorder: CircleBorder(),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            Icons.format_size,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'This morning, I just want you to meditatively read through the words of the hymn written by beloved Isaac Watts in 1719, O, God our help in Ages past. Against the backdrop of the Schism Act forced through Parliament by Queen Anne of England in that year designed to seriously limit religious freedom, Christianity was passing through a severe time. Inspired by the Psalm of Moses, Psalm 90, Watts wrote to encourage believers in those dark days: This hymn and its inspiring progenitor, Psalm 90 bears an apt prayer for a day like this. Having arrived January just two days ago, zooming through the new year, we trust that the God of all Ages, who has been there before time and its bearing sons came into being, before the ageless hills came in to take their stands, will remain our hope for the days to come. Where are you this morning? \n\nAre you afraid for any reason? Why? We, the saints of God dwell sure and secured under the banner of the Almighty. With His strong hands wrapped around us, who will dare to touch? God did not just become God yesterday .Actually, He did not become anything. He has been and will ever be.',
                    style: TextStyle(
                      fontSize: ref.watch(fontSizeProvider),
                      fontFamily:
                          GoogleFonts.getFont(ref.watch(fontFamilyProvider))
                              .fontFamily,
                      height:
                          2.0, // Increased from 1.5 to 2.0 for more line spacing
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '"He went around doing good and healing all who were under the power of the devil, because God was with Him."',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

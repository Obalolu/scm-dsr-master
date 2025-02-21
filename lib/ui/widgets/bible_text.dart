import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class BibleText extends StatelessWidget {
  BibleText({
    super.key,
    required this.verse,
    required this.content,
  });

  final String verse;
  final String content;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      onPressed: () {
        showPopover(
          context: context,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            minWidth: 100,
          ),
          bodyBuilder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Important for wrapping
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      verse,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize,
                      ),
                    ),
                    Text(
                      'KJV',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyLarge?.fontSize),
                ),
              ],
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          radius: 16,
          direction: PopoverDirection.bottom,
          arrowHeight: 15,
          arrowWidth: 30,
        );
      },
      child: Text(
        verse,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}

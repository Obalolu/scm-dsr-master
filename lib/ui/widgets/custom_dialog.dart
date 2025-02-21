import 'package:dsr/models/devotional_model.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final List<Bibletext>? bibleTexts;

  CustomDialog({this.bibleTexts});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<Bibletext>? bibleTexts;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    bibleTexts = widget.bibleTexts;
    print("$currentIndex, showNext: $showNext, showPrev: $showPrev");
  }

  get showNext => currentIndex < bibleTexts!.length - 1;

  get showPrev => currentIndex > 0;

  handleNextClick() {
    setState(() {
      if (showNext) {
        currentIndex++;
      }
    });
    print("$currentIndex showNext: $showNext");
  }

  handlePrevClick() {
    setState(() {
      if (showPrev) {
        currentIndex--;
      }
    });
    print("$currentIndex showPrev: $showPrev");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
//      elevation: 0.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.menu_book, color: Colors.black),
                      SizedBox(width: 6),
                      Text(
                        bibleTexts![currentIndex].name!,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inder',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            height: 1.125),
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel_outlined),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                bibleTexts![currentIndex].content!,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Inder',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 1.5),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: showPrev,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue),
                      onPressed: handlePrevClick,
                    ),
                  ),
                  Visibility(
                    visible: showNext,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.blue),
                      onPressed: handleNextClick,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

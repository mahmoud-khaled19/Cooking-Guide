import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class SwipeButtonWidget extends StatefulWidget {
  SwipeButtonWidget(
      {Key? key, required this.isFinished, required this.function})
      : super(key: key);
  bool isFinished;

  Function() function;

  @override
  State<SwipeButtonWidget> createState() => _SwipeButtonWidgetState();
}

class _SwipeButtonWidgetState extends State<SwipeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SwipeableButtonView(
        isFinished: widget.isFinished,
        buttonText: 'Watch video',
        buttontextstyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white
        ),
        buttonWidget: Container(
          child: Icon(
            Icons.video_collection_sharp,
            color: Colors.grey,
          ),
        ),
        activeColor: Colors.grey,
        onWaitingProcess: () {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              widget.isFinished = true;
            });
          });
        },
        onFinish: widget.function);
  }
}

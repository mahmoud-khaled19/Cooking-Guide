import 'package:flutter/material.dart';
import 'package:food_app/utils/style_manager.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class SwipeButtonWidget extends StatefulWidget {
  SwipeButtonWidget(
      {Key? key, required this.isFinished, required this.function})
      : super(key: key);
  late final bool isFinished;

  final Function() function;

  @override
  State<SwipeButtonWidget> createState() => _SwipeButtonWidgetState();
}

class _SwipeButtonWidgetState extends State<SwipeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SwipeableButtonView(
        isFinished: widget.isFinished,
        buttonText: 'Watch video',
        buttontextstyle: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeightManager.semiBold),
        buttonWidget: Container(
          child: Icon(
            Icons.video_collection_sharp,
            color: Theme.of(context).splashColor,
          ),
        ),
        activeColor: Theme.of(context).splashColor,
        onWaitingProcess: () {
          Future.delayed(Duration(microseconds: 500), () {
            setState(() {
              widget.isFinished = true;
            });
          });
        },
        onFinish: widget.function);
  }
}

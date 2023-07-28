import 'package:flutter/cupertino.dart';

class ClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.moveTo(0,0);
    path.lineTo(0, h-70);
    path.quadraticBezierTo(w * 0.2 , h , w * 0.6 , h-50,);
      path.quadraticBezierTo( w * 0.9, h -80, w   , h  );
    path.lineTo(w,0);
    path.quadraticBezierTo( w * 0.4  ,  80 , 0  , 0,);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/values_manager.dart';
import '../../widgets/default_custom_text.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({
    Key? key,
    required this.name,
    required this.image,
     this.color,
     this.id,
  }) : super(key: key);
  final String? name;
  final String? image;
  final String? id;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(imageUrl: image!),
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        DefaultCustomText(
          text: name!,
          color: color ?? Colors.white,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: AppSize.s10,
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/values_manager.dart';
import '../../widgets/default_custom_text.dart';

class MealItemShape extends StatelessWidget {
  const MealItemShape({
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
          child: CachedNetworkImage(
            imageUrl: image!,
            placeholder: (context, url) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey[600]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: AppSize.s170,
                    width: AppSize.s170,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
              color: Colors.grey),
              ));
            },
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        DefaultCustomText(
          text: name!,
          color: color ?? Theme.of(context).splashColor,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: AppSize.s10,
        ),
      ],
    );
  }
}

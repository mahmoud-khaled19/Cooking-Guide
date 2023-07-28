import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/colors_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/values_manager.dart';
import '../../widgets/default_custom_text.dart';
import 'meal_items_components.dart';

class MealItem extends StatelessWidget {
  MealItem({
    super.key,
    this.image,
    this.mealName,
    this.mealCountry,
    this.source,
    this.videoUrl,
    this.mealInstructions,
    this.items,
    this.quantity,
  });

  final List<String>? items;
  final List<String>? quantity ;
  final String? image;
  final String? mealName;
  final String? mealCountry;
  final String? source;
  final String? videoUrl;
  final String? mealInstructions;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            expandedHeight: AppSize.s250,
            flexibleSpace: FlexibleSpaceBar(
              background: FadeIn(
                duration: const Duration(seconds: 2),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        ColorsManager.lightIconsColor,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.5, 1.0, 1.0],
                    ).createShader(
                      Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        imageUrl: image!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: AppSize.s4,
                        child: GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(videoUrl!);
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: const CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.video_collection),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSize.s10),
              child: FadeInUp(
                duration: const Duration(seconds: 2),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DefaultCustomText(
                            text: mealName ?? ' try name',
                            color: Theme.of(context).splashColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DefaultCustomText(
                          text: mealCountry ?? ' try country',
                          color: Theme.of(context).splashColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    DefaultCustomText(
                      text: 'Description',
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.s16,
                    ),
                    SizedBox(
                      height: AppSize.s4,
                    ),
                    DefaultCustomText(
                      text: mealInstructions ?? '',
                      maxLines: mealInstructions!.length,
                    ),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    DefaultCustomText(
                      text: 'Components',
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.s16,
                    ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    MealItemComponents(
                      item1: items![0],
                      quantity1: quantity![0],
                    ),
                    MealItemComponents(
                      item1: items![1],
                      quantity1: quantity![1],
                    ),
                    MealItemComponents(
                      item1: items![2],
                      quantity1: quantity![2],
                    ),
                    MealItemComponents(
                      item1: items![3],
                      quantity1: quantity![3],
                    ),
                    MealItemComponents(
                      item1: items![4],
                      quantity1: quantity![4],
                    ),
                    MealItemComponents(
                      item1: items![5],
                      quantity1: quantity![5],
                    ),
                    MealItemComponents(
                      item1: items![6],
                      quantity1: quantity![6],
                    ),
                    MealItemComponents(
                      item1: items![7],
                      quantity1: quantity![7],
                    ),
                    MealItemComponents(
                      item1: items![8],
                      quantity1: quantity![8],
                    ),
                    MealItemComponents(
                      item1: items![9],
                      quantity1: quantity![9],
                    ),
                    MealItemComponents(
                      item1: items![10],
                      quantity1: quantity![10],
                    ),
                    MealItemComponents(
                      item1: items![11],
                      quantity1: quantity![11],
                    ),
                    MealItemComponents(
                      item1: items![12],
                      quantity1: quantity![12],
                    ),
                    MealItemComponents(
                      item1: items![13],
                      quantity1: quantity![13],
                    ),
                    MealItemComponents(
                      item1: items![14],
                      quantity1: quantity![14],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}

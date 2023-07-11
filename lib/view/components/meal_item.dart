import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    this.item1,
    this.quantity1,
    this.item2,
    this.quantity2,
    this.item3,
    this.quantity3,
    this.item4,
    this.quantity4,
    this.item5,
    this.quantity5,
    this.item6,
    this.quantity6,
    this.item7,
    this.quantity7,
    this.item8,
    this.quantity8,
    this.item9,
    this.quantity9,
    this.item10,
    this.quantity10,
    this.item11,
    this.quantity11,
    this.item12,
    this.quantity12,
    this.item13,
    this.quantity13,
    this.item14,
    this.quantity14,
    this.item15,
    this.quantity15,
  });

  String? image;
  String? mealName;
  String? mealCountry;
  String? source;
  String? videoUrl;
  String? mealInstructions;
  String? item1, quantity1;
  String? item2, quantity2;
  String? item3, quantity3;
  String? item4, quantity4;
  String? item5, quantity5;
  String? item6, quantity6;
  String? item7, quantity7;
  String? item8, quantity8;
  String? item9, quantity9;
  String? item10, quantity10;
  String? item11, quantity11;
  String? item12, quantity12;
  String? item13, quantity13;
  String? item14, quantity14;
  String? item15, quantity15;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSize.s12),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CachedNetworkImage(
                imageUrl: image ?? '',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Positioned(
                right: AppSize.s4,
                child: Row(
                  children: [
                    GestureDetector(
                      child: const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.language),
                      ),
                      onTap: () async {
                        final Uri url = Uri.parse(source ?? '');
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                    ),
                    SizedBox(
                      width: AppSize.s10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse(videoUrl ?? '');

                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.video_collection),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DefaultCustomText(
                  text: mealName ?? ' try name',
                  color: Theme.of(context).splashColor,
                  fontSize: AppSize.s18,
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
            fontSize: AppSize.s18,
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
            fontSize: AppSize.s18,
          ),
          SizedBox(
            height: AppSize.s10,
          ),
          if(item15 != null || item15!.isNotEmpty)
          MealItemComponents(
            item1: item1 ?? '',
            quantity1: quantity1 ?? '',
          ),
          MealItemComponents(
            item1: item2 ?? '',
            quantity1: quantity2 ?? '',
          ),
          MealItemComponents(
            item1: item3 ?? '',
            quantity1: quantity3 ?? '',
          ),
          MealItemComponents(
            item1: item4 ?? '',
            quantity1: quantity4 ?? '',
          ),
          MealItemComponents(
            item1: item5 ?? '',
            quantity1: quantity5 ?? '',
          ),
          MealItemComponents(
            item1: item6 ?? '',
            quantity1: quantity6 ?? '',
          ),
          MealItemComponents(
            item1: item7 ?? '',
            quantity1: quantity7 ?? '',
          ),
          MealItemComponents(
            item1: item8 ?? '',
            quantity1: quantity8 ?? '',
          ),
          MealItemComponents(
            item1: item9 ?? '',
            quantity1: quantity9 ?? '',
          ),
          MealItemComponents(
            item1: item10 ?? '',
            quantity1: quantity10 ?? '',
          ),
          MealItemComponents(
            item1: item11 ?? '',
            quantity1: quantity11 ?? '',
          ),
          MealItemComponents(
            item1: item12 ?? '',
            quantity1: quantity12 ?? '',
          ),
          MealItemComponents(
            item1: item13 ?? '',
            quantity1: quantity13 ?? '',
          ),
          MealItemComponents(
            item1: item14 ?? '',
            quantity1: quantity14 ?? '',
          ),
          MealItemComponents(
            item1: item15 ?? '',
            quantity1: quantity15 ?? '',
          ),
        ],
      ),
    );
  }
}

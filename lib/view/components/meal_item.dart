import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/colors_manager.dart';
import 'package:food_app/widgets/swipe_button_widget.dart';
import '../../utils/global_methods.dart';
import '../../utils/values_manager.dart';
import '../../view_model/app_cubit.dart';
import '../../view_model/app_state.dart';
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

  final List? items;
  final List? quantity;
  final String? image;
  final String? mealName;
  final String? mealCountry;
  final String? source;
  final String? videoUrl;
  final String? mealInstructions;
  final bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
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
                          stops: [0.0, 0.0, 1.0, 1.0],
                        ).createShader(
                          Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            imageUrl: image!,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                cubit.addFavourite(
                                  context: context,
                                  image: image!,
                                  mealName: mealName!,
                                  mealCountry: mealCountry!,
                                  source: source!,
                                  videoUrl: videoUrl!,
                                  mealInstructions: mealInstructions!,
                                  items: items!,
                                  quantity: quantity!, inFavourite: true,
                                );
                              },
                              child: Icon(
                                Icons.favorite_outline_rounded,
                                size: AppSize.s30,
                              ),
                            ),
                          )
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
                        Padding(
                          padding: EdgeInsets.all(AppSize.s10),
                          child: SwipeButtonWidget(
                              isFinished: isFinished,
                              function: () {
                                GlobalMethods.showVideo(videoUrl!);
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DefaultCustomText(
                                text: mealName ?? ' try name',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            DefaultCustomText(
                              text: mealCountry ?? ' try country',
                              color: Colors.white,
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
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: AppSize.s4,
                        ),
                        DefaultCustomText(
                          text: mealInstructions ?? '',
                          maxLines: mealInstructions!.length,
                          color: Colors.white60,

                        ),
                        SizedBox(
                          height: AppSize.s20,
                        ),
                        DefaultCustomText(
                          text: 'Components',
                          fontWeight: FontWeight.bold,
                          fontSize: AppSize.s16,
                          color: Colors.white,

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
      },
    );
  }
}

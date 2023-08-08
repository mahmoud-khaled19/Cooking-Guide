import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/colors_manager.dart';
import 'package:food_app/widgets/swipe_button_widget.dart';
import '../../utils/global_methods.dart';
import '../../utils/values_manager.dart';
import '../../view_model/app_cubit/app_cubit.dart';
import '../../view_model/app_cubit/app_state.dart';
import '../../widgets/default_custom_text.dart';
import '../components/meal_items_components.dart';

class MealDetailsScreen extends StatelessWidget {
  MealDetailsScreen({
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
                          stops: [0.0, 0.1, .9, 1.0],
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final item = await cubit
                                        .favouritesCollection
                                        .where('mealName', isEqualTo: mealName!)
                                        .get();

                                    if (item.size == 0) {
                                      // Item doesn't exist in favorites, add it
                                      await cubit.addFavourite(
                                        context: context,
                                        image: image!,
                                        mealName: mealName!,
                                        mealCountry: mealCountry!,
                                        source: source!,
                                        videoUrl: videoUrl!,
                                        mealInstructions: mealInstructions!,
                                        items: items!,
                                        quantity: quantity!,
                                        isFavourite: true,
                                      );
                                    } else {
                                      // Item exists in favorites, remove it
                                    }
                                  },
                                  child: FutureBuilder<bool>(
                                    future:
                                        cubit.checkItemInFavorites(mealName),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      final isItemInFavorites =
                                          snapshot.data ?? false;
                                      return Icon(
                                        isItemInFavorites
                                            ? Icons.favorite
                                            : Icons.favorite_outline_rounded,
                                        size: AppSize.s30,
                                        color: isItemInFavorites
                                            ? Colors.red
                                            : Colors.black,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: AppSize.s10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    GlobalMethods.shareLink(videoUrl!);
                                  },
                                  child: Icon(
                                    Icons.share,
                                    size: AppSize.s30,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
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
                        Padding(
                          padding: EdgeInsets.all(AppSize.s10),
                          child: SwipeButtonWidget(
                              isFinished: isFinished,
                              function: () {
                                GlobalMethods.showVideo(videoUrl!);
                              }),
                        ),
                        DefaultCustomText(
                          text: mealName ?? ' try name',
                          fontSize: AppSize.s14,
                        ),
                        DefaultCustomText(
                          text: mealCountry ?? ' try country',
                          color: Colors.white60,
                        ),
                        SizedBox(
                          height: AppSize.s20,
                        ),
                        DefaultCustomText(
                          text: 'Description',
                          fontSize: AppSize.s14,
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
                          fontSize: AppSize.s16,
                        ),
                        SizedBox(
                          height: AppSize.s10,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return MealItemComponents(
                              item1: items![index],
                              quantity1: quantity![index],
                            );
                          },
                          itemCount:
                              items!.where((item) => item.isNotEmpty).length,
                        )
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

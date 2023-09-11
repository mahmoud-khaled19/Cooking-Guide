import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/values_manager.dart';

class LoadingHomeScreen extends StatelessWidget {
  const LoadingHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textLoadingItem(),
              Shimmer.fromColors(
                baseColor: Colors.grey[600]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: AppSize.s60,
                  width: AppSize.s80,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppSize.s30,
          ),
          textLoadingItem(width: AppSize.s170),
          SizedBox(
            height: AppSize.s16,
          ),
          textLoadingItem(width: AppSize.s120),
          SizedBox(
            height: AppSize.s50,
          ),
          textLoadingItem(),
          SizedBox(
            height: AppSize.s16,
          ),
          SizedBox(
            height: AppSize.s50,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[600]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    width: AppSize.s100,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(right: 10),
                  ),
                );
              },
              itemCount: 21,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: AppSize.s50,
          ),
          textLoadingItem(),
          SizedBox(
            height: AppSize.s8,
          ),
          SizedBox(
            height: AppSize.s50,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[600]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    width: AppSize.s100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(right: 10),
                  ),
                );
              },
              itemCount: 20,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: AppSize.s30,
          ),
          textLoadingItem(width: AppSize.s170),
          SizedBox(
            height: AppSize.s20,
          ),
          textLoadingItem(width: AppSize.s170),
        ],
      ),
    );
  }
}

Widget textLoadingItem({
  double? height,
  double? width,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[600]!,
    highlightColor: Colors.grey[300]!,
    child: Container(
      height: height ?? AppSize.s30,
      width: width ?? AppSize.s100,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(30)),
    ),
  );
}

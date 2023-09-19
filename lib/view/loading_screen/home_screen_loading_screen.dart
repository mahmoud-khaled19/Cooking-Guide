import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/values_manager.dart';

class LoadingHomeScreen extends StatelessWidget {
  const LoadingHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSize.s16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textLoadingItem(),
                SizedBox(
                  height: AppSize.s20,
                ),
                textLoadingItem(),
              ],
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[600]!,
              highlightColor: Colors.grey[300]!,
              child: Container(
                height: AppSize.s100,
                width: AppSize.s100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey),
              ),
            )
          ],
        ),
        SizedBox(
          height: AppSize.s30,
        ),
        textLoadingItem(),
        SizedBox(
          height: AppSize.s10,
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
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: AppSize.s16,
        ),
        textLoadingItem(),
        SizedBox(
          height: AppSize.s10,
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
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: AppSize.s50,
        ),
        textLoadingItem(
          width: AppSize.s170
        ),
        SizedBox(
          height: AppSize.s20,
        ),
        Row(
          children: [
            textLoadingItem(),
            SizedBox(
              width: AppSize.s20,
            ),
            textLoadingItem(),
          ],
        ),
      ],
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

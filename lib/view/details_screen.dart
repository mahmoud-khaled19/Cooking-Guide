import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view_model/app_cubit.dart';
import '../view_model/app_state.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  var date = cubit.mealFilter!.meals![index];
                  return Container(
                    height: AppSize.s70,
                    child: Row(
                      children: [
                        CachedNetworkImage(imageUrl: date.mealImage!),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        Expanded(child: Text(date.mealName!)),
                      ],
                    ),
                  );
                },
                itemCount: cubit.mealFilter?.meals!.length,
                physics: const BouncingScrollPhysics(),
              ))
            ],
          ),
        );
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/theme_manager.dart';
import 'package:food_app/view/auth_screens/login_screen.dart';
import 'package:food_app/view/home_screen.dart';
import 'package:food_app/view/layout_screen.dart';
import 'package:food_app/view_model/app_cubit.dart';
import 'package:food_app/view_model/bloc%20observer.dart';
import 'package:food_app/view_model/login_cubit/login_cubit.dart';
import 'package:food_app/view_model/register_cubit/register_cubit.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit()..getMealsCategory()..getMealsArea(),
        ),
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit()),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit()),
      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            theme: getLightApplicationTheme(),
            home:   LayoutScreen(),
          );
        },
      ),
    );
  }
}

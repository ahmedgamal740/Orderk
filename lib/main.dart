import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/layout/shop_app/cubit/states.dart';
import 'package:orderk/shared/components/constants.dart';
import 'package:orderk/shared/cubit/bloc_observer.dart';
import 'package:orderk/shared/cubit/cubit.dart';
import 'package:orderk/shared/network/local/cache_helper.dart';
import 'package:orderk/shared/network/remote/dio_helper.dart';
import 'package:orderk/shared/styles/themes.dart';

import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/shop_login/shop_login_screen.dart';

void main() {
  BlocOverrides.runZoned(
        ()async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      Widget widget;
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      token = CacheHelper.getData(key: 'isToken');
      print("token is $token");
      if(onBoarding != null){
        if(token != null){
          widget = const ShopLayout();
        }else{
          widget = ShopLoginScreen();
        }
      }else{
        widget = const OnBoardingScreen();
      }
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({Key? key, this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getProfile()..getCarts()..getQuestions()..getAddress()..getOrders()),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}


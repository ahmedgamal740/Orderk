import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/modules/shop_login/cubit/states.dart';
import 'package:orderk/shared/components/constants.dart';

import '../../../models/shop_app/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  //late ShopLoginModel loginModel;
  void userLogin({
  required String email,
  required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value) {
      print(value.data);
      profileModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_rounded;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(ShopLoginChangePasswordVisibilityState());
  }
}
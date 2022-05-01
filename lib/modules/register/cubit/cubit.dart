
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/modules/register/cubit/states.dart';

import '../../../models/shop_app/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel registerModel;
  void userRegister({
  required String name,
  required String phone,
  required String email,
  required String password,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
        },
    ).then((value) {
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_rounded;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
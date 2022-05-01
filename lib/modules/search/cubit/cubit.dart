
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/modules/search/cubit/states.dart';

import '../../../models/shop_app/search_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopSearchCubit extends Cubit<ShopSearchStates>{
  ShopSearchCubit() : super(ShopSearchInitialState());
  static ShopSearchCubit get(context) => BlocProvider.of(context);

  late SearchModel searchModel;
  void getSearch(text){
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {
          'text':text,
        },
        token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorState(error));
    });
  }
}
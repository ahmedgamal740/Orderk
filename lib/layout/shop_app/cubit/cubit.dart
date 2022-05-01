import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/layout/shop_app/cubit/states.dart';
import 'package:orderk/models/shop_app/address_model.dart';
import 'package:orderk/models/shop_app/cart_add_remove.dart';
import 'package:orderk/models/shop_app/get_carts.dart';
import 'package:orderk/models/shop_app/get_orders_model.dart';
import 'package:orderk/models/shop_app/order_details_model.dart';
import 'package:orderk/models/shop_app/product_details_model.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../models/shop_app/question_model.dart';
import '../../../modules/carts/cart_screen.dart';
import '../../../modules/categories/categories_screen.dart';
import '../../../modules/favorites/favorites_screen.dart';
import '../../../modules/products/products_screen.dart';
import '../../../modules/shop_login/shop_login_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
  ];
  void changeBottomNav(index){
    currentIndex = index;
    if(currentIndex == 2){
      getFavorites();
      emit(ShopChangeBottomNavState());
    }
    if(currentIndex == 3){
      getCarts();
      emit(ShopChangeBottomNavState());
    }
    emit(ShopChangeBottomNavState());
  }
  void signOut(context){

    emit(ShopLoadingLogoutState());
    DioHelper.postData(
      url: 'logout',
      data: {

      },
      token: token,
    ).then((value) {
      CacheHelper.removeData(key: 'isToken').then((value) {
        token = '';
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      });
      emit(ShopSuccessLogoutState());
    }).catchError((error){
      emit(ShopErrorLogoutState(error.toString()));
    });
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
        cart.addAll({
          element.id: element.inCart,
        });
        if(element.inCart)
        {
          counter++;
        }
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId
        },
        token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }

  void getProfile(){
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){
      profileModel = ShopLoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessGetProfileState(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetProfileState(error.toString()));
    });
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
}){
    emit(ShopLoadingUpdateProfileState());
    DioHelper.putData(
      url: UPDATEPROFILE,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
      token: token,
    ).then((value){
      profileModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateProfileState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateProfileState(error.toString()));
    });
  }


  void addAddress({
  required String city,
  required String name,
  required String region,
  required String details,
}){
    emit(ShopLoadingAddAddressState());
    DioHelper.postData(
      url: ADDRESS,
      data: {
        "name": name,
        "city": city,
        "region": region,
        "details": details,
        "latitude": 30.0616863,
        "longitude": 31.3260088,
        "notes": "Work address"
      },
      token: token,
    ).then((value) {
      emit(ShopSuccessAddAddressState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorAddAddressState(error.toString()));
    });
  }

  AddressModel? addressModel;
  void getAddress(){
    emit(ShopLoadingGetAddressState());
    DioHelper.getData(
      url: ADDRESS,
      token: token,
    ).then((value){
      addressModel = AddressModel.fromJson(value.data);
      emit(ShopSuccessGetAddressState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetAddressState(error.toString()));
    });
  }

  void updateAddress({
    required int addressId,
    required String city,
    required String name,
    required String region,
    required String details,
  }){
    emit(ShopLoadingUpdateAddressState());
    DioHelper.putData(
      url: '$ADDRESS/$addressId',
      data: {
        "name": name,
        "city": city,
        "region": region,
        "details": details,
        "latitude": 30.0616863,
        "longitude": 31.3260088,
        "notes": "Work address"
      },
      token: token,
    ).then((value){
      addressModel = AddressModel.fromJson(value.data);
      emit(ShopSuccessUpdateAddressState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateAddressState(error.toString()));
    });
  }

  int counter = 0;
  void changeLocalCart(id)
  {
    cart[id] = !cart[id]!;

    if(cart[id]!)
    {
      counter++;
    } else
    {
      counter--;
    }

    emit(ShopChangeCartLocalState());
  }

  CartAddRemove? cartAddRemoveModel;
  void addToCart(int productId){
    changeLocalCart(productId);
    emit(ShopLoadingAddToCartState());
    DioHelper.postData(
      url: CARTS,
      data: {
        'product_id':productId
      },
      token: token,
    ).then((value) {
      cartAddRemoveModel = CartAddRemove.fromJson(value.data);
      if(cartAddRemoveModel!.status == false)
      {
        changeLocalCart(productId);
      }

      emit(ShopSuccessAddToCartState(cartAddRemoveModel!));
      getCarts();
    }).catchError((error){
      changeLocalCart(productId);
      emit(ShopErrorAddToCartState(error.toString()));
    });
  }

  GetCarts? getCartsModel;
  void getCarts(){
    emit(ShopLoadingGetCartState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value){
      getCartsModel = GetCarts.fromJson(value.data);
      emit(ShopSuccessGetCartState());
    }).catchError((error){
      emit(ShopErrorGetCartState(error.toString()));
    });
  }

  void updateCart(int productId, int quantity){
    emit(ShopLoadingUpdateCartState());
    DioHelper.putData(
      url: 'carts/$productId',
      data: {
        'quantity': quantity,
      },
      token: token,
    ).then((value){
      emit(ShopSuccessUpdateCartState());
      getCarts();
    }).catchError((error){
      emit(ShopErrorUpdateCartState(error.toString()));
    });
  }

  QuestionsModel?  questionsModel;
  void getQuestions(){
    emit(ShopLoadingQuestionsState());
    DioHelper.getData(
      url: FAQS,
    ).then((value){
      questionsModel = QuestionsModel.fromJson(value.data);
      emit(ShopSuccessQuestionsState());
    }).catchError((error){
      emit(ShopErrorQuestionsState());
    });
  }

  bool isChecked = false;
  void changeCheckedOrder(bool value){
      isChecked = !isChecked;
      emit(ShopChangeCheckState());
  }
  void addOrder({
    required int addressId,
    required int paymentMethod,
}){
    emit(ShopLoadingAddOrderState());
    DioHelper.postData(
      url: ORDERS,
      data: {
        "address_id": addressId,
        "payment_method": paymentMethod,
        "use_points": false
      },
      token: token,
    ).then((value) {
      emit(ShopSuccessAddOrderState());
      getCarts();
    }).catchError((error){
      emit(ShopErrorAddOrderState(error.toString()));
    });
  }

  GetOrdersModel? getOrdersModel;
  void getOrders(){
    emit(ShopLoadingGetOrdersState());
    DioHelper.getData(
      url: ORDERS,
      token: token,
    ).then((value){
      getOrdersModel = GetOrdersModel.fromJson(value.data);
      emit(ShopSuccessGetOrdersState());
    }).catchError((error){
      emit(ShopErrorGetOrdersState(error.toString()));
    });
  }

  OrderDetailsModel? orderDetailsModel;
  void getOrderDetails({
    required int orderId,
}){
    emit(ShopLoadingGetOrderDetailsState());
    DioHelper.getData(
      url: 'orders/$orderId',
      token: token,
    ).then((value){
      orderDetailsModel = OrderDetailsModel.fromJson(value.data);
      emit(ShopSuccessGetOrderDetailsState());
    }).catchError((error){
      emit(ShopErrorGetOrderDetailsState(error.toString()));
    });
  }

  ProductDetailsModel? productDetailsModel;
  void getProductDetails({
  required int productId,
}){
    emit(ShopLoadingProductDetailsState());
    DioHelper.getData(
      url: '$PRODUCTS/$productId',
      token: token,
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccessProductDetailsState());
    }).catchError((error){
      emit(ShopErrorProductDetailsState(error.toString()));
    });
  }
}


import '../../../models/shop_app/cart_add_remove.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
//Home
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{
  final String error;
  ShopErrorHomeDataState(this.error);
}
//Categories
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{
  final String error;
  ShopErrorCategoriesState(this.error);
}
//ChangeFavorites
class ShopChangeFavoritesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel changeFavoritesModel;
  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);
}
class ShopErrorChangeFavoritesState extends ShopStates{
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}
//GetFavorites
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{
  final String error;
  ShopErrorGetFavoritesState(this.error);
}
//GetProfile
class ShopLoadingGetProfileState extends ShopStates{}
class ShopSuccessGetProfileState extends ShopStates{
  final ShopLoginModel profileModel;
  ShopSuccessGetProfileState(this.profileModel);
}
class ShopErrorGetProfileState extends ShopStates{
  final String error;
  ShopErrorGetProfileState(this.error);
}
//UpdateProfile
class ShopLoadingUpdateProfileState extends ShopStates{}
class ShopSuccessUpdateProfileState extends ShopStates{}
class ShopErrorUpdateProfileState extends ShopStates{
  final String error;
  ShopErrorUpdateProfileState(this.error);
}
//AddToCart
class ShopChangeCartLocalState extends ShopStates{}
class ShopLoadingAddToCartState extends ShopStates{}
class ShopSuccessAddToCartState extends ShopStates{
  final CartAddRemove cartAddRemove;
  ShopSuccessAddToCartState(this.cartAddRemove);
}
class ShopErrorAddToCartState extends ShopStates{
  final String error;
  ShopErrorAddToCartState(this.error);
}
//GetCart
class ShopLoadingGetCartState extends ShopStates{}
class ShopSuccessGetCartState extends ShopStates{}
class ShopErrorGetCartState extends ShopStates{
  final String error;
  ShopErrorGetCartState(this.error);
}
//UpdateCart
class ShopLoadingUpdateCartState extends ShopStates{}
class ShopSuccessUpdateCartState extends ShopStates{}
class ShopErrorUpdateCartState extends ShopStates{
  final String error;
  ShopErrorUpdateCartState(this.error);
}
//Questions
class ShopLoadingQuestionsState extends ShopStates{}
class ShopSuccessQuestionsState extends ShopStates{}
class ShopErrorQuestionsState extends ShopStates{}

//add address
class ShopLoadingAddAddressState extends ShopStates{}
class ShopSuccessAddAddressState extends ShopStates{}
class ShopErrorAddAddressState extends ShopStates{
  final String error;
  ShopErrorAddAddressState(this.error);
}
//get address
class ShopLoadingGetAddressState extends ShopStates{}
class ShopSuccessGetAddressState extends ShopStates{}
class ShopErrorGetAddressState extends ShopStates{
  final String error;
  ShopErrorGetAddressState(this.error);
}
//update address
class ShopLoadingUpdateAddressState extends ShopStates{}
class ShopSuccessUpdateAddressState extends ShopStates{}
class ShopErrorUpdateAddressState extends ShopStates{
  final String error;
  ShopErrorUpdateAddressState(this.error);
}
class ShopChangeCheckState extends ShopStates{}
class ShopCheckValidateCreditCardState extends ShopStates{}
//add order
class ShopLoadingAddOrderState extends ShopStates{}
class ShopSuccessAddOrderState extends ShopStates{}
class ShopErrorAddOrderState extends ShopStates{
  final String error;
  ShopErrorAddOrderState(this.error);
}
//get order
class ShopLoadingGetOrdersState extends ShopStates{}
class ShopSuccessGetOrdersState extends ShopStates{}
class ShopErrorGetOrdersState extends ShopStates{
  final String error;
  ShopErrorGetOrdersState(this.error);
}
//get order details
class ShopLoadingGetOrderDetailsState extends ShopStates{}
class ShopSuccessGetOrderDetailsState extends ShopStates{}
class ShopErrorGetOrderDetailsState extends ShopStates{
  final String error;
  ShopErrorGetOrderDetailsState(this.error);
}
//product details
class ShopLoadingProductDetailsState extends ShopStates{}
class ShopSuccessProductDetailsState extends ShopStates{}
class ShopErrorProductDetailsState extends ShopStates{
  final String error;
  ShopErrorProductDetailsState(this.error);
}
//logout
class ShopLoadingLogoutState extends ShopStates{}
class ShopSuccessLogoutState extends ShopStates{}
class ShopErrorLogoutState extends ShopStates{
  final String error;
  ShopErrorLogoutState(this.error);
}

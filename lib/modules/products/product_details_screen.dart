import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/shared/styles/colors.dart';
import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';



class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // if(state is ShopSuccessChangeFavoritesState){
        //   if(!state.changeFavoritesModel.status){
        //     showToast(
        //       context,
        //       message: state.changeFavoritesModel.message,
        //       state: ToastStates.error,
        //     );
        //   }
        // }
        // if(state is ShopSuccessAddToCartState){
        //   showToast(
        //     context,
        //     message: state.cartAddRemove.message!,
        //     state: ToastStates.success,
        //   );
        // }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context).productDetailsModel;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Product Details'
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(
                            cubit!.data!.image!,
                        ),
                        width: double.infinity,
                        height: 450,
                      ),
                      if(cubit.data!.discount != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        color: Colors.red,
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          cubit.data!.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              height: 1.1
                          ),
                        ),
                      ),
                      Text(
                        '${cubit.data!.price.round()}',
                        style: const TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if(cubit.data!.discount != 0)
                      Text(
                        '${cubit.data!.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Product Details',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    cubit.data!.description!,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.1,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(20),
                            bottomEnd: Radius.circular(20),
                          ),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: (){
                            ShopCubit.get(context).changeFavorites(cubit.data!.id!);
                          },
                          icon: Icon(
                            Icons.favorite_outlined,
                            color: ShopCubit.get(context).favorites[cubit.data!.id!]??false ? defaultColor : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(20),
                            bottomEnd: Radius.circular(20),
                          ),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).addToCart(cubit.data!.id!);
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: ShopCubit.get(context).cart[cubit.data!.id!]??false ? defaultColor : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}


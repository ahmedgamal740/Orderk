import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../models/shop_app/get_carts.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../orders/order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = ShopCubit.get(context).getCartsModel;
        const vatNumber = 7.1428571429;
        return ConditionalBuilder(
          condition: model!.data!.cartItems!.isNotEmpty,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Spacer(),
                    const Text('EGP '),
                    Text(
                      '${model.data!.subTotal!}',
                      style: const TextStyle(
                        color: defaultColor,
                      ),
                    ),
                  ],
                ),
                if(state is ShopLoadingUpdateCartState)
                  const SizedBox(
                    height: 5,
                  ),
                if(state is ShopLoadingUpdateCartState)
                  const LinearProgressIndicator(),
                if(state is ShopLoadingUpdateCartState)
                  const SizedBox(
                    height: 5,
                  ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildCartItem(context,index, model.data!.cartItems![index]),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: ShopCubit.get(context).getCartsModel!.data!.cartItems!.length,
                  ),
                ),
                defaultButton(
                    function: (){
                      dynamic vat = model.data!.subTotal! / vatNumber;
                      dynamic total = model.data!.subTotal! + vat;
                      navigatorTo(
                          context,
                          OrderScreen(
                            cartsModel: model,
                            vat: vat,
                            total: total,
                          ),
                      );
                    },
                    text: 'checkout'
                ),
              ],
            ),
          ),
          fallback: (context) => defaultFallback(text: 'No Products Yet, Please Add Some Products.'),
        );
      },
    );

  }

  Widget buildCartItem(context,int index,CartItems model, {discount = true}) => Container(
    height: 130,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                  '${model.product!.image}'
              ),
              width: 120,
              height: 120,
            ),
            if(model.product!.discount != 0 && discount)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.product!.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    height: 1.1
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Text('EGP '),
                  Text(
                    model.product!.price.toString(),
                    style: const TextStyle(
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if(model.product!.discount != 0 && discount)
                    Text(
                      model.product!.oldPrice.toString(),
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 28,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: defaultColor,
                    ),
                    child: IconButton(
                      onPressed: (){
                        if(model.quantity != 1){
                          ShopCubit.get(context).updateCart(
                              model.id!,
                              --model.quantity
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10
                    ),
                    child: Text(
                      '${model.quantity}',
                    ),
                  ),
                  Container(
                    height: 28,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: defaultColor,
                    ),
                    child: IconButton(
                      onPressed: (){
                        ShopCubit.get(context).updateCart(
                          model.id!,
                          ++model.quantity,
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).addToCart(model.product!.id!);
                    },
                    icon: const Icon(
                      Icons.remove_shopping_cart_sharp,
                      color: defaultColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


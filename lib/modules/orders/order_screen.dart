import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/layout/shop_app/cubit/cubit.dart';
import 'package:orderk/layout/shop_app/cubit/states.dart';
import 'package:orderk/shared/components/components.dart';
import 'package:orderk/shared/styles/colors.dart';

import '../../models/shop_app/get_carts.dart';
import '../../shared/components/constants.dart';
class OrderScreen extends StatelessWidget {
  GetCarts? cartsModel;
  dynamic vat;
  dynamic total;
  OrderScreen({Key? key, this.cartsModel, this.vat, this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessAddOrderState){
          cartsModel!.data!.subTotal = 0;
          vat = 0;
          total = 0;
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              content: const Text(
                'Payment Successful',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                ),
              ),
              title: const Text('Health Insurance'),
              firstColor: defaultColor,
              secondColor: Colors.white,
              headerIcon: const Icon(
                Icons.check_circle_outline,
                size: 120.0,
                color: Colors.white,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        int num = 0;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              if(state is ShopLoadingAddOrderState)
                const LinearProgressIndicator(),
              Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                elevation: 10,
                shadowColor: defaultColor,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[400],
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Address Details',
                              style: TextStyle(
                                height: 1.4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            defaultTextButton(
                                function: (){},
                                text: 'change'
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        cubit.addressModel!.data!.address!.last.name!,
                        style: const TextStyle(
                          height: 1.4,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cubit.addressModel!.data!.address!.last.city!,
                        style: const TextStyle(
                          height: 1.4,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cubit.addressModel!.data!.address!.last.region!,
                        style: const TextStyle(
                          height: 1.4,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cubit.addressModel!.data!.address!.last.details!,
                        style: const TextStyle(
                          height: 1.4,
                          color: Colors.grey,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        profileModel!.data!.phone!,
                        style: const TextStyle(
                          height: 1.4,
                          color: Colors.grey,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                elevation: 10,
                shadowColor: defaultColor,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: cubit.isChecked,
                            onChanged: (value){
                            cubit.changeCheckedOrder(value!);
                            if(value){
                              num = 1;
                              print(num);
                            }
                          },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Cash',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      myDivider(),
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value){},
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Online',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Sorry, Unavailable',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      myDivider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${cartsModel!.data!.subTotal!}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Vat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '$vat',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '$total',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                          function: (){
                            if(cubit.isChecked && cartsModel!.data!.subTotal != 0){
                              num = 1;
                              cubit.addOrder(
                                  addressId: cubit.addressModel!.data!.address!.last.id!,
                                  paymentMethod: num
                              );
                            }else{
                              showToast(context,
                                  message: 'Payment method must be selected',
                                  state: ToastStates.error
                              );
                            }
                          },
                          text: 'payment'
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

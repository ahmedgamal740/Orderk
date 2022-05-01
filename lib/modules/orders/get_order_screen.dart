import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:orderk/models/shop_app/get_orders_model.dart';
import 'package:orderk/shared/styles/colors.dart';
import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../shared/components/components.dart';
import 'order_details_screen.dart';

var dateTime = DateTime.now();
class GetOrdersScreen extends StatelessWidget {
  GetOrdersScreen({Key? key}) : super(key: key);
  var inputFormat = DateFormat('dd / MM / yyyy').format(dateTime);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessGetOrderDetailsState){
          navigatorTo(
              context,
              const OrderDetailsScreen(),
          );
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context).getOrdersModel;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Orders'
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! ShopLoadingGetOrdersState,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: defaultColor[400],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Total Orders',
                          style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${cubit!.data!.total!}',
                          style: const TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if(state is ShopLoadingGetOrderDetailsState)
                    const LinearProgressIndicator(),
                  if(state is ShopLoadingGetOrderDetailsState)
                    const SizedBox(
                      height: 10,
                    ),
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildOrderItem(context, cubit.data!.details![index]),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: cubit.data!.details!.length),
                  )
                ],
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildOrderItem(context, Details model) => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.id}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              '${model.total.round()} EGP',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Row(
              children: [
                Text(
                  '${model.date}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  width: 20,
                ),
                if(inputFormat == '${model.date}')
                  Text(
                  '${model.status}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.green
                  ),
                ),
                if(inputFormat != '${model.date}')
                  Text(
                  'Old',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      IconButton(
          onPressed: (){
            ShopCubit.get(context).getOrderDetails(orderId: model.id!);
          },
          icon: const Icon(
              Icons.arrow_forward_ios_outlined
          ),
      ),
    ],
  );
}


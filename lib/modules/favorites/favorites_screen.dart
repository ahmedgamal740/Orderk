import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).favoritesModel!.data!.data!.isNotEmpty,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildProductItem(context, ShopCubit.get(context).favoritesModel!.data!.data![index].product!),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
            ),
            fallback: (context) => defaultFallback(text: 'No Favorites Yet, Please Add Some Favorites.'),
        );
      },
      );

  }

}


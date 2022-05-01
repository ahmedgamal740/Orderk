import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/modules/products/product_details_screen.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../models/shop_app/categories_model.dart';
import '../../models/shop_app/home_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessProductDetailsState){
          navigatorTo(context, const ProductDetailsScreen());
        }
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.changeFavoritesModel.status){
            showToast(
                context,
                message: state.changeFavoritesModel.message,
                state: ToastStates.error,
            );
          }
        }
        if(state is ShopSuccessAddToCartState){
          showToast(
            context,
            message: state.cartAddRemove.message!,
            state: ToastStates.success,
          );
        }

      },
      builder: (context, state) {
        return RefreshIndicator(
            child: ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
              builder: (context) => productsBuilder(context,state, ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
            onRefresh: () async{

          return ShopCubit.get(context).getHomeData();
        },
        );
      },
    );
  }

  Widget productsBuilder(context,state, HomeModel model, CategoriesModel categoriesModel) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        if(state is ShopLoadingProductDetailsState)
          const LinearProgressIndicator(),
        if(state is ShopLoadingProductDetailsState)
          const SizedBox(
            height: 5,
          ),
        CarouselSlider(
            items: model.data.banners.map((e) => Image(
              image: NetworkImage(e.image),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              initialPage: 0,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoriesItem(categoriesModel.data.data[index]),
                    separatorBuilder: (context, index) => const SizedBox(width: 10,),
                    itemCount: categoriesModel.data.data.length,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'New Products',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey,
          child: GridView.count(
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(
                model.data.products.length,
                  (index) => buildGridProducts(context, model.data.products[index]),
            ),
          ),
        ),
      ],
    ),
  );
  Widget buildGridProducts(context, ProductModel model) => InkWell(
    onTap: (){

      ShopCubit.get(context).getProductDetails(productId: model.id);
    },
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.image!
                ),
                width: double.infinity,
                height: 200,
              ),
              if(model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.1
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if(model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                        color: Colors.grey,
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor: ShopCubit.get(context).favorites[model.id]??false ? defaultColor : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          ),
                        ),
                    ),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).addToCart(model.id);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: ShopCubit.get(context).cart[model.id]??false ? defaultColor : Colors.grey,
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
    ),
  );

  Widget buildCategoriesItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black54,
        width: 100,
        child: Text(
          model.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

}


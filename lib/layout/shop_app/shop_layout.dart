import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/modules/address/update_address_screen.dart';
import 'package:orderk/shared/styles/colors.dart';
import '../../modules/orders/get_order_screen.dart';
import '../../modules/questions/questions_screen.dart';
import '../../modules/search/search_Screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'ORDERK',
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navigatorTo(
                      context,
                      SearchScreen(),
                  );
                },
                icon: const Icon(
                    Icons.search
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                if(profileModel != null)
                  UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: defaultColor.shade400
                  ),
                  accountName: Text(
                    '${profileModel!.data!.name}',
                    style: const TextStyle(
                        color: Colors.white
                    ),
                  ),
                  accountEmail: Text(
                    '${profileModel!.data!.email}',
                    style: const TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                      Icons.settings_outlined
                  ),
                  title: const Text('Settings'),
                  onTap: () {
                    navigatorTo(
                        context,
                        SettingsScreen(),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                      Icons.person_outline_rounded
                  ),
                  title: const Text('Address'),
                  onTap: () {
                    navigatorTo(
                      context,
                      UpdateAddressScreen(),
                    );
                  },
                ),
                myDivider(),
                ListTile(
                  leading: const Icon(
                      Icons.payments_outlined
                  ),
                  title: const Text('Orders'),
                  onTap: () {
                    ShopCubit.get(context).getOrders();
                    navigatorTo(
                      context,
                      GetOrdersScreen(),
                    );
                    },
                ),
                myDivider(),
                ListTile(
                  leading: const Icon(
                      Icons.question_answer_outlined
                  ),
                  title: const Text('Question'),
                  onTap: () {
                    navigatorTo(
                      context,
                      const QuestionsScreen(),
                    );
                  },
                ),
                myDivider(),
                ListTile(
                  leading: const Icon(
                      Icons.logout_outlined
                  ),
                  title: const Text('Logout'),
                  onTap: () {
                    cubit.signOut(context);
                  },
                ),
              ],
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                Icons.home_outlined
              ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined
              ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    Icon(
                      Icons.favorite_border_outlined
              ),
                    // if(ShopCubit.get(context).favoritesModel!.data!.data!.isNotEmpty)
                    //   Container(
                    //     decoration: const BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Colors.red,
                    //     ),
                    //     padding: const EdgeInsets.all(3.0,),
                    //     child: Text(
                    //       ShopCubit.get(context).favoritesModel!.data!.data!.length >= 9 ? '9' : ShopCubit.get(context).favoritesModel!.data!.data!.length.toString(),
                    //       style: const TextStyle(
                    //           color: Colors.white
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: const [
                    Icon(
                        Icons.shopping_cart_outlined
                    ),
                    // if(ShopCubit.get(context).getCartsModel!.data!.cartItems!.isNotEmpty)
                    //   Container(
                    //     decoration: const BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Colors.red,
                    //     ),
                    //     padding: const EdgeInsets.all(3.0,),
                    //     child: Text(
                    //       ShopCubit.get(context).getCartsModel!.data!.cartItems!.length >= 9 ? '9' : ShopCubit.get(context).getCartsModel!.data!.cartItems!.length.toString(),
                    //       style: const TextStyle(
                    //         color: Colors.white
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
                label: 'Carts',
              ),
            ],
          ),
        );
      },
      );
  }
}

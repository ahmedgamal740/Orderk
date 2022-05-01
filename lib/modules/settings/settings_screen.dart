import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../shared/components/components.dart';

import '../../shared/components/constants.dart';
import '../address/add_address_screen.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = profileModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Settings',
            ),
          ),
          body: ConditionalBuilder(
            condition: profileModel != null,
            builder: (context) => buildProfileItem(context, state),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
      );

  }

  Widget buildProfileItem(context, ShopStates state) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Form(
      key: formKey,
      child: Column(
        children: [
          if(state is ShopLoadingUpdateProfileState)
          const LinearProgressIndicator(),
          const SizedBox(
            height: 15,
          ),
          defaultFormField(
            controller: nameController,
            type: TextInputType.name,
            validate: (value){
              if(value!.isEmpty){
                return 'name must be not empty';
              }
              return null;
            },
            label: 'Name',
            prefix: Icons.person,
          ),
          const SizedBox(
            height: 15,
          ),
          defaultFormField(
            controller: emailController,
            type: TextInputType.emailAddress,
            validate: (value){
              if(value!.isEmpty){
                return 'email must be not empty';
              }
              return null;
            },
            label: 'Email Address',
            prefix: Icons.email,
          ),
          const SizedBox(
            height: 15,
          ),
          defaultFormField(
            controller: phoneController,
            type: TextInputType.phone,
            validate: (value){
              if(value!.isEmpty){
                return 'phone must be not empty';
              }
              return null;
            },
            label: 'Phone',
            prefix: Icons.phone,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: defaultButton(
                    function: (){
                      if(formKey.currentState!.validate()){
                        ShopCubit.get(context).updateProfile(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'update'
                ),
              ),
              if (ShopCubit.get(context).addressModel!.data!.address!.isEmpty)
                const SizedBox(
                  width: 10,
                ),
              if (ShopCubit.get(context).addressModel!.data!.address!.isEmpty)
                Expanded(
                  child: defaultButton(
                      function: (){
                        navigatorTo(
                            context,
                            AddAddressScreen(),
                        );
                      },
                      text: 'add address'
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}


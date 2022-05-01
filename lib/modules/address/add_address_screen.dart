import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var cityDropDownValue = 'Cairo';
  var regionController = TextEditingController();
  var detailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // if (state is ShopSuccessAddAddressState){
        //   navigatorTo(
        //       context,
        //       SettingsScreen(),
        //   );
        // }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: buildProfileItem(context, state),
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
          if(state is ShopLoadingAddAddressState)
            const LinearProgressIndicator(),
          const SizedBox(
            height: 15,
          ),
          DropdownButtonFormField(
            value: cityDropDownValue,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('City'),
            ),
            items: city
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value){
              cityDropDownValue = value.toString();
            },
          ),
          const SizedBox(
            height: 15,
          ),
          defaultFormField(
            controller: regionController,
            type: TextInputType.streetAddress,
            validate: (value){
              if(value!.isEmpty){
                return 'region must be not empty';
              }
              return null;
            },
            label: 'Region',
            prefix: Icons.location_city_outlined,
          ),
          const SizedBox(
            height: 15,
          ),
          defaultFormField(
            controller: detailsController,
            type: TextInputType.streetAddress,
            validate: (value){
              if(value!.isEmpty){
                return 'street address must be not empty';
              }
              return null;
            },
            label: 'Street Address',
            prefix: Icons.streetview_outlined,
          ),
          const SizedBox(
            height: 15,
          ),
          defaultButton(
              function: (){
                if(formKey.currentState!.validate()){
                  ShopCubit.get(context).addAddress(
                    name: profileModel!.data!.name!,
                    city: cityDropDownValue,
                    region: regionController.text,
                    details: detailsController.text,
                  );
                }
              },
              text: 'submit'
          ),
        ],
      ),
    ),
  );
}


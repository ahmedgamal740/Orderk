import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class UpdateAddressScreen extends StatelessWidget {
  UpdateAddressScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  String? cityDropDownValue;
  var regionController = TextEditingController();
  var detailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = ShopCubit.get(context).addressModel!.data!.address!.last;
        cityDropDownValue = model.city!;
        regionController.text = model.region!;
        detailsController.text = model.details!;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Address',
            ),
          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).addressModel != null,
            builder: (context) => buildAddressItem(context, state),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
        );
      },
    );

  }

  Widget buildAddressItem(context, ShopStates state) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Form(
      key: formKey,
      child: Column(
        children: [
          if(state is ShopLoadingUpdateAddressState)
            const LinearProgressIndicator(),
          if(state is ShopLoadingUpdateAddressState)
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
                  ShopCubit.get(context).updateAddress(
                    addressId: ShopCubit.get(context).addressModel!.data!.address!.last.id!,
                    name: profileModel!.data!.name!,
                    city: cityDropDownValue!,
                    region: regionController.text,
                    details: detailsController.text,
                  );
                }
              },
              text: 'update'
          ),
        ],
      ),
    ),
  );
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value){
                        if(value.isEmpty){
                          return 'enter text to search';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      onSubmit: (text){
                        ShopSearchCubit.get(context).getSearch(text);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is ShopSearchLoadingState)
                    const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is ShopSearchSuccessState)
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildProductItem(context, ShopSearchCubit.get(context).searchModel.data!.data![index], discount: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: ShopSearchCubit.get(context).searchModel.data!.data!.length
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


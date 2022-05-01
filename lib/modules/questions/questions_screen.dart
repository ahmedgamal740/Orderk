
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/layout/shop_app/cubit/cubit.dart';
import 'package:orderk/layout/shop_app/cubit/states.dart';
import 'package:orderk/models/shop_app/question_model.dart';
import 'package:orderk/shared/components/components.dart';


class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).questionsModel!.data;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Questions',
            ),
          ),
          body: RefreshIndicator(
            child: ConditionalBuilder(
              condition: state is! ShopLoadingQuestionsState,
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildQuestionsItem(model!.detail![index]),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: model!.detail!.length,
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
            onRefresh: () async{

              return ShopCubit.get(context).getQuestions();
            },
          ),
        );
      },
    );
  }

  Widget buildQuestionsItem(Detail model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.question!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 3,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10
          ),
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(15),
              topStart: Radius.circular(15),
              bottomEnd: Radius.circular(15),
            ),
          ),
          child : Text(
            model.answer!,
            style: const TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ],
    ),
  );
}

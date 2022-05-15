import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:orderk/layout/shop_app/cubit/cubit.dart';
import 'package:orderk/layout/shop_app/cubit/states.dart';
import 'package:orderk/layout/shop_app/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
class CreditCardScreen extends StatelessWidget {
  CreditCardScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var cardNumberController = TextEditingController().text;
  var cardHolderNameController = TextEditingController().text;
  var expiryDateController = TextEditingController().text;
  var cvvCodeController = TextEditingController().text;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessAddOrderState && ShopCubit.get(context).isCheckedOnline){
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
          ShopCubit.get(context).isCheckedOnline = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: (){
                  navigateAndFinish(
                    context,
                    const ShopLayout(),
                  );
                },
                icon: const Icon(Icons.arrow_back)
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(state is ShopLoadingAddOrderState)
                  const LinearProgressIndicator(),
                if(state is ShopLoadingAddOrderState)
                  const SizedBox(
                    height: 15,
                  ),
                CreditCardWidget(
                  glassmorphismConfig: Glassmorphism(
                    blurX: 10.0,
                    blurY: 10.0,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Colors.grey,
                        Colors.blue.shade300,
                      ],
                      stops: const <double>[
                        0.3,
                        0,
                      ],
                    ),
                  ), onCreditCardWidgetChange: (CreditCardBrand data ) {  },
                  cardHolderName: '',
                  expiryDate: '',
                  showBackView: true,
                  cvvCode: '',
                  cardNumber: '',
                ),
                CreditCardForm(
                  formKey: formKey,
                  cardNumber: cardNumberController,
                  cardHolderName: cardHolderNameController,
                  expiryDate: expiryDateController,
                  cvvCode: cvvCodeController,// Required
                  onCreditCardModelChange: (CreditCardModel data) {}, // Required
                  themeColor: Colors.red,
                  obscureCvv: true,
                  obscureNumber: true,
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  cardNumberDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Holder',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          ShopCubit.get(context).addOrder(
                              addressId:ShopCubit.get(context).addressModel!.data!.address!.last.id!,
                              paymentMethod: 2
                          );
                        }
                      },
                      text: 'validate'
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
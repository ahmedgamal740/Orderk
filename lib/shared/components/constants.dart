
import '../../models/shop_app/login_model.dart';

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String? token = '';
ShopLoginModel? profileModel;
List<String> city = [
  'Al Beheira',
  'Al Daqahliya',
  'Alexandaria',
  'Al Fayoum',
  'Al Gharbia',
  'Al Menyia',
  'Al Monufia',
  'Al Sharqia',
  'Aswan',
  'Asyut',
  'Bani Souaif',
  'Cairo',
  'Damietta',
  'Giza',
  'Ismailia',
  'Kafr El-Shiekh',
  'Luxor',
  'North Coast',
  'Port Said',
  'Qalyubia',
  'Qena',
  'Red Sea',
  'Sohag',
  'South Sinai',
  'Suez',
];
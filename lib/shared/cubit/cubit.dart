import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orderk/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  int currentIndex = 0;
  // List<Widget> screen = [
  //   const NewTasksScreen(),
  //   const DoneTasksScreen(),
  //   const ArchivedTasksScreen(),
  // ];
  // List<String> title = [
  //   'New Tasks',
  //   'Done Tasks',
  //   'Archived Tasks',
  // ];
  static AppCubit get(context) => BlocProvider.of(context);
//   void changeIndex(int index){
//     currentIndex = index;
//     emit(AppChangeBottomNavigationBar());
//   }
//
//   late Database database;
//   List<Map> newTasks = [];
//   List<Map> doneTasks = [];
//   List<Map> archivedTasks = [];
//
//   void createDatabase() {
//     openDatabase(
//       'todo.db',
//       version: 1,
//       onCreate: (database, version){
//         print('Database Created');
//         database.execute(
//             'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'
//         ).then((value) {
//           print('Table Created');
//         }).catchError((error){
//           print('error ${error.toString()}');
//         });
//       },
//       onOpen: (database){
//         getDatabase(database);
//         print('database opened');
//       },
//     ).then((value) {
//       database = value;
//       emit(AppCreateDatabaseState());
//     });
//   }
//
//   void insertDatabase({
//     required String title,
//     required String date,
//     required String time,
//   })async {
//     await database.transaction((txn) async {
//       txn.rawInsert(
//           'INSERT INTO tasks (title, date, time, status) VALUES ("$title", "$date", "$time", "new")'
//       ).then((value){
//         print('$value inserted successfully');
//         emit(AppInsertDatabaseState());
//         getDatabase(database);
//       }).catchError((error){
//         print('error insert $error');
//       });
//       return null;
//     });
//   }
//
//   void getDatabase(database){
//     newTasks = [];
//     doneTasks = [];
//     archivedTasks = [];
//     emit(AppGetDatabaseLoadingState());
//     database.rawQuery('SELECT * FROM tasks').then((value) {
//       value.forEach((element) {
//         if(element['status'] == 'new')
//           {
//             newTasks.add(element);
//             print(newTasks);
//           }
//         else if(element['status'] == 'done')
//           {
//             doneTasks.add(element);
//           }
//         else {
//           archivedTasks.add(element);
//         }
//       });
//       emit(AppGetDatabaseState());
//     });
//   }
//
//   void updateData({
//     required String status,
//     required int id,
// }){
//     database.rawUpdate(
//         'UPDATE tasks SET status = ? WHERE id = ?',
//         [status, id]
//     ).then((value) {
//       emit(AppUpdateDatabaseState());
//       getDatabase(database);
//     });
//   }
//
//   void deleteData({
//     required int id,
//   }){
//     database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]
//     ).then((value) {
//       emit(AppDeleteDatabaseState());
//       getDatabase(database);
//     });
//   }
//
//   bool isBottomSheetShow = false;
//   IconData fabIcon = Icons.edit;
//   void changeBottomSheet({
//     required bool isShow,
//     required IconData icon,
// }){
//     isBottomSheetShow = isShow;
//     fabIcon = icon;
//     emit(AppChangeBottomSheet());
//   }

  // bool isDark = false;
  // void changeMode({bool? fromShared}){
  //   if(fromShared != null){
  //     isDark = fromShared;
  //     emit(AppChangeModeState());
  //   }
  //   else{
  //     isDark = !isDark;
  //     CacheHelper.putBoolean(
  //       key: 'isDark',
  //       value: isDark,
  //     ).then((value) {
  //       emit(AppChangeModeState());
  //     });
  //   }
  //
  // }
}
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'example_widget_model.g.dart';

class ExampleWidgetModel {
  Future <Box<User>>? userBox;
  void setup() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(
        UserAdapter(),
      );
    }
    //Первичное открытие box
    userBox =  Hive.openBox<User>('user_box');
    userBox?.then((box){
      box.listenable().addListener((){
        print(box.values);
      });
    });
  }

  void doSome() async {
    final box = await userBox;

    final user = User('Ivan', 17);
    await box?.add(user);
  }
}

//Сохраняем обьект в Hive
@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;

  User(this.name, this.age);

  @override
  String toString() => 'Name: $name, Age: $age'; //Just for print
}

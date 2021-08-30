import 'package:hive/hive.dart';
part 'historyitem.g.dart';

@HiveType(typeId: 0)
class History extends HiveObject {
  @HiveField(0)
  late String first;
  @HiveField(1)
  late String second;
  @HiveField(2)
  late String ans;
  @HiveField(3)
  late String zero;
}

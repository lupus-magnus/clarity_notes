import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

abstract class InitDbService {
  static Future<void> init() async {
    final p = await path.getApplicationDocumentsDirectory();

    Hive.init(p.path);
    await Hive.initFlutter('hive_db');
    await Hive.openBox('category');
  }
}

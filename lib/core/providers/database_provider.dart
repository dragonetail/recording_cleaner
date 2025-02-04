import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recording_cleaner/data/models/contact_model.dart';

/// 数据库提供者
class DatabaseProvider {
  /// 创建[DatabaseProvider]实例
  DatabaseProvider();

  /// Isar实例
  Isar? _isar;

  /// 获取Isar实例
  Future<Isar> get isar async {
    if (_isar != null) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ContactModelSchema],
      directory: dir.path,
    );

    return _isar!;
  }

  /// 关闭数据库
  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}

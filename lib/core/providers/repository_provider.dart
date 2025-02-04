import 'package:recording_cleaner/core/providers/database_provider.dart';
import 'package:recording_cleaner/core/utils/app_logger.dart';
import 'package:recording_cleaner/data/repositories/contact_repository_impl.dart';
import 'package:recording_cleaner/data/sources/contact_source.dart';
import 'package:recording_cleaner/domain/repositories/contact_repository.dart';

/// 仓库提供者
class RepositoryProvider {
  /// 创建[RepositoryProvider]实例
  RepositoryProvider({
    required AppLogger logger,
    required DatabaseProvider databaseProvider,
  })  : _logger = logger,
        _databaseProvider = databaseProvider;

  final AppLogger _logger;
  final DatabaseProvider _databaseProvider;

  /// 联系人仓库
  ContactRepository? _contactRepository;

  /// 获取联系人仓库
  Future<ContactRepository> get contactRepository async {
    if (_contactRepository != null) {
      return _contactRepository!;
    }

    final isar = await _databaseProvider.isar;
    final contactSource = ContactSourceImpl(
      logger: _logger,
      isar: isar,
    );
    _contactRepository = ContactRepositoryImpl(
      logger: _logger,
      contactSource: contactSource,
    );

    return _contactRepository!;
  }
}

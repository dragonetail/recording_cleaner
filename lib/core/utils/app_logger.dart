import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:stack_trace/stack_trace.dart';

/// 应用日志工具类
///
/// 提供统一的日志记录功能，支持：
/// - 自动记录文件名和行号
/// - 统一的日志格式
/// - 多级别日志控制
/// - 日志文件管理
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  late final Logger _logger;

  /// 工厂构造函数
  factory AppLogger() {
    return _instance;
  }

  /// 私有构造函数
  AppLogger._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0, // 不显示方法调用栈
        errorMethodCount: 8, // 错误时显示8层调用栈
        lineLength: 80, // 每行最大长度
        colors: true, // 启用颜色
        printEmojis: true, // 启用表情
        printTime: true, // 打印时间
      ),
    );
  }

  /// 获取调用位置信息
  String _getCallerInfo() {
    final frames = Trace.current().frames;
    // 跳过本身的帧，获取调用者的帧
    final callerFrame = frames.length > 2 ? frames[2] : frames.last;
    final fileName = path.basename(callerFrame.library);
    return '[$fileName:${callerFrame.line}]';
  }

  /// 记录详细日志
  void v(String message, {dynamic error, StackTrace? stackTrace}) {
    final callerInfo = _getCallerInfo();
    if (error != null || stackTrace != null) {
      _logger.v('$callerInfo $message', error: error, stackTrace: stackTrace);
    } else {
      _logger.v('$callerInfo $message');
    }
  }

  /// 记录调试日志
  void d(String message, {dynamic error, StackTrace? stackTrace}) {
    final callerInfo = _getCallerInfo();
    if (error != null || stackTrace != null) {
      _logger.d('$callerInfo $message', error: error, stackTrace: stackTrace);
    } else {
      _logger.d('$callerInfo $message');
    }
  }

  /// 记录信息日志
  void i(String message, {dynamic error, StackTrace? stackTrace}) {
    final callerInfo = _getCallerInfo();
    if (error != null || stackTrace != null) {
      _logger.i('$callerInfo $message', error: error, stackTrace: stackTrace);
    } else {
      _logger.i('$callerInfo $message');
    }
  }

  /// 记录警告日志
  void w(String message, {dynamic error, StackTrace? stackTrace}) {
    final callerInfo = _getCallerInfo();
    if (error != null || stackTrace != null) {
      _logger.w('$callerInfo $message', error: error, stackTrace: stackTrace);
    } else {
      _logger.w('$callerInfo $message');
    }
  }

  /// 记录错误日志
  void e(String message, {dynamic error, StackTrace? stackTrace}) {
    final callerInfo = _getCallerInfo();
    if (error != null || stackTrace != null) {
      _logger.e('$callerInfo $message', error: error, stackTrace: stackTrace);
    } else {
      _logger.e('$callerInfo $message');
    }
  }

  /// 记录方法进入
  void methodEnter(String methodName, {Map<String, dynamic>? params}) {
    final callerInfo = _getCallerInfo();
    final paramsStr = params?.toString() ?? '';
    _logger.d('$callerInfo ▶ $methodName $paramsStr');
  }

  /// 记录方法退出
  void methodExit(String methodName, {dynamic result}) {
    final callerInfo = _getCallerInfo();
    final resultStr = result?.toString() ?? '';
    _logger.d('$callerInfo ◀ $methodName $resultStr');
  }

  /// 记录性能日志
  void performance(String operation, Duration duration) {
    final callerInfo = _getCallerInfo();
    _logger.i('$callerInfo ⚡ $operation 耗时: ${duration.inMilliseconds}ms');
  }
}

/// 全局日志记录器实例
final appLogger = AppLogger();

/// 应用常量配置
class AppConstants {
  /// 禁止实例化
  AppConstants._();

  /// 动画时长
  static const animationDuration = Duration(milliseconds: 300);

  /// 页面切换动画时长
  static const pageTransitionDuration = Duration(milliseconds: 300);

  /// 提示框显示时长
  static const snackBarDuration = Duration(seconds: 2);

  /// 列表动画间隔
  static const listAnimationInterval = Duration(milliseconds: 50);

  /// 列表动画起始延迟
  static const listAnimationDelay = Duration(milliseconds: 100);

  /// 列表项动画时长
  static const listItemAnimationDuration = Duration(milliseconds: 300);

  /// 列表项滑动阈值
  static const listItemSlideThreshold = 0.3;

  /// 列表项删除确认时长
  static const listItemDeleteConfirmDuration = Duration(seconds: 3);

  /// 存储空间警告阈值（90%）
  static const storageWarningThreshold = 0.9;

  /// 存储空间注意阈值（70%）
  static const storageCautionThreshold = 0.7;

  /// 最大文件大小显示单位
  static const maxFileSizeUnit = ['B', 'KB', 'MB', 'GB', 'TB'];

  /// 时长格式
  static const durationFormat = 'HH:mm:ss';

  /// 日期格式
  static const dateFormat = 'yyyy-MM-dd';

  /// 时间格式
  static const timeFormat = 'HH:mm';

  /// 日期时间格式
  static const dateTimeFormat = 'yyyy-MM-dd HH:mm';

  /// 文件大小格式（保留1位小数）
  static const fileSizeDecimalPlaces = 1;

  /// 百分比格式（保留1位小数）
  static const percentageDecimalPlaces = 1;

  /// 列表每页数量
  static const pageSize = 20;

  /// 最大选择数量
  static const maxSelectionCount = 100;

  /// 最小音频时长（秒）
  static const minAudioDuration = 1;

  /// 最大音频时长（秒）
  static const maxAudioDuration = 3600;

  /// 最小文件大小（字节）
  static const minFileSize = 1024;

  /// 最大文件大小（字节）
  static const maxFileSize = 1024 * 1024 * 1024;
}

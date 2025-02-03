import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// 引导页配置
class TutorialConfig {
  /// 禁止实例化
  TutorialConfig._();

  /// 创建概览页引导
  static TutorialCoachMark createOverviewTutorial(
    BuildContext context,
    List<TargetFocus> targets,
  ) {
    return TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      paddingFocus: 10,
      opacityShadow: 0.8,
      textSkip: '跳过',
      onFinish: () => true,
      onClickTarget: (target) => true,
      onSkip: () => true,
    );
  }

  /// 创建录音列表页引导
  static TutorialCoachMark createRecordingsTutorial(
    BuildContext context,
    List<TargetFocus> targets,
  ) {
    return TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      paddingFocus: 10,
      opacityShadow: 0.8,
      textSkip: '跳过',
      onFinish: () => true,
      onClickTarget: (target) => true,
      onSkip: () => true,
    );
  }

  /// 创建通话录音列表页引导
  static TutorialCoachMark createCallRecordingsTutorial(
    BuildContext context,
    List<TargetFocus> targets,
  ) {
    return TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      paddingFocus: 10,
      opacityShadow: 0.8,
      textSkip: '跳过',
      onFinish: () => true,
      onClickTarget: (target) => true,
      onSkip: () => true,
    );
  }

  /// 创建联系人列表页引导
  static TutorialCoachMark createContactsTutorial(
    BuildContext context,
    List<TargetFocus> targets,
  ) {
    return TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      paddingFocus: 10,
      opacityShadow: 0.8,
      textSkip: '跳过',
      onFinish: () => true,
      onClickTarget: (target) => true,
      onSkip: () => true,
    );
  }

  /// 获取概览页引导目标
  static List<TargetFocus> getOverviewTargets(BuildContext context) {
    return [
      TargetFocus(
        identify: 'storage_card',
        keyTarget: GlobalKey(),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '存储空间',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '显示设备存储空间使用情况',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'recordings_card',
        keyTarget: GlobalKey(),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '录音文件',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '显示录音文件统计信息',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'call_recordings_card',
        keyTarget: GlobalKey(),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '通话录音',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '显示通话录音统计信息',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  /// 获取录音列表页引导目标
  static List<TargetFocus> getRecordingsTargets(BuildContext context) {
    return [
      TargetFocus(
        identify: 'recordings_list',
        keyTarget: GlobalKey(),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '录音列表',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '左滑可删除录音文件\n右滑可收藏录音文件',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'select_mode',
        keyTarget: GlobalKey(),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '批量操作',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '点击可进入批量选择模式',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  /// 获取通话录音列表页引导目标
  static List<TargetFocus> getCallRecordingsTargets(BuildContext context) {
    return [
      TargetFocus(
        identify: 'call_recordings_list',
        keyTarget: GlobalKey(),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '通话录音列表',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '左滑可删除通话录音\n右滑可标记重要通话',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'select_mode',
        keyTarget: GlobalKey(),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '批量操作',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '点击可进入批量选择模式',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  /// 获取联系人列表页引导目标
  static List<TargetFocus> getContactsTargets(BuildContext context) {
    return [
      TargetFocus(
        identify: 'contacts_list',
        keyTarget: GlobalKey(),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '联系人列表',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '左滑可设置联系人分类\n右滑可设置联系人保护',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'select_mode',
        keyTarget: GlobalKey(),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '批量操作',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '点击可进入批量选择模式',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }
}

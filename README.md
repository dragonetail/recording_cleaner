# FlutterCleaner（录音文件清理应用）

## 目录
1. [快速开始](#快速开始)
2. [核心功能](#核心功能)
3. [技术实现](#技术实现)
4. [界面规范](#界面规范)
5. [开发规范](#开发规范)
6. [项目协作](#项目协作)
7. [运维支持](#运维支持)
8. [最佳实践](#最佳实践)
9. [Cursor+AI相关](#cursorai相关)
10. [项目架构](#项目架构)
11. [UI设计规范](#ui设计规范)
12. [测试规范](#测试规范)
13. [发布管理](#发布管理)
14. [性能优化](#性能优化)
15. [错误处理](#错误处理)
16. [编译规范](#编译规范)
17. [更新日志](#更新日志)

## 术语说明

- **录音文件**：指用户通过应用直接录制的音频文件，主要用于个人备忘或其他用途的音频管理。
- **通话录音**：指通过应用记录的电话通话音频文件，主要用于管理和分析通话记录。

## 一、快速开始
### 1.1 项目简介
FlutterCleaner是一款专注于通话录音文件管理的跨平台应用，帮助用户高效管理和清理通话录音，优化设备存储空间。基于Flutter框架开发，采用Clean Architecture + BLoC模式架构，支持iOS和Android平台。

### 1.2 环境要求
- Flutter SDK: 3.19.3 或更高
- Dart SDK: 3.3.1 或更高
- iOS: 12.0+
- Android: 7.0+ (API 24)
- IDE: Android Studio / VS Code + Flutter插件

### 1.3 开发环境配置
1. 安装Flutter SDK
```bash
# macOS使用Homebrew安装
brew install flutter

# 或者手动下载安装
# 1. 下载Flutter SDK: https://flutter.dev/docs/get-started/install
# 2. 解压到指定目录
# 3. 添加flutter/bin到PATH环境变量
```

2. 配置开发环境
```bash
# 检查环境配置
flutter doctor

# 安装所需依赖
flutter pub get

# 启用平台支持
flutter config --enable-ios
flutter config --enable-android
```

3. IDE配置
- Android Studio
  - 安装Flutter和Dart插件
  - 配置Flutter SDK路径
  - 配置项目级别的Flutter设置

- VS Code
  - 安装Flutter和Dart插件
  - 配置Flutter SDK路径
  - 配置工作区设置

### 1.4 项目配置
1. 克隆项目
```bash
git clone [项目地址]
cd flutter_cleaner
```

2. 安装依赖
```bash
# 安装项目依赖
flutter pub get

# 生成必要的代码文件
flutter pub run build_runner build --delete-conflicting-outputs
```

3. 运行项目
```bash
# 开发环境
flutter run

# 生产环境
flutter run --release
```

### 1.5 基本功能
1. 录音管理
   - 浏览并管理录音文件
   - 支持批量选择和操作
   - 提供音频播放和进度控制
   - 支持按时长和大小过滤

2. 通话录音
   - 浏览并管理通话录音
   - 支持按联系人分类
   - 提供自动清理规则配置
   - 支持存储空间分析

3. 联系人管理
   - 设置联系人分类
   - 配置保护策略
   - 管理黑名单
   - 自动清理规则

4. 系统设置
   - 存储空间管理
   - 自动清理配置
   - 备份还原设置
   - 通知提醒设置

### 1.6 开发指南
1. 代码规范
   - 遵循[Flutter官方代码规范](https://flutter.dev/docs/development/tools/formatting)
   - 使用2空格缩进
   - 最大行长度80字符
   - 使用单引号定义字符串

2. 提交规范
   - 提交前格式化代码：`flutter format .`
   - 运行测试：`flutter test`
   - 提交信息格式：`<type>: <description>`
   - type类型：
     * feat：新功能
     * fix：修复
     * docs：文档
     * style：格式
     * refactor：重构
     * test：测试
     * chore：构建

3. 分支管理
   - main：主分支，用于发布
   - develop：开发分支
   - feature/*：功能分支
   - bugfix/*：修复分支

4. 发布流程
   - 更新版本号
   - 更新更新日志
   - 打包测试
   - 提交发布

### 1.7 常见问题
1. 环境配置问题
   - Flutter SDK未正确配置：运行`flutter doctor`检查
   - 依赖安装失败：删除pubspec.lock后重新运行`flutter pub get`
   - 编译错误：运行`flutter clean`后重新编译

2. 运行问题
   - 模拟器未启动：检查模拟器状态
   - 设备未识别：运行`flutter devices`检查
   - 热重载失败：重启IDE或运行`flutter run`

3. 性能问题
   - 启动慢：检查初始化逻辑
   - 内存泄漏：使用DevTools分析
   - 卡顿：检查UI线程耗时操作

## 二、核心功能
### 2.1 功能概览
1. 管理概览
   - 存储空间统计
     * 总体存储空间使用情况
     * 各类型文件占用空间分析
     * 可清理空间预估
     * 清理建议生成
   - 数据统计分析
     * 录音文件数量及分布
     * 通话记录时长及频次
     * 联系人分类占比
     * 清理效果追踪
   - 快捷操作入口
     * 一键清理
     * 批量管理
     * 智能分类
     * 设置入口

2. 录音管理
   - 文件浏览
     * 列表/网格视图切换
     * 时间轴浏览模式
     * 文件夹组织方式
     * 搜索和过滤
   - 音频控制
     * 播放/暂停/停止
     * 进度控制和预览
     * 音量调节
     * 倍速播放
   - 批量操作
     * 多选模式
     * 批量删除
     * 批量移动
     * 批量分类
   - 智能分类
     * 时长分类
     * 大小分类
     * 重要性标记
     * 自动标签

3. 通话录音
   - 记录管理
     * 按联系人分组
     * 按时间排序
     * 按重要性分类
     * 按通话时长筛选
   - 智能清理
     * 已删除通话关联清理
     * 低频联系人录音清理
     * 超期录音自动清理
     * 大文件智能清理
   - 保护策略
     * 重要联系人保护
     * 最近通话保护
     * 标记录音保护
     * 自定义规则保护

4. 联系人管理
   - 分类管理
     * 安全区：重要联系人，录音永久保存
     * 临时区：普通联系人，定期清理
     * 黑名单：骚扰号码，立即清理
     * 自定义分类：用户自定义规则
   - 自动分类
     * 基于通话频次
     * 基于通话时长
     * 基于时间跨度
     * 基于用户行为
   - 清理规则
     * 分类级别规则
     * 时间维度规则
     * 空间维度规则
     * 组合条件规则

### 2.2 数据模型
1. 基础模型
   - 通用属性
     * 唯一标识符
     * 创建时间
     * 更新时间
     * 删除标记
     * 版本信息
   - 索引设计
     * 主键索引
     * 时间索引
     * 关联索引
     * 状态索引

2. 业务模型
   - 录音记录
     * 基本信息：名称、路径、大小、时长
     * 文件属性：格式、质量、采样率
     * 业务属性：分类、标签、重要性
     * 状态信息：是否删除、是否加密
   - 通话记录
     * 基本信息：号码、时间、时长
     * 关联信息：联系人ID、录音ID
     * 业务属性：类型、方向、标记
     * 状态信息：是否删除、是否保护
   - 联系人信息
     * 基本信息：姓名、号码、备注
     * 分类信息：安全区、临时区、黑名单
     * 统计信息：通话次数、总时长
     * 状态信息：是否删除、是否保护

### 2.3 业务流程
1. 数据同步流程
   - 初始化同步
     * 扫描本地文件系统
     * 读取系统通话记录
     * 导入联系人信息
     * 建立数据索引
   - 增量同步
     * 监听文件变化
     * 监听通话记录
     * 监听联系人变化
     * 实时更新索引
   - 冲突处理
     * 数据一致性检查
     * 冲突策略选择
     * 自动冲突解决
     * 手动冲突处理

2. 清理流程
   - 清理前准备
     * 数据完整性检查
     * 保护规则验证
     * 空间计算预估
     * 用户确认获取
   - 执行清理
     * 按优先级执行
     * 分批次处理
     * 错误自动重试
     * 结果实时反馈
   - 后续处理
     * 更新数据记录
     * 更新存储统计
     * 生成清理报告
     * 优化清理策略

3. 保护机制
   - 数据保护
     * 文件完整性校验
     * 数据备份策略
     * 误删恢复机制
     * 加密保护机制
   - 策略保护
     * 规则优先级管理
     * 多重规则验证
     * 手动确认机制
     * 自动回滚机制

## 三、技术实现
### 3.1 项目架构
1. Clean Architecture + BLoC
   - 表现层（Presentation）
     * Pages：页面UI实现
     * Widgets：可复用组件
     * BLoCs：状态管理
     * 依赖：依赖Domain层
   - 领域层（Domain）
     * Entities：业务实体
     * Repositories：仓库接口
     * UseCases：业务用例
     * 依赖：无外部依赖
   - 数据层（Data）
     * Models：数据模型
     * Repositories：仓库实现
     * DataSources：数据源
     * 依赖：依赖Domain层

2. 状态管理
   - BLoC Pattern
     * Event：用户操作和系统事件
     * State：UI状态和业务状态
     * BLoC：业务逻辑处理
     * Stream：数据流和状态流
   - 状态分类
     * 页面状态：UI相关状态
     * 业务状态：数据和逻辑状态
     * 全局状态：应用级状态
     * 持久状态：需要持久化的状态

3. 依赖管理
   - 依赖注入
     * GetIt：服务定位器
     * Provider：状态管理
     * Riverpod：状态管理增强
   - 包管理
     * pubspec.yaml：依赖声明
     * flutter pub：依赖管理
     * version：版本控制

### 3.2 核心模块
1. 概览模块
   - 导航菜单：概览
   - 标题： 录音空间清理
   - 数据统计展示
   - 快捷操作入口
   - 存储空间分析
   - 清理建议提供
   - 开发测试支持【恢复初始数据状态】

9. 导航与标题
  - 整体APP下面导航栏分为【概览、录音、通话、联系人】
  - 对应不同导航选中时顶端标题栏文字分别为【录音空间清理、录音文件、通话录音、联系人信息】
  - 标题栏（APP或各画面标题和功能菜单）
   - 内容区（主要界面内容）
   - 导航栏（底部导航菜单）

2. 录音模块
   - 导航栏：录音
   - 标题栏： 录音文件
   - 文件列表管理，录音文件浏览(浏览状态)，过滤排序功能，播放器控制
      - 内容区：录音文件列表
      - 列表项：录音文件名、时间、大小、时长和播放按钮
        - 左面分为上下显示文件名、时间，右边先上下显示大小和时长
        - 然后最右边显示播放按钮，播放按钮为黑色圆圈中间三角形播放图标
        - 点击播放按钮的时候在录音项下面显示播放进度条，可以手动拖动进度条控制播放位置
        - 播放进度条下面显示播放时间，播放时间分为上下两行，上面显示当前播放时间，下面显示录音总时长
        - 播放状态时，播放按钮变化为暂停按钮，点击暂停按钮后，停止播放，并切换为播放按钮
        - 播放按钮和暂停按钮的图标变化
        - 播放按钮和暂停按钮的点击事件
      - 功能菜单：
        - 【更多】菜单按钮，点击弹出一级菜单，一级菜单及其下属二级菜单内容如下：
          - 时间： 全部（默认选项）、一年以前、90天以前、最近90天内
          - 时长： 全部（默认选项）、2小时以上、10分钟以上、10分钟以内
          - 排序： 时间降序（默认选项）、时间升序、大小降序、大小升序
        - 每个一级菜单对应的二级菜单，都是单选，使用单选框来表示当前选择状态
        - 二级菜单，点击后，选中当前选项，并更新标题栏对应的过滤条件，刷新当前列表数据
      - 状态切换： 
        - 长按录音记录项，切换到选择状态（录音文件列表），并且缺省当前记录为选中状态
    -  批量操作处理，录音文件选择列表（选择状态）
      - 内容区：录音文件列表
      - 列表项：录音文件名、时间、大小、时长和选择按钮
        - 最右边浏览状态的播放按钮切换显示为选择状态的选择按钮
        - 选择框内显示当前选择状态
        - 用户可以通过滑动多条记录快速控制选择状态
      - 标题栏： 选择状态下标题栏分为两部分
        - 关闭按钮：在最左边，一个【×】图标，点击退出选择状态（系统回退动作时同样操作）
        - 选择数量：在关闭按钮的右边，中间有一定的空间隔，显示总体选择状态【已选择xx项】
      - 功能菜单：
        - 删除：弹出确认对话框，确认后删除当前选择的记录
        - 全选：选中当前列表所有记录，并更新选择数量；选择状态下，点击全选按钮，则取消全选状态
        - 更多：弹出一级菜单，一级菜单及其下属二级菜单内容如下：
          - 分享：点击后，弹出分享对话框，选择分享方式，支持分享到微信、QQ、短信、邮件等（暂不实现）
          - 转文字：点击后，弹出转文字对话框，选择转文字方式，支持语音转文字、图片转文字等（暂不实现）
          - 重命名：点击后，弹出重命名对话框，输入新的文件名，点击确定后，更新文件名（暂不实现）
   - 特别处理：
     - 删除： 文件存在且删除失败，则不删除DB记录，否则都应该把DB记录删除了
     - 测试数据：请根据以上过滤规则，构造对应的测试数据协助测试

3. 通话模块
   - 通话记录管理
   - 录音关联处理
   - 通话统计分析
   - 清理策略执行

4. 联系人模块
   - 联系人管理
   - 分类属性设置
   - 关联数据处理
   - 保护策略执行

### 3.3 关键实现
1. 数据存储
   - Isar数据库
     * Schema定义
     * 索引优化
     * 事务处理
     * 数据迁移
   - 文件系统
     * 路径管理
     * 文件操作
     * 空间管理
     * 缓存策略

2. 音频处理
   - just_audio
     * 播放控制
     * 进度管理
     * 音量控制
     * 状态监听
   - record
     * 录音控制
     * 格式设置
     * 质量控制
     * 错误处理

3. 权限管理
   - permission_handler
     * 存储权限
     * 录音权限
     * 通讯录权限
     * 通知权限
   - 权限策略
     * 权限检查
     * 权限请求
     * 权限说明
     * 降级处理

4. 备份功能设计（暂不实现）
   - 网络检测：使用系统API检测当前网络状态，确保在Wi-Fi环境下进行备份
   - 文件加密：使用AES加密算法对备份文件进行加密，确保数据传输和存储安全
   - 增量备份：通过比较文件的修改时间和大小，仅备份有变化的文件
   - 备份调度：使用WorkManager定期调度备份任务，支持灵活的备份策略
   - 错误处理：在备份过程中捕获异常，记录错误日志，并提供重试机制

2. 性能优化
   - UI性能
     * Widget重建优化
     * 列表性能优化
     * 图片缓存
     * 动画性能
   - 数据性能
     * 数据缓存
     * 批量操作
     * 异步处理
     * 内存管理

3. 错误处理
   - 异常捕获
     * 全局错误处理
     * 业务异常处理
     * UI异常处理
     * 日志记录
   - 恢复机制
     * 自动重试
     * 状态恢复
     * 数据恢复
     * 用户提示

## 四、界面规范
### 4.1 设计语言
1. Material Design 3
   - 主题系统
     * 动态配色：基于壁纸的动态主题
     * 亮暗主题：支持系统主题切换
     * 品牌定制：支持品牌色彩定制
     * 主题一致性：确保全局主题统一
   - 设计原则
     * 直观性：界面元素清晰易懂
     * 一致性：交互模式统一
     * 反馈性：操作有明确反馈
     * 效率性：减少操作步骤

2. 设计规范
   - 布局规范
     * 网格系统：8dp基础网格
     * 间距规则：16.w水平间距，8.h垂直间距
     * 对齐方式：左对齐为主
     * 响应式：支持不同屏幕尺寸
   - 视觉规范
     * 圆角：8.r统一圆角
     * 阴影：elevation 0-8
     * 透明度：87%主文本，60%次要文本
     * 图标：24.w统一尺寸

### 4.2 组件规范
1. 导航组件
   - AppBar
     * 高度：56.h
     * 标题：18.sp，主文本色
     * 操作图标：24.w
     * 居中对齐：centerTitle = true
   - BottomNavigationBar
     * 高度：56.h
     * 图标：24.w
     * 文字：12.sp
     * 选中状态：主题色

2. 列表组件
   - ListTile
     * 高度：56.h
     * 左边距：16.w
     * 右边距：16.w
     * 分割线：1.h，12%黑色
   - Card
     * 内边距：16.w
     * 圆角：8.r
     * 阴影：elevation = 2
     * 边距：8.w

3. 按钮组件
   - ElevatedButton
     * 高度：40.h
     * 内边距：水平16.w，垂直8.h
     * 圆角：8.r
     * 文字：14.sp
   - TextButton
     * 高度：40.h
     * 内边距：水平8.w，垂直4.h
     * 文字：14.sp
     * 无背景色

4. 表单组件
   - TextField
     * 高度：48.h
     * 内边距：水平16.w，垂直12.h
     * 圆角：4.r
     * 边框：1.w
   - Checkbox & Radio
     * 尺寸：24.w
     * 点击区域：48.w
     * 内边距：8.w
     * 动画：200ms

### 4.3 交互规范
1. 手势操作
   - 点击反馈
     * 波纹效果：InkWell
     * 反馈时长：200ms
     * 点击区域：最小48.w
     * 触感反馈：可选
   - 列表操作
     * 左滑：删除操作
     * 右滑：次要操作
     * 长按：选择模式
     * 拖动：排序功能

2. 状态反馈
   - 加载状态
     * 进度指示器：CircularProgressIndicator
     * 骨架屏：Shimmer效果
     * 加载文本：居中显示
     * 取消选项：必要时提供
   - 结果反馈
     * Snackbar：操作结果
     * Dialog：重要操作确认
     * Toast：轻量级提示
     * Banner：持续性通知

### 4.4 动画规范
1. 页面转场
   - 基础动画
     * 时长：300ms
     * 曲线：标准曲线
     * 方向：从右到左
     * 渐变效果：可选
   - 共享元素
     * 时长：400ms
     * 曲线：减速曲线
     * 缩放效果：可选
     * 渐变过渡：必选

2. 组件动画
   - 状态变化
     * 时长：200ms
     * 曲线：标准曲线
     * 属性：透明度、大小、位置
     * 连续性：确保平滑
   - 列表动画
     * 时长：150ms
     * 曲线：标准曲线
     * 交错效果：可选
     * 方向：从下到上

### 4.5 无障碍设计
1. 基础要求
   - 颜色对比度：≥4.5:1
   - 点击区域：≥48.w
   - 文字大小：≥14.sp
   - 焦点顺序：合理可预期

2. 辅助功能
   - 语音辅助
     * 内容描述：完整且准确
     * 操作提示：清晰明确
     * 状态反馈：及时有效
     * 标签设置：语义化
   - 缩放支持
     * 文字缩放：支持系统设置
     * 界面适配：响应式布局
     * 内容重排：避免截断
     * 最小尺寸：保证可用性

## 五、开发规范
### 5.1 代码规范
1. 命名规范
   - 类名：PascalCase
     * Widget类：以Widget结尾
     * 页面类：以Page结尾
     * BLoC类：以Bloc结尾
     * 状态类：以State结尾
     * 事件类：以Event结尾
   - 方法名：camelCase
     * 事件处理：on开头
     * 异步方法：async结尾
     * 私有方法：_开头
   - 变量名：camelCase
     * 私有变量：_开头
     * 常量：k开头
     * 集合类型：复数形式
   - 文件名：snake_case.dart
     * 页面文件：*_page.dart
     * 部件文件：*_widget.dart
     * BLoC文件：*_bloc.dart
     * 模型文件：*_model.dart

2. 代码风格
   - 缩进：2空格
   - 行长度：80字符
   - 大括号：同行
   - 导入顺序：
     * dart:core
     * dart:*
     * package:flutter/*
     * package:*
     * 相对路径导入
   - 注释规范
     ```dart
     /// 类注释示例
     /// {@template class_name}
     /// 类的功能描述
     /// 
     /// 作者：blackharry
     /// 创建日期：2024-02-03
     /// 更新日期：2024-02-03
     /// {@endtemplate}
     class ClassName {}

     /// 方法注释示例
     /// {@template method_name}
     /// 方法的功能描述
     /// 
     /// 参数说明：
     /// * [param1] - 参数1的说明
     /// * [param2] - 参数2的说明
     /// 
     /// 返回值说明：返回值的说明
     /// 
     /// 异常说明：可能抛出的异常说明
     /// {@endtemplate}
     void methodName(String param1, int param2) {}
     ```

3. 代码组织
   - 文件结构
     * lib/
       - app/：应用级配置
       - core/：核心工具
       - data/：数据层
       - domain/：领域层
       - presentation/：表现层
   - 依赖管理
     * pubspec.yaml规范
     * 版本号管理
     * 依赖分类
     * 版本约束

### 5.2 资源规范
1. 资源命名
   - 图片资源
     * ic_*：图标
     * bg_*：背景
     * img_*：图片
     * logo_*：标志
   - 颜色资源
     * primary_*：主色
     * secondary_*：次色
     * neutral_*：中性色
     * error_*：错误色
   - 文本资源
     * title_*：标题
     * msg_*：消息
     * hint_*：提示
     * error_*：错误

2. 资源组织
   - assets/
     * images/：图片资源
     * icons/：图标资源
     * fonts/：字体资源
     * json/：JSON文件
   - lib/core/
     * theme/：主题定义
     * l10n/：国际化
     * constants/：常量
     * utils/：工具类

### 5.3 测试规范
1. 单元测试
   - 测试文件命名：*_test.dart
   - 测试组织结构
     * 按功能分组
     * 使用describe和it
     * 清晰的测试描述
   - 测试覆盖率要求
     * 业务逻辑：≥90%
     * 数据模型：≥95%
     * UI组件：≥85%

2. Widget测试
   - 测试范围
     * 基础组件
     * 页面布局
     * 交互行为
     * 状态管理
   - 测试方法
     * pumpWidget
     * pumpAndSettle
     * find.byType
     * expect验证

3. 集成测试
   - 测试场景
     * 完整流程
     * 跨页面交互
     * 数据持久化
     * 网络请求
   - 测试工具
     * integration_test
     * flutter_driver
     * mockito
     * bloc_test

### 5.4 性能规范
1. UI性能
   - 避免重建
     * const构造函数
     * ValueNotifier
     * RepaintBoundary
   - 列表优化
     * ListView.builder
     * 缓存机制
     * 懒加载
   - 图片处理
     * 适当分辨率
     * 缓存策略
     * 预加载

2. 内存管理
   - 资源释放
     * dispose方法
     * 取消订阅
     * 清理缓存
   - 内存泄漏
     * 避免循环引用
     * 弱引用使用
     * 定期检测

3. 启动优化
   - 冷启动
     * 延迟初始化
     * 预加载关键数据
     * 并行初始化
   - 热重载
     * 状态保持
     * 快速恢复
     * 增量更新

### 5.5 日志规范
1. 日志级别
   - verbose：详细信息
   - debug：调试信息
   - info：重要信息
   - warning：警告信息
   - error：错误信息

2. 日志格式
   ```dart
   /// 日志格式示例
   logger.i('【方法名称】操作描述 - 参数：$params，结果：$result');
   logger.e('【方法名称】错误描述', error, stackTrace);
   ```

3. 日志内容
   - 时间戳
   - 方法名称
   - 操作描述
   - 参数信息
   - 结果信息
   - 错误堆栈

4. 日志管理
   - 本地存储
   - 定期清理
   - 上传策略
   - 隐私保护

## 六、项目协作
### 6.1 版本控制
1. 分支管理
   - 主分支：main
     * 用于发布稳定版本
     * 只接受合并请求
     * 每次合并都有版本标签
     * 需要通过CI/CD验证
   - 开发分支：develop
     * 日常开发工作分支
     * 功能开发的基础分支
     * 包含最新的开发代码
     * 定期合并到main分支
   - 功能分支：feature/*
     * 基于develop分支创建
     * 命名规范：feature/功能名称
     * 完成后合并回develop
     * 合并前进行代码审查
   - 修复分支：bugfix/*
     * 用于修复develop分支的bug
     * 命名规范：bugfix/问题描述
     * 修复后合并回develop
     * 需要包含测试用例

2. 提交规范
   - 提交信息格式
     * 类型：feat/fix/docs/style/refactor/test/chore
     * 范围：可选，表示影响范围
     * 描述：简明扼要的变更说明
     * 示例：feat(auth): 添加用户认证功能
   - 提交要求
     * 每次提交只做一件事
     * 提交前进行代码格式化
     * 确保通过所有测试
     * 更新相关文档

### 6.2 代码审查
1. 审查重点
   - 代码质量
     * 遵循Flutter代码规范
     * 使用Flutter最佳实践
     * 性能和内存优化
     * 代码可维护性
   - 业务逻辑
     * 功能完整性
     * 业务规则正确性
     * 边界条件处理
     * 错误处理机制
   - 测试覆盖
     * 单元测试覆盖
     * Widget测试覆盖
     * 集成测试覆盖
     * 测试用例质量

2. 审查流程
   - 提交前自查
     * 代码格式化：flutter format .
     * 静态分析：flutter analyze
     * 运行测试：flutter test
     * 本地验证功能
   - 团队审查
     * 创建Pull Request
     * 指定审查人员
     * 说明变更内容
     * 关联相关问题
   - 问题修复
     * 及时响应反馈
     * 修复发现的问题
     * 补充必要的测试
     * 更新相关文档
   - 合并确认
     * 确保CI/CD通过
     * 所有评审意见已处理
     * 获得审查人批准
     * 可以安全合并

### 6.3 文档维护
1. 文档范围
   - 技术文档
     * 架构设计文档
     * API接口文档
     * 数据模型文档
     * 测试文档
   - 开发文档
     * 环境配置指南
     * 开发规范文档
     * 工作流程文档
     * 常见问题解答
   - 用户文档
     * 用户使用手册
     * 功能说明文档
     * 常见问题解答
     * 版本更新说明

2. 更新规则
   - 及时性
     * 代码变更同步更新
     * 接口变更即时更新
     * 功能变更及时记录
     * 问题解决后更新FAQ
   - 完整性
     * 文档结构完整
     * 内容描述准确
     * 示例代码可运行
     * 配图清晰规范
   - 可维护性
     * 统一文档格式
     * 版本号对应
     * 分类存储管理
     * 定期审查更新

3. README维护
   - 目录README
     * 每个目录都有README.md
     * 说明目录用途
     * 列举主要文件
     * 描述实现细节
   - 自动维护
     * 代码变更触发更新
     * AI辅助生成文档
     * 自动检查完整性
     * 定期同步更新
   - 内容要求
     * 功能说明完整
     * 设计原则清晰
     * 开发规范明确
     * 示例代码规范

### 6.4 持续集成
1. CI/CD配置
   - 构建流程
     * 代码检出
     * 依赖安装
     * 代码分析
     * 运行测试
   - 部署流程
     * 环境配置
     * 打包构建
     * 签名验证
     * 发布部署
   - 质量控制
     * 代码质量检查
     * 测试覆盖率检查
     * 性能指标检查
     * 安全漏洞扫描

2. 自动化测试
   - 测试类型
     * 单元测试
     * Widget测试
     * 集成测试
     * 性能测试
   - 测试要求
     * 测试覆盖率达标
     * 测试用例完整
     * 测试报告规范
     * 性能指标达标

### 6.5 发布管理
1. 发布流程
   - 版本规划
     * 功能特性确认
     * 时间节点安排
     * 资源分配计划
     * 风险评估管理
   - 测试验证
     * 功能测试
     * 性能测试
     * 兼容性测试
     * 安全性测试
   - 发布准备
     * 版本号更新
     * 更新日志编写
     * 文档更新
     * 资源打包
   - 发布操作
     * 代码合并
     * 打包构建
     * 签名验证
     * 应用发布

2. 版本管理
   - 版本号规则
     * 主版本号：重大更新
     * 次版本号：功能更新
     * 修订号：问题修复
     * 构建号：编译标识
   - 更新说明
     * 功能更新说明
     * 问题修复列表
     * 兼容性说明
     * 升级建议

## 七、运维支持
### 7.1 日志系统
1. 日志配置
   - 日志工具
     * logger包配置
     * 日志级别设置
     * 日志格式定义
     * 日志输出控制
   - 存储策略
     * 本地存储路径
     * 日志分片规则
     * 清理策略
     * 上传机制

2. 日志规范
   - 日志级别
     * verbose：详细调试信息
     * debug：开发调试信息
     * info：关键流程信息
     * warning：潜在问题警告
     * error：错误和异常信息
   - 日志内容
     * 时间戳：精确到毫秒
     * 上下文：类名和方法名
     * 操作描述：中文描述
     * 关键参数：脱敏处理
     * 结果信息：状态和数据
   - 使用场景
     * 方法进入：@logMethodEnter
     * 方法退出：@logMethodExit
     * 错误记录：@logError
     * 性能监控：@logPerformance

### 7.2 错误处理
1. 异常管理
   - 异常分类
     * 业务异常：业务规则验证失败
     * 系统异常：系统资源访问失败
     * 网络异常：网络请求失败
     * 权限异常：权限不足或缺失
   - 处理策略
     * 异常捕获：try-catch处理
     * 异常转换：统一异常格式
     * 异常恢复：自动重试机制
     * 异常上报：错误信息收集

2. 错误恢复
   - 自动恢复
     * 网络重连：自动重试连接
     * 数据恢复：本地缓存恢复
     * 状态重置：重置异常状态
     * 会话恢复：重新建立会话
   - 手动恢复
     * 用户提示：友好错误提示
     * 操作建议：解决方案建议
     * 人工反馈：问题反馈渠道
     * 降级服务：降级功能提供

### 7.3 性能监控
1. 监控指标
   - 应用性能
     * 启动时间：冷启动和热启动
     * 页面加载：页面渲染时间
     * 响应时间：操作响应延迟
     * 帧率监控：UI渲染性能
   - 资源使用
     * CPU使用率：处理器占用
     * 内存使用：内存分配和回收
     * 存储空间：磁盘空间使用
     * 电池消耗：电量使用情况

2. 优化策略
   - 启动优化
     * 延迟初始化：非必要组件延迟
     * 并行加载：并行初始化任务
     * 预加载：关键数据预加载
     * 懒加载：按需加载资源
   - 运行优化
     * 内存优化：及时释放资源
     * 渲染优化：减少重建和重绘
     * 后台优化：限制后台任务
     * 网络优化：请求合并和缓存

### 7.4 安全防护
1. 数据安全
   - 存储安全
     * 数据加密：AES加密算法
     * 密钥管理：安全密钥存储
     * 访问控制：权限级别控制
     * 数据备份：定期数据备份
   - 传输安全
     * HTTPS协议：安全传输层
     * 证书验证：SSL证书验证
     * 数据压缩：传输数据压缩
     * 断点续传：大文件传输

2. 应用安全
   - 代码安全
     * 代码混淆：ProGuard配置
     * 签名验证：应用签名校验
     * 调试保护：防止调试攻击
     * 注入防护：防止代码注入
   - 运行安全
     * 越狱检测：设备安全检查
     * 完整性：应用完整性校验
     * 敏感信息：信息脱敏处理
     * 安全更新：定期安全更新

### 7.5 备份恢复
1. 备份机制
   - 备份内容
     * 用户数据：录音文件数据
     * 配置信息：应用配置数据
     * 使用记录：操作历史记录
     * 个性化设置：用户偏好设置
   - 备份策略
     * 定时备份：自动定时备份
     * 触发备份：关键操作备份
     * 增量备份：差异数据备份
     * 手动备份：用户手动备份

2. 恢复机制
   - 恢复方式
     * 自动恢复：程序异常恢复
     * 手动恢复：用户选择恢复
     * 选择恢复：部分数据恢复
     * 回滚恢复：版本回滚恢复
   - 恢复策略
     * 数据验证：完整性校验
     * 冲突处理：数据冲突解决
     * 优先级：恢复优先级
     * 失败处理：恢复失败处理

## 八、附录
### 8.1 常见问题
1. 环境配置
   - Flutter环境配置
     * Flutter SDK安装和配置
     * Dart SDK版本要求
     * IDE插件安装
     * 环境变量设置
   - 运行环境要求
     * iOS：12.0+
     * Android：API 24+
     * 存储空间：2GB+
     * 内存要求：4GB+
   - 常见错误解决
     * pub get失败：检查网络和依赖配置
     * 编译错误：检查SDK版本兼容性
     * 运行崩溃：查看日志和权限配置
     * 热重载失败：检查IDE配置
   - 性能优化建议
     * 启用Flutter编译优化
     * 使用release模式运行
     * 优化Widget树结构
     * 使用DevTools分析性能

2. 功能使用
   - 基本功能说明
     * 录音文件管理：浏览和操作录音
     * 批量操作：长按进入选择模式
     * 音频控制：播放和进度调节
     * 联系人分类：设置保护策略
   - 高级功能指南
     * 自动清理规则配置
     * 存储空间分析和优化
     * 数据备份和恢复
     * 自定义清理策略
   - 使用技巧
     * 快速搜索和过滤
     * 标签管理和分类
     * 定期数据备份
     * 空间优化建议
   - 注意事项
     * 权限授予说明
     * 版本更新提示
     * 数据安全建议
     * 清理操作警告

3. 开发问题
   - 代码相关
     * BLoC状态管理
     * Clean Architecture实践
     * 依赖注入使用
     * 异步操作处理
   - 测试相关
     * 单元测试编写
     * Widget测试实现
     * 集成测试配置
     * 测试覆盖率要求
   - 性能相关
     * UI渲染优化
     * 状态管理优化
     * 内存使用优化
     * 启动时间优化
   - 发布相关
     * iOS发布流程
     * Android发布流程
     * 版本号管理
     * 更新说明编写

4. 其他问题
   - 技术支持
     * 问题反馈渠道
     * 文档查询方式
     * 社区交流平台
     * 更新通知订阅
   - 版本升级
     * 更新检查方式
     * 升级注意事项
     * 数据迁移说明
     * 兼容性处理
   - 数据安全
     * 备份策略建议
     * 加密方案说明
     * 隐私保护措施
     * 数据恢复方法
   - 特殊场景
     * 低内存处理
     * 大文件处理
     * 断网处理
     * 崩溃恢复

### 8.2 最佳实践
1. 架构实践
   - Clean Architecture
     * 层级划分：表现层、领域层、数据层
     * 依赖规则：内层不依赖外层
     * 接口定义：在领域层定义接口
     * 实现分离：在数据层实现接口
   - BLoC模式
     * 状态管理：单一数据流
     * 事件处理：统一事件处理
     * 依赖注入：使用GetIt
     * 状态持久化：Hydrated BLoC
   - 代码组织
     * 模块化：按功能模块划分
     * 分层结构：遵循架构分层
     * 职责分离：单一职责原则
     * 依赖管理：显式依赖声明

2. 开发实践
   - 编码规范
     * 命名规则：遵循Flutter规范
     * 代码格式：使用dartfmt
     * 注释规范：使用文档注释
     * 错误处理：统一异常处理
   - 性能优化
     * 构建优化：减少重建
     * 渲染优化：使用RepaintBoundary
     * 内存优化：及时释放资源
     * 启动优化：延迟初始化
   - 测试实践
     * 单元测试：业务逻辑测试
     * Widget测试：UI组件测试
     * 集成测试：功能流程测试
     * 性能测试：性能指标测试
   - 版本控制
     * 分支管理：Git Flow工作流
     * 提交规范：约定式提交
     * 版本号：语义化版本
     * 变更记录：自动生成

3. UI实践
   - Material Design 3
     * 主题系统：动态主题
     * 组件使用：标准组件
     * 响应式：自适应布局
     * 无障碍：支持辅助功能
   - 交互设计
     * 手势处理：统一手势
     * 动画效果：流畅过渡
     * 状态反馈：及时响应
     * 错误提示：友好提示
   - 自定义组件
     * 组件封装：可复用组件
     * 状态管理：局部状态
     * 生命周期：资源管理
     * 性能优化：按需构建
   - 主题定制
     * 颜色系统：品牌色彩
     * 字体定制：统一字体
     * 组件样式：一致风格
     * 暗黑模式：自动适配

4. 数据实践
   - 本地存储
     * Isar数据库：高性能存储
     * 缓存策略：多级缓存
     * 数据同步：增量同步
     * 数据迁移：版本升级
   - 状态管理
     * BLoC模式：状态隔离
     * 状态共享：依赖注入
     * 状态持久化：自动保存
     * 状态恢复：错误恢复
   - 错误处理
     * 异常捕获：全局处理
     * 错误恢复：自动重试
     * 日志记录：分级记录
     * 错误上报：远程收集
   - 性能优化
     * 批量操作：减少IO
     * 异步处理：不阻塞UI
     * 数据预加载：提前加载
     * 缓存优化：合理缓存

### 8.3 更新日志
1. 版本 1.0.0（2024-02-03）
   - 初始版本发布
     * 基础功能实现
     * 核心模块开发
     * 界面规范制定
     * 开发规范确立
   - 主要功能
     * 录音文件管理
     * 通话录音管理
     * 联系人管理
     * 存储空间分析
   - 技术特性
     * Clean Architecture架构
     * BLoC状态管理
     * Material Design 3
     * Flutter跨平台支持
   - 已知问题
     * 暂不支持备份功能
     * 暂不支持分享功能
     * 暂不支持语音转文字
     * 暂不支持自定义主题

2. 版本规划
   - 1.1.0（计划中）
     * 备份还原功能
     * 数据同步功能
     * 性能优化改进
     * Bug修复
   - 1.2.0（计划中）
     * 分享功能
     * 语音转文字
     * 自定义主题
     * 多语言支持
   - 2.0.0（计划中）
     * 云存储支持
     * 智能分类
     * 深度学习集成
     * 社交功能

### 8.4 参考资料
1. 官方文档
   - Flutter文档
     * Flutter开发指南
     * Widget目录
     * 开发者工具
     * 性能优化
   - Material Design
     * 设计规范
     * 组件库
     * 主题系统
     * 图标资源
   - Dart文档
     * 语言特性
     * 库参考
     * 编码规范
     * 最佳实践

2. 技术资源
   - 状态管理
     * flutter_bloc文档
     * bloc_test指南
     * Provider使用
     * GetIt配置
   - 数据存储
     * Isar数据库
     * SharedPreferences
     * 文件系统
     * 缓存策略
   - 音频处理
     * just_audio使用
     * record配置
     * audio_session
     * 音频格式
   - 测试相关
     * 单元测试
     * Widget测试
     * 集成测试
     * 性能测试

3. 开发工具
   - IDE工具
     * Android Studio
     * VS Code
     * Flutter插件
     * Dart插件
   - 调试工具
     * DevTools
     * Flutter Inspector
     * Performance工具
     * 内存分析器
   - 辅助工具
     * Flutter命令行
     * pub命令
     * Git工具
     * 代码生成器

4. 社区资源
   - 技术社区
     * Flutter中文社区
     * Stack Overflow
     * GitHub
     * Medium
   - 学习资源
     * 官方教程
     * 视频教程
     * 示例代码
     * 技术博客
   - 常用插件
     * pub.dev
     * Flutter Favorite
     * 流行插件
     * 精选包集

### 8.5 提示词示例参考
- 黄金提示词： 请学会【## 九、Cursor+AI相关】中相关命令和管理自动化的内容。并请开启【履历管理】和【TODO管理】的自动化动作。
- 补充履历记录： 请整理本次compser回话上下文内容追加到当天的履历记录中。
- 更新Rules： 请根据当前文件内容更新.cursorrules文件。（根据需要对具体内容在补充转化）
- 整体文档AI评审和辅助提示词： 请整体Review当前文件内容，并提出优化和改进意见；请一步一步提出具体的修改建议，我确认之后再一步一步修改。
- 代码生成辅助提示词： 请根据用户需求，生成对应的代码，并给出详细的代码说明和使用方法。
- 代码优化辅助提示词： 请根据用户需求，优化和改进代码，并给出详细的代码说明和使用方法。
- 代码评审辅助提示词： 请根据用户需求，评审代码，并给出详细的代码说明和使用方法。

## 九、Cursor+AI相关
### 9.1 Doc配置
1. Flutter中文开发文档： https://docs.flutter.cn/
2. Material Design指南： https://m3.material.io

### 9.2 Yolo模式下Composer的用法
1. 交互原则
   - 简洁，不要过多解释问题，快速修改代码为主要目的
   - Composer的上下文要永远选择[README.md]
   - 生成Android代码的时候，永远参照知识库【docs.flutter.cn】使用最新的代码实现方法
   - 生成UI代码的时候，永远参照知识库【m3.material.io和developer.android.com】使用最新的规范和配置方法
   - 
2. 常用命令类提示词
   - 提交：自动提交所有修改的代码并推送到GIT
   - 编译：自动执行`flutter run`
   - 清空编译：自动执行`flutter clean && flutter pub get && flutter run`
   - 运行：自动执行`flutter run`
   - 文档：自动校验和更新所有目录下的README文档，没有的自动生成
   - 注释：自动补全代码注释，并每更新10个文件自动提交一次GIT
   - 检查：自动检查代码中存在的问题，整理问题并提交给用户进行确认，根据反馈执行修复：
     * 检查时间：用户发起检查的时间，格式为yyyyMMdd-HHmmss
     * 检查：
       * 开始检查前，先生成检查记录文件，文件名：[./qreports/check-<检查时间>.md]
       * 在文件中记录如下内容，如果文件不存在，自动创建，追加内容到当前文件：
         * 问题序号： 序号（从1开始，自动增加）
         * 问题记录时间： 当前时间
         * 文件路径： 检查的文件路径，当前项目相对路径
         * 版本号： 检查的文件GIT版本号
         * 行号： 问题发生的行号
         * 问题摘要
         * 问题类型
         * 问题严重程度
         * 问题详细描述
         * 问题建议
       * 请使用Markdown分级标题方式记录内容，不要使用表格记录，每条记录之间使用空行隔开
       * 检查过程中，每次整理超过10个问题，马上停止检查，等待用户一个一个确认
       * 用户确认并修改后，提交GIT，然后继续检查
     * 报告：
       * 待检查问题结束后，自动生成问题报告文件，文件名：[./qreports/report-<检查时间>.md]，如果文件不存在，自动创建，追加内容到当前文件
       * 报告内容：
         * 检查时间： 检查时间
         * 报告时间： 当前时间
         * 问题序号范围
         * 关联文件
         * 问题数量
         * 问题分类数量
           * 问题分类
           * 统计数量
           * 问题摘要
         * 问题严重程度分类及统计数量
         * 简要报告
         * 待办事项
       * 检查记录文件和问题报告文件，需要自动追加到GIT中
       * 请使用Markdown分级标题方式记录内容，不要使用表格记录，每条记录之间使用空行隔开
     * 检查的范围：
       * 项目所有下级目录内容（源码、配置文件、资源文件）
     * 检查的要点内容：
       * 命名规范
       * 代码规范
       * 日志规范
       * 注释规范及完善
       * 潜在缺陷
       * 性能隐患
       * 安全问题
     * 涉及重大变更的问题，记录到检查和报告记录中，并提示用户另行处理
     * 自动Apply并更新文件，不需要用户确认，并同步提交到GIT
   - 履历搜索：
     * 根据用户输入，搜索关联度最高的前10条记录，分别显示：序号、日志文件名、履历时间、履历摘要
     * 并提示用户选择要查看的履历，用户选择后，自动显示履历文件内容并定位且高亮显示对应行
   - TODO搜索：
     * 根据用户输入，直接打开TODO.md文件，定位到标注为未完成的第一条TODO事项，并高亮显示
   - TODO完成：
     * 标记TODO为完成，并根据用户输入更新TODO的备注（时间、状态更新、用户输入内容）
     * 自动Apply并更新文件，不需要用户确认，并同步提交到GIT

3. 代码生成范围限定原则
   - 功能追加：不允许直接追加任何新的功能；如果有好的想法，请向用户提出建议和需求想法，然后根据用户反馈进行代码生成
   - 功能变更，在保证既有功能的前提下，允许对现有功能进行：
     * 修复
     * 健壮性强化
     * 日志补充
     * 注释完善
     * 代码重构
  
4. 功能变更流程
   - 新功能必须由用户发起
   - 或在获得用户确认后才能追加
   - 特别注意：已完成功能不得擅自改变设计初衷，避免后续需要重新Rework或删除
   - 修改主动查找关联修正，要尽量一次修改完整，不要遗漏
   - 代码变更后，必须对应Package或目录下，更新README.md文件（根目录除外），以固化当前代码实现的设计

5. 变更关联修正
   - 每次新增或更新资源配置要检查相关资源引用是否存在，不存在的自动创建，避免多次编译交互
   - 每次变更或删除资源配置后，要分析关联配置和代码中是否有遗留废弃的引用，自动删除，避免多次编译交互

6. 履历管理
   - 在目录[./history]下记录同用户的所有交互记录，包括用户的输入以及输出内容
   - 履历按照天来记录，文件名：[./history/history-<日期>.md]，如果文件不存在，自动创建，当天内容自动追加到当天文件中
   - 请使用Markdown分级标题方式记录内容，不要使用表格记录，每条记录之间使用空行隔开
   - 履历记录内容：
     * 序号（从1开始，自动增加）
     * 请求时间
     * 请求耗时
     * 请求内容： 用户输入的原始内容
     * 请求结果： COMPOSER输出的原始内容
   - 自动Apply并更新文件，不需要用户确认，并同步提交到GIT

7. TODO管理
   - 在根目录下记录TODO清单，文件名：[./TODO.md]，如果文件不存在，自动创建
   - 每次同用户交互过程中，用户对暂不处理的问题，请自动记录到TODO清单中，内容自动追加到当前文件中
   - 请使用Markdown分级标题方式记录内容，不要使用表格记录，每条记录之间使用空行隔开
   - TODO记录内容：
     * 序号（从1开始，自动增加）
     * 标题
     * 记录时间
     * 状态（未完成、进行中、已完成）
     * 摘要
     * 详细描述（如果可以请包含文件路径、版本号、行号，以及必要的上下文等详细信息）
     * 备注
   - 自动Apply并更新文件，不需要用户确认，并同步提交到GIT

## 更新日志

### 版本 1.0.1
- 修复了录音文件管理中的一个小错误。
- 优化了通话录音的存储性能。

### 版本 1.0.0
- 初始版本发布，包含录音文件和通话录音的基本管理功能。

## 测试规范

### 测试架构
1. 测试类型
   - 单元测试 (test/unit)
   - 组件测试 (test/widget)
   - 集成测试 (integration_test)

2. 测试框架
   - flutter_test
   - mockito
   - bloc_test
   - integration_test

### 测试要求
1. 基本要求
   - 测试文件命名：*_test.dart
   - 测试覆盖率：>80%
   - 测试必须独立且可重复
   - 持续集成必须包含自动化测试

2. 代码规范
   - 遵循项目代码规范
   - 保持测试代码整洁
   - 使用有意义的测试数据
   - 添加必要的测试注释

### 测试流程
1. 开发流程
   - 编写测试用例
   - 运行自动化测试
   - 生成测试报告
   - 持续集成验证

2. 维护流程
   - 定期更新测试用例
   - 删除过时的测试
   - 优化低效的测试
   - 补充缺失的测试

## 发布管理

### 版本规范
- 版本号：主版本号.次版本号.修订号
- 分支管理：main、develop、feature、release
- 代码审查：提交前必须通过审查
- 测试要求：所有测试用例必须通过

### 发布流程
- 代码准备：完成开发、测试、审查
- 版本更新：更新版本号、更新日志
- 打包发布：执行打包、签名、验证
- 应用发布：上传商店、灰度发布

## 性能优化

### UI性能
1. 渲染优化
   - 使用const构造函数
   - 避免不必要的重建
   - 合理使用StatefulWidget
   - 优化build方法

2. 列表优化
   - 使用ListView.builder
   - 实现数据分页
   - 图片懒加载
   - 合理使用缓存

### 内存管理
1. 资源释放
   - 及时释放不用的资源
   - 正确关闭Stream
   - 取消不需要的订阅
   - 清理临时文件

2. 内存监控
   - 使用DevTools分析
   - 监控内存使用
   - 处理内存泄漏
   - 优化大对象使用

### 启动优化
1. 启动时间
   - 延迟初始化
   - 异步加载资源
   - 优化初始化逻辑
   - 减少启动依赖

2. 体验优化
   - 添加启动页面
   - 优化首屏加载
   - 显示加载进度
   - 平滑过渡动画

## 错误处理

### 异常处理
- 业务异常：参数错误、规则违反、权限不足
- 系统异常：网络错误、存储错误、设备错误
- 统一处理：try-catch、错误恢复、日志记录
- 用户提示：友好提示、操作建议、解决方案

### 日志管理
- 日志级别：DEBUG、INFO、WARN、ERROR
- 日志内容：类型、信息、堆栈、上下文
- 日志存储：本地存储、远程上报、定期清理
- 日志分析：错误统计、问题分析、优化建议

## 编译规范

### 编译命令
1. 基本命令
   - 常规编译：flutter run
   - 清理编译：flutter clean && flutter pub get && flutter run
   - 发布编译：flutter run --release

2. 自动化编译
   - 代码修改后自动编译
   - 配置变更后自动编译
   - 资源更新后自动编译
   - 依赖更新后自动编译

### 错误处理
1. 自动修复
   - 导入语句自动添加
   - 缺失方法自动实现
   - 类型转换自动处理
   - 资源引用自动修复
   - 依赖冲突自动解决
   - 平台兼容性修复

2. 修复原则
   - 保持代码风格一致
   - 避免引入新问题
   - 添加必要日志
   - 确保代码健壮性
   - 遵循Flutter规范
   - 保持跨平台兼容

### 质量保证
1. 基本要求
   - 编译通过
   - 功能正确
   - 规范符合
   - 测试通过
   - 性能达标
   - 静态分析通过

2. 用户确认
   - 重要修改需确认
   - 核心功能需确认
   - 性能影响需确认
   - 重大变更需确认


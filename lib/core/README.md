# 核心工具目录

## 目录结构
- `utils/`: 通用工具类
- `error/`: 错误处理相关
- `theme/`: 主题相关配置
- `constants/`: 常量定义
- `extensions/`: 扩展方法
- `widgets/`: 共用组件

## 功能说明
1. 工具类（utils）
   - 日志工具：统一的日志记录实现
   - 文件工具：文件操作相关方法
   - 时间工具：日期时间处理方法
   - 格式工具：数据格式化方法

2. 错误处理（error）
   - 异常定义：自定义异常类
   - 错误码：统一错误码定义
   - 错误处理：全局错误处理逻辑
   - 错误提示：用户友好的错误提示

3. 主题配置（theme）
   - 主题定义：应用主题配置
   - 颜色系统：品牌色彩定义
   - 文字样式：统一字体风格
   - 组件主题：常用组件样式

4. 共用组件（widgets）
   - 基础组件：常用UI组件
   - 业务组件：可复用的业务组件
   - 布局组件：通用布局模板
   - 动画组件：可复用的动画效果

## 使用规范
1. 工具类使用
   - 优先使用现有工具类
   - 新增方法需要添加单元测试
   - 保持方法的单一职责
   - 添加完整的文档注释

2. 错误处理
   - 使用预定义的错误类型
   - 统一使用错误码机制
   - 错误信息必须国际化
   - 保持错误提示友好性

3. 主题使用
   - 禁止硬编码颜色值
   - 使用预定义的文字样式
   - 遵循主题定制规范
   - 支持深色模式适配

4. 组件开发
   - 组件必须可配置
   - 添加使用示例
   - 编写组件测试
   - 注意性能优化 
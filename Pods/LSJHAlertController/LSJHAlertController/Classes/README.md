# LLAlertController  弹出框组件
## 功能

- 实现弹出框效果，默认提供两种弹出框效果alert和alertSheet，弹出视图也可以自定义，弹出方式有屏幕居中和屏幕下方位置,内置多种动画

---

## 属性

属性 | 说明 | 类型 | 默认值
---|---|---|---
backgroundButton|外部可以设置背景颜色，透明程度，和是否可以相应事件（默认可以响应，如果不需要响应请关闭button的enabled属性）| UIButton|-
alertStyle|弹出视图类型|LLAlertStyle|LLAlertStyleDefalut
presentStyle|present 转场风格|LLPopupPresentStyle|LLPopupPresentStyleSystem
dismissStyle|dismiss 转场风格|LLPopupDismissStyle|LLPopupDismissStyleFadeOut

### LLAlertStyle 定义弹出框样式

枚举值 | 说明
---|---
LLAlertStyleDefalut| 默认样式（默认居中）
LLAlertStyleSheet | 底部弹出（默认居下)
LLAlertStyleCustomAlert | 自定义视图（默认居中）
LLAlertStyleCustomSheet | 自定义视图（默认居下）


### LLAlertLayoutStyle（该样式只有在LLAlertStyleDefalut模式下有效，用来管理按钮的排列方向）

枚举值 | 说明
---|---
LLAlertLayoutStyleHorizontal | 水平方向
LLAlertLayoutStyleVertical | 垂直方向


### LLPopupPresentStyle （调整控制器进场状态）

枚举值 | 说明
---|---
LLPopupPresentStyleSystem | 系统样式
LLPopupPresentStyleFadeIn | 渐入
LLPopupPresentStyleBounce | 弹出
LLPopupPresentStyleExpandHorizontal | 水平展开
LLPopupPresentStyleExpandVertical | 垂直展开
LLPopupPresentStyleSlideDown | 从上往下划入
LLPopupPresentStyleSlideUp | 从下往上划入
LLPopupPresentStyleSlideLeft | 从右往左划入
LLPopupPresentStyleSlideRight | 从左往右划入

### LLPopupDismissStyle （调整控制器出场状态）

枚举值 | 说明
---|---
LLPopupDismissStyleFadeOut | 渐出
LLPopupDismissStyleContractHorizontal | 水平收起
LLPopupDismissStyleContractVertical | 垂直收起
LLPopupDismissStyleSlideDown | 向下划出
LLPopupDismissStyleSlideUp | 向上划出
LLPopupDismissStyleSlideLeft | 向左划出
LLPopupDismissStyleSlideRight | 向右划出

## 方法

- 创建Alert弹窗

```objective-c
/**
 默认转场初始化方法

 @param title 标题
 @param message 消息
 @return alert控制器
 */
+ (_Nonnull instancetype)ll_alertWithTitle:(NSString * _Nullable)title
                                    Message:(NSString * _Nullable)message
                           AlertLayoutStyle:(LLAlertLayoutStyle)layoutStyle;
```

- 创建AlertSheet弹窗

```objective-c
/**
 alertSheetView初始化方法

 @param title 标题
 @param message 消息
 @return alert控制器
 */
+ (_Nonnull instancetype)ll_alertSheetWithTitle:(NSString * _Nullable)title
                                         Message:(NSString * _Nullable)message;
```

- 创建自定义视图弹窗

```objective-c
/**
 自定义弹出视图（视图需确定Size大小，事件，按钮需自行添加）

 @param view 自定义视图
 @return alert控制器
 */
+ (_Nonnull instancetype)ll_alertWithCustomView:(UIView *)view
                                      AlertStyle:(LLAlertStyle)alertStyle;
```

- 为弹窗添加按钮点击事件

```objective-c
/**
 添加 action
 
 @param action action
 */
- (void)ll_addAction:(LLAlertAction * _Nonnull)action;

/**
 *    直接添加一个数组的 action
 *
 *    @param actions 放有 action 的数组
 */
- (void)ll_addActions:(NSArray<LLAlertAction *> * _Nonnull)actions;
```

- 为弹窗添加输入框只有在LLAlertStyleDefalut下有效

```objective-c
/**
 添加输入框

 @param textField 输入框
 */
- (void)ll_addTextField:(UITextField *)textField;
```

## 基础用法

* 导入头文件

```objective-c
#import <LSJHAlertController/LSJHAlertController.h>
```

* 初始化弹窗控制器
    
```objective-c
LLAlertController *alert = [LLAlertController ll_alertWithTitle:@"Welcome"
                                                                       Message:@"欢迎使用 Ant Design ！！"
                                                              AlertLayoutStyle:LLAlertLayoutStyleVertical];
alert.backgroundButton.enabled = NO;
            // 创建 action
LLAlertAction *defaultAction = [LLAlertAction ll_actionWithTitle:@"知道了" style:LLAlertActionStyleDefault handler:^{ NSLog(@"Default"); }];
[alert ll_addAction:defaultAction];
[self presentViewController:alert animated:YES completion:nil];
```
```objective-c
LLAlertController * alert = [LLAlertController ll_alertSheetWithTitle:@"" Message:@""];
LLAlertAction *defaultAction = [LLAlertAction ll_actionWithTitle:@"选项一(警示项)" style:LLAlertActionStyleDestructive handler:^{ NSLog(@"Default"); }];
LLAlertAction *cancelAction = [LLAlertAction ll_actionWithTitle:@"选项二" style:LLAlertActionStyleDefault handler:^{ NSLog(@"Cancel"); }];
LLAlertAction *defaultAction1 = [LLAlertAction ll_actionWithTitle:@"选项三" style:LLAlertActionStyleDefault handler:^{ NSLog(@"Default"); }];
[alert ll_addAction:defaultAction];
[alert ll_addAction:cancelAction];
[alert ll_addAction:defaultAction1];
[self presentViewController:alert animated:YES completion:nil];
```
```objective-c
UIView * view = [[UIView alloc] init];
view.backgroundColor = [UIColor redColor];
view.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
LLAlertController * alert = [LLAlertController ll_alertWithCustomView:view AlertStyle:LLAlertStyleCustomAlert];
[self presentViewController:alert animated:YES completion:nil];
```


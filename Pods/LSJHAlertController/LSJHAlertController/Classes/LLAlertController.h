
#import "LLAlertAction.h"

#import <UIKit/UIKit.h>
#import "LLAlertStyle.h"
// 灰色背景透明度
static const CGFloat as_backgroundAlpha = 0.4;

@interface LLAlertController : UIViewController

/// alert 视图（外部不要调用）
@property (nonatomic, strong) UIView * _Nonnull alertView;
/// 外部可以设置背景颜色，透明程度，和是否可以相应事件（默认可以响应，如果不需要响应请关闭button的enabled属性）
@property (nonatomic, strong) UIButton * _Nonnull backgroundButton;
/// present 转场风格
@property (nonatomic, assign) LLPopupPresentStyle presentStyle;
/// dismiss 转场风格
@property (nonatomic, assign) LLPopupDismissStyle dismissStyle;
/// 弹出视图类型
@property (nonatomic, assign) LLAlertStyle alertStyle;

/**
 默认转场初始化方法

 @param title 标题
 @param message 消息
 @return alert控制器
 */
+ (_Nonnull instancetype)ll_alertWithTitle:(NSString * _Nullable)title
                                    Message:(NSString * _Nullable)message
                           AlertLayoutStyle:(LLAlertLayoutStyle)layoutStyle;

/**
 alertSheetView初始化方法

 @param title 标题
 @param message 消息
 @return alert控制器
 */
+ (_Nonnull instancetype)ll_alertSheetWithTitle:(NSString * _Nullable)title
                                         Message:(NSString * _Nullable)message
                          AlertSheetCornerRadius:(CGFloat)cornerRadius;

/**
 自定义弹出视图（视图需确定Size大小，事件，按钮需自行添加）

 @param view 自定义视图
 @return alert控制器
 */
+ (_Nonnull instancetype)ll_alertWithCustomView:(UIView * _Nonnull)view
                                      AlertStyle:(LLAlertStyle)alertStyle;

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

/**
 添加输入框

 @param textField 输入框
 */
- (void)ll_addTextField:(UITextField * _Nonnull)textField;

@end

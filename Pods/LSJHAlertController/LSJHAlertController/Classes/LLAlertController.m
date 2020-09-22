
#import "LLAlertController.h"
#import "LLAlertSheetView.h"
#import "LLAlertView.h"
#import "LLPopupDismissAnimator.h"
#import "LLPopupPresentAnimator.h"

@interface LLAlertController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, assign) CGFloat sheetCornerR;
@end

@implementation LLAlertController
#pragma mark - LifeCircle
- (instancetype)init
{
    if (self = [super init]) {
        self.transitioningDelegate  = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)dealloc
{
    //    [self.alertView removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backgroundButton];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.alertView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    [self.backgroundButton mas_remakeConstraints:^(MASConstraintMaker * make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker * make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(LLBottomHeight);
    }];

    if (self.alertStyle == LLAlertStyleSheet || self.alertStyle == LLAlertStyleCustomSheet) {
        // 设置 alertView 在屏幕底部
        [self.alertView mas_remakeConstraints:^(MASConstraintMaker * make) {
            make.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-LLBottomHeight);
            if ([self.alertView isMemberOfClass:[LLAlertSheetView class]]) {
                make.height.mas_equalTo(((LLAlertSheetView *)self.alertView).height);
            } else {
                make.height.mas_equalTo(self.alertView.cmam_height);
            }

        }];
        if (self.sheetCornerR) {
            if ([self.alertView isMemberOfClass:[LLAlertSheetView class]]) {
                LLAlertSheetView * alertSheet = (LLAlertSheetView *)self.alertView;
                [alertSheet ll_addCornerRadiusWithNumber:self.sheetCornerR];
            }
        }
    } else {
        self.bottomView.hidden = YES;
        [self.alertView mas_remakeConstraints:^(MASConstraintMaker * make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.centerY.mas_equalTo(self.view.mas_centerY);
            if ([self.alertView isMemberOfClass:[LLAlertView class]]) {
                make.size.mas_equalTo(CGSizeMake(((LLAlertView *)self.alertView).width,
                                                 ((LLAlertView *)self.alertView).height));
            } else {
                make.size.mas_equalTo(
                CGSizeMake(self.alertView.cmam_width, self.alertView.cmam_height));
            }

        }];
    }
}

#pragma mark - Public Method
/** 默认转场初始化 */
+ (_Nonnull instancetype)ll_alertWithTitle:(NSString * _Nullable)title
                                    Message:(NSString * _Nullable)message
                           AlertLayoutStyle:(LLAlertLayoutStyle)layoutStyle
{
    LLAlertController * alertController                      = [[LLAlertController alloc] init];
    alertController.alertStyle                                = LLAlertStyleDefalut;
    alertController.alertView                                 = [[LLAlertView alloc] initWithTitle:title message:message];
    ((LLAlertView *)(alertController.alertView)).controller  = alertController;
    ((LLAlertView *)(alertController.alertView)).layoutStyle = layoutStyle;
    alertController.presentStyle                              = LLPopupPresentStyleSystem;
    alertController.dismissStyle                              = LLPopupDismissStyleFadeOut;
    return alertController;
}

+ (_Nonnull instancetype)ll_alertSheetWithTitle:(NSString * _Nullable)title
                                         Message:(NSString * _Nullable)message
                          AlertSheetCornerRadius:(CGFloat)cornerRadius
{
    LLAlertController * alertController = [[LLAlertController alloc] init];
    alertController.alertStyle           = LLAlertStyleSheet;
    alertController.alertView            = [[LLAlertSheetView alloc] initWithTitle:title message:message];
    LLAlertSheetView * alertSheet       = (LLAlertSheetView *)alertController.alertView;
    alertController.sheetCornerR         = cornerRadius;
    alertSheet.controller                = alertController;
    alertController.presentStyle         = LLPopupPresentStyleSlideUp;
    alertController.dismissStyle         = LLPopupDismissStyleSlideDown;
    return alertController;
}

+ (_Nonnull instancetype)ll_alertWithCustomView:(UIView *)view
                                      AlertStyle:(LLAlertStyle)alertStyle
{
    LLAlertController * alertController = [[LLAlertController alloc] init];
    alertController.alertStyle           = alertStyle;
    alertController.alertView            = view;

    if (alertStyle == LLAlertStyleCustomAlert) {
        alertController.presentStyle = LLPopupPresentStyleSystem;
        alertController.dismissStyle = LLPopupDismissStyleFadeOut;
    } else if (alertStyle == LLAlertStyleCustomSheet) {
        alertController.presentStyle = LLPopupPresentStyleSlideUp;
        alertController.dismissStyle = LLPopupDismissStyleSlideDown;
    }
    return alertController;
}

- (void)ll_addAction:(LLAlertAction * _Nonnull)action
{
    if ([self.alertView isMemberOfClass:[LLAlertView class]]) {
        [(LLAlertView *)self.alertView ll_addAction:action];
    } else if ([self.alertView isMemberOfClass:[LLAlertSheetView class]]) {
        [(LLAlertSheetView *)self.alertView ll_addAction:action];
    }
}

- (void)ll_addActions:(NSArray<LLAlertAction *> * _Nonnull)actions
{
    for (LLAlertAction * action in actions) {
        [self ll_addAction:action];
    }
}

- (void)ll_addTextField:(UITextField *)textField
{
    if ([self.alertView isMemberOfClass:[LLAlertView class]]) {
        [(LLAlertView *)self.alertView ll_addTextField:textField];
    }
}

#pragma mark - Private Method
- (void)dismissBackgroundView:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForPresentedController:(UIViewController *)presented
                     presentingController:(UIViewController *)presenting
                         sourceController:(UIViewController *)source
{
    LLPopupPresentAnimator * animator = [[LLPopupPresentAnimator alloc] init];
    animator.presentStyle              = self.presentStyle;
    return animator;
}

/** 返回Dismiss动画 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:
(UIViewController *)dismissed
{
    LLPopupDismissAnimator * animator = [[LLPopupDismissAnimator alloc] init];
    animator.dismissStyle              = self.dismissStyle;
    return animator;
}

#pragma mark - Setter
- (void)setPresentStyle:(LLPopupPresentStyle)presentStyle
{
    _presentStyle = presentStyle;
}

- (void)setDismissStyle:(LLPopupDismissStyle)dismissStyle
{
    _dismissStyle = dismissStyle;
}

#pragma mark - Getter
- (UIButton *)backgroundButton
{
    if (!_backgroundButton) {
        _backgroundButton = ({
            UIButton * object      = [UIButton buttonWithType:UIButtonTypeCustom];
            object.backgroundColor = [UIColor blackColor];
            object.alpha           = as_backgroundAlpha;
            [object addTarget:self action:@selector(dismissBackgroundView:) forControlEvents:UIControlEventTouchUpInside];
            object;
        });
    }
    return _backgroundButton;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = ({
            UIView * object        = [[UIView alloc] init];
            object.backgroundColor = [UIColor whiteColor];
            object;
        });
    }
    return _bottomView;
}
@end

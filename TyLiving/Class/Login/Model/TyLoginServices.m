//
//  TyLoginServices.m
//  TyLiving
//
//  Created by 李世航 on 2020/9/15.
//  Copyright © 2020 李世航. All rights reserved.
//

#import "TyLoginServices.h"

@interface TyLoginServices ()

@end

@implementation TyLoginServices
+ (TyLoginServices *)instance {
    static TyLoginServices * service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[TyLoginServices alloc] init];
    });
    return service;
}

#pragma mark - Public Method
- (void)releaseData{
    self.model = nil;
}

#pragma mark - Private Method
/// 一键登录
/// @param control control的obj参数应该为数组类型：[传入的控制器对象，TXCustomModel对象]
- (void)fastLogin:(UIControl *)control{
    [[TXCommonHandler sharedInstance] accelerateLoginPageWithTimeout:0.0 complete:^(NSDictionary * _Nonnull resultDic) {
        if ([PNSCodeSuccess isEqualToString:[resultDic objectForKey:@"re sultCode"]] == NO)     {
            // 取号，加速授权⻚弹起失败
            return ;
        }
        // 弹起一键登录页面
        [[TXCommonHandler sharedInstance] getLoginTokenWithTimeout:0.0 controller:control.obj[0] model:control.obj[1] complete:^(NSDictionary * _Nonnull resultDic) {
            NSString *code = [resultDic objectForKey:@"resultCode"];
            if ([PNSCodeLoginControllerPresentSuccess isEqualToString:code]) {
                // 弹起授权⻚成功
            } else if ([PNSCodeLoginControllerClickCancel isEqualToString:code]) {
                // 点击了授权⻚的返回
            } else if ([PNSCodeLoginControllerClickChangeBtn isEqualToString:code]) {
                // 点击切换其他登录⽅式按钮
            } else if ([PNSCodeLoginControllerClickLoginBtn isEqualToString:code]) {
                if ([[resultDic objectForKey:@"isChecked"] boolValue] == YES) {
                    // 点击了登录按钮，check box选 中，SDK内部接着    会去获取登陆Token
                } else {
                    // 点击了登录按钮，check box选 中，SDK内部不会    去获取登陆Token
                }
            } else if ([PNSCodeLoginControllerClickCheckBoxBtn isEqualToString:code]) {
                // 点击check box
            } else if ([PNSCodeLoginControllerClickProtocol isEqualToString:code]) {
                // 点击了协议富⽂本
            } else if ([PNSCodeSuccess isEqualToString:code]) {
                //点击登录按钮获取登录Token成功回调
                NSString *token = [resultDic objectForKey:@"token"];
                //下⾯拿Token去服务器换⼿机号
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:YES complete:nil];
                });

            } else {

            }
        }];
    }];
}

- (void)wxLogin{
    [ShareSDK authorize:SSDKPlatformTypeWechat
               settings:nil
         onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {

    }];
}

- (void)appleLogin{
    [ShareSDK authorize:SSDKPlatformTypeAppleAccount
               settings:nil
         onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {

    }];
}

#pragma mark - Getter
- (SEL)selector{
    switch (self.type) {
        case LoginTypeOne: return NSSelectorFromString(@"fastLogin:");
        case LoginTypeWX: return NSSelectorFromString(@"wxLogin");
        case LoginTypeApple: return NSSelectorFromString(@"appleLogin");
        default:
            return nil;;
    }
}

- (TXCustomModel *)model{
    if (!_model){
        _model = [[TXCustomModel alloc] init];
        _model.navColor = UIColor.orangeColor;
        _model.navTitle = [[NSAttributedString alloc] initWithString:@"一键登录（全屏）" attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor,NSFontAttributeName : [UIFont systemFontOfSize:20.0]}];
                    //model.navIsHidden = NO;
        _model.navBackImage = [UIImage imageNamed:@"icon_nav_back_light"];
                    //model.hideNavBackItem = NO;
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                    [rightBtn setTitle:@"更多" forState:UIControlStateNormal];
        _model.navMoreView = rightBtn;
        _model.privacyNavColor = UIColor.orangeColor;
        _model.privacyNavBackImage = [UIImage imageNamed:@"icon_nav_back_light"];
        _model.privacyNavTitleFont = [UIFont systemFontOfSize:20.0];
        _model.privacyNavTitleColor = UIColor.whiteColor;
        _model.logoImage = [UIImage imageNamed:@"taobao"];
                    //model.logoIsHidden = NO;
                    //model.sloganIsHidden = NO;
        _model.sloganText = [[NSAttributedString alloc] initWithString:@"一键登录slogan文案" attributes:@{NSForegroundColorAttributeName : UIColor.orangeColor,NSFontAttributeName : [UIFont systemFontOfSize:16.0]}];
        _model.numberColor = UIColor.orangeColor;
        _model.numberFont = [UIFont systemFontOfSize:30.0];
        _model.loginBtnText = [[NSAttributedString alloc] initWithString:@"一键登录" attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor,NSFontAttributeName : [UIFont systemFontOfSize:20.0]}];
                    //model.autoHideLoginLoading = NO;
                    //model.privacyOne = @[@"《隐私1》",@"https://www.taobao.com/"];
                    //model.privacyTwo = @[@"《隐私2》",@"https://www.taobao.com/"];
        _model.privacyColors = @[UIColor.lightGrayColor, UIColor.orangeColor];
        _model.privacyAlignment = NSTextAlignmentCenter;
        _model.privacyFont = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        _model.privacyOperatorPreText = @"《";
        _model.privacyOperatorSufText = @"》";
                    //model.checkBoxIsHidden = NO;
        _model.checkBoxWH = 17.0;
        _model.changeBtnTitle = [[NSAttributedString alloc] initWithString:@"切换到其他方式" attributes:@{NSForegroundColorAttributeName : UIColor.orangeColor,NSFontAttributeName : [UIFont systemFontOfSize:18.0]}];
                    //model.changeBtnIsHidden = NO;
                    //model.prefersStatusBarHidden = NO;
        _model.preferredStatusBarStyle = UIStatusBarStyleLightContent;
                    //model.presentDirection = PNSPresentationDirectionBottom;

                    //授权页默认控件布局调整
                    //model.navBackButtonFrameBlock =
                    //model.navTitleFrameBlock =
        _model.navMoreViewFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
                        CGFloat width = superViewSize.height;
                        CGFloat height = width;
                        return CGRectMake(superViewSize.width - 15 - width, 0, width, height);
        };
        _model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        //                if ([self isHorizontal:screenSize]) {
        //                    frame.origin.y = 20;
        //                    return frame;
        //                }
                        return frame;
        };
        _model.sloganFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        //                if ([self isHorizontal:screenSize]) {
        //                    return CGRectZero; //横屏时模拟隐藏该控件
        //                } else {
                            return CGRectMake(0, 140, superViewSize.width, frame.size.height);
        //                }
        };
        _model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        //                if ([self isHorizontal:screenSize]) {
        //                    frame.origin.y = 140;
        //                }
                        return frame;
        };
        _model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        //                if ([self isHorizontal:screenSize]) {
        //                    frame.origin.y = 185;
        //                }
                        return frame;
        };
        _model.changeBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        //                if ([self isHorizontal:screenSize]) {
        //                    return CGRectZero; //横屏时模拟隐藏该控件
        //                } else {
                            return CGRectMake(10, frame.origin.y, superViewSize.width - 20, 30);
        //                }
        };
                    //model.privacyFrameBlock =

                    //添加自定义控件并对自定义控件进行布局
        __block UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:@"这是一个自定义控件" forState:UIControlStateNormal];
        [customBtn setBackgroundColor:UIColor.redColor];
        customBtn.frame = CGRectMake(0, 0, 230, 40);
        _model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
                         [superCustomView addSubview:customBtn];
        };
        _model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
                        CGRect frame = customBtn.frame;
                        frame.origin.x = (contentViewFrame.size.width - frame.size.width) * 0.5;
                        frame.origin.y = CGRectGetMinY(privacyFrame) - frame.size.height - 20;
                        frame.size.width = contentViewFrame.size.width - frame.origin.x * 2;
                        customBtn.frame = frame;
        };
                // 横竖屏切换
        _model.supportedInterfaceOrientations = UIInterfaceOrientationMaskAllButUpsideDown;
                // 仅支持竖屏
        _model.supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
                // 仅支持横屏
        _model.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscape;
    }
    return _model;
}
@end

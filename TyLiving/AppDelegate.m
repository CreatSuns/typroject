//
//  AppDelegate.m
//  TyLiving
//
//  Created by 李世航 on 2020/9/9.
//  Copyright © 2020 李世航. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark - 通用链接
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler API_AVAILABLE(ios(8.0)){
    return  [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [self setRootVC];
    [self configPlatformSetting];

    return YES;
}

- (void)setRootVC{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];

    LoginViewController * login = [[LoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
//    [self.window setRootViewController:nav];
//    RootViewController * login = [[RootViewController alloc] init];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
}

- (void)configPlatformSetting{

    /// 阿里一键登录环境配置初始化
    NSString * authSDKInfo = [[NSUserDefaults standardUserDefaults] objectForKey:ALIFASTLOGINKEY];
    if (!authSDKInfo || authSDKInfo.length == 0) {
        authSDKInfo = ALIFASTLOGIN;
    }
    [[TXCommonHandler sharedInstance] setAuthSDKInfo:authSDKInfo complete:^(NSDictionary * _Nonnull resultDic) {
        NSLog(@"阿里一键登录认证结果：%@", resultDic);

    }];

    // 检测当前环境是否支持一键登录或者号码验证
    [[TXCommonHandler sharedInstance] checkEnvAvailableWithAuthType:PNSAuthTypeLoginToken complete:^(NSDictionary * _Nullable resultDic) {

    }];


    /// MobSDK环境配置
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        [platformsRegister setupWeChatWithAppId:@"" appSecret:@"" universalLink:@""];
    }];

    /// bugly环境配置
//    [Bugly startWithAppId:@"67ff88802d"];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

@end

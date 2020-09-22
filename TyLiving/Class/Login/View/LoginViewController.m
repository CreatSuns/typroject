//
//  LoginViewController.m
//  TyLiving
//
//  Created by 李世航 on 2020/9/9.
//  Copyright © 2020 李世航. All rights reserved.
//

#import "LoginViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "TyLoginServices.h"
#import "TyBottomLineTextField.h"
#import "TyCountDownButton.h"

@interface LoginViewController ()<ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
@property (nonatomic, strong) UIImageView * tyBgImageView;
@property (nonatomic, strong) UIImageView * tyIcon;
@property (nonatomic, strong) TyBottomLineTextField * accountTF;
@property (nonatomic, strong) TyBottomLineTextField * pwdTF;
@property (nonatomic, strong) UIButton * loginBtn;
@property (nonatomic, strong) UIView * thridView;
@property (nonatomic, strong) UIButton * wxButton;
@property (nonatomic, strong) YYLabel * infoLabel;
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    TyLoginServices * service = [TyLoginServices instance];
    [self setupUI];
}

- (void)setupUI{
    [self.view addSubview:self.tyBgImageView];
    [self.view addSubview:self.tyIcon];
    [self.view addSubview:self.accountTF];
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.loginBtn];



    [self.tyBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
    }];

    [self.tyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tyBgImageView);
        make.bottom.mas_equalTo(self.tyBgImageView).with.offset(25.5);
        make.size.mas_equalTo(CGSizeMake(60.5, 55.5));
    }];

    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(49);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-59.5);
        make.top.mas_equalTo(self.tyIcon.mas_bottom).with.offset(60);
        make.height.mas_equalTo(44);
    }];

    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.accountTF);
        make.top.mas_equalTo(self.accountTF.mas_bottom).with.offset(44);
        make.height.mas_equalTo(44);
    }];

    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.pwdTF);
        make.top.mas_equalTo(self.pwdTF.mas_bottom);
        make.height.mas_equalTo(20);
    }];

    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.pwdTF);
        make.top.mas_equalTo(self.infoLabel.mas_bottom).with.offset(73);
        make.size.mas_equalTo(CGSizeMake(197.5, 36));
    }];

//    if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat]) {


        [self.view addSubview:self.thridView];
        [self.thridView addSubview:self.wxButton];

        [self.thridView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.view);
            make.height.mas_equalTo(TYBottomHeight + 200);
        }];

        CGFloat left = (self.view.cmam_width - 44 * 2) / 3;
        [self.wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.thridView);
            make.left.mas_equalTo(self.thridView.mas_left).with.offset(left);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];

        if (@available(iOS 13.0, *)) {
            ASAuthorizationAppleIDButton * appleButton = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeSignIn style:ASAuthorizationAppleIDButtonStyleBlack];
            TyLoginServices * service = [[TyLoginServices alloc] init];
            service.type = LoginTypeApple;
            [appleButton addTarget:service action:service.selector forControlEvents:UIControlEventTouchUpInside];
            [self.thridView addSubview:appleButton];
            appleButton.cornerRadius = 22;
//            appleButton.layer.masksToBounds = YES;
            [appleButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.wxButton);
                make.right.mas_equalTo(self.view.mas_right).with.offset(-left);
                make.size.mas_equalTo(CGSizeMake(44, 44));
            }];
        } else {
            // Fallback on earlier versions
        }

//    }



}


- (void)didAppleIDBtnClicked{
//    self.signInApple = [[SignInApple alloc] init];
//    [self.signInApple handleAuthorizationAppleIDButtonPress];
    if (@available(iOS 13.0, *)) {
           // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
           ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
           // 创建新的AppleID 授权请求
           ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
           // 在用户授权期间请求的联系信息
           appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
           // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
           ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
           // 设置授权控制器通知授权请求的成功与失败的代理
           authorizationController.delegate = self;
           // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
           authorizationController.presentationContextProvider = self;
           // 在控制器初始化期间启动授权流
           [authorizationController performRequests];
       }else{
           // 处理不支持系统版本
           NSLog(@"该系统版本不可用Apple登录");
       }
}

- (void)loginClick{

}

- (void)wxClick{
    TyLoginServices * service = [TyLoginServices instance];
    service.type = LoginTypeWX;
}

- (void)appleClick{
    TyLoginServices * service = [TyLoginServices instance];

}

#pragma mark - delegate
//@optional 授权成功地回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
    NSLog(@"授权完成:::%@", authorization.credential);
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"controller------%@", controller);
    NSLog(@"authorization------%@", authorization);

    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // 用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        NSString *user = appleIDCredential.user;
        // 使用过授权的，可能获取不到以下三个参数
        NSString *familyName = appleIDCredential.fullName.familyName;
        NSString *givenName = appleIDCredential.fullName.givenName;
        NSString *email = appleIDCredential.email;

        NSData *identityToken = appleIDCredential.identityToken;
        NSData *authorizationCode = appleIDCredential.authorizationCode;

        // 服务器验证需要使用的参数
        NSString *identityTokenStr = [[NSString alloc] initWithData:identityToken encoding:NSUTF8StringEncoding];
        NSString *authorizationCodeStr = [[NSString alloc] initWithData:authorizationCode encoding:NSUTF8StringEncoding];
        NSLog(@"identityTokenStr----------%@", identityTokenStr );
        NSLog(@"nauthorizationCodeStr-----%@",authorizationCodeStr);
        NSLog(@"user-----%@",user);

        // Create an account in your system.
        // For the purpose of this demo app, store the userIdentifier in the keychain.
        //  需要使用钥匙串的方式保存用户的唯一信息
//        [YostarKeychain save:KEYCHAIN_IDENTIFIER(@"userIdentifier") data:user];

    }else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        // 这个获取的是iCloud记录的账号密码，需要输入框支持iOS 12 记录账号密码的新特性，如果不支持，可以忽略
        // Sign in using an existing iCloud Keychain credential.
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *passwordCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString *password = passwordCredential.password;

    }else{
        NSLog(@"授权信息均不符");

    }
}

// 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    // Handle error.
    NSLog(@"Handle error：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;

        default:
            break;
    }

    NSLog(@"%@", errorMsg);
}

// 告诉代理应该在哪个window 展示内容给用户
- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)){
    NSLog(@"88888888888");
    // 返回window
    return self.view.window;
}

#pragma mark - lazy

- (UIImageView *)tyBgImageView{
    if (!_tyBgImageView) {
        _tyBgImageView = [[UIImageView alloc]init];
        _tyBgImageView.image = [UIImage imageNamed:@"login_bg"];
        _tyBgImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _tyBgImageView;
}

- (UIImageView *)tyIcon{
    if (!_tyIcon) {
        _tyIcon = [[UIImageView alloc]init];
        _tyIcon.backgroundColor = [UIColor whiteColor];
        _tyIcon.image = [UIImage imageNamed:@"logo"];
        _tyIcon.layer.cornerRadius = 10;
        _tyIcon.layer.masksToBounds = YES;
        _tyIcon.contentMode = UIViewContentModeCenter;
    }
    return _tyIcon;
}

- (TyBottomLineTextField *)accountTF{
    if (!_accountTF) {
        _accountTF = [[TyBottomLineTextField alloc]init];
        _accountTF.keyboardType = UIKeyboardTypeNumberPad;
        _accountTF.returnKeyType = UIReturnKeyDone;
        _accountTF.placeholder = @"手机号";
        [_accountTF setPlaceholderColor:[UIColor ll_hex:@"#595959"]];
    }
    return _accountTF;
}

- (TyBottomLineTextField *)pwdTF{
    if (!_pwdTF) {
        _pwdTF = [[TyBottomLineTextField alloc]init];
        _pwdTF.keyboardType = UIKeyboardTypeNumberPad;
        _pwdTF.returnKeyType = UIReturnKeyDone;
        if (@available(iOS 12.0, *)) {
            // Xcode 10 适配
            _pwdTF.textContentType = UITextContentTypeOneTimeCode;
            // 非Xcode 10 适配
//            _pwdTF.textContentType = @"one-time-code";
        }

        _pwdTF.placeholder = @"验证码";
        [_pwdTF setPlaceholderColor:[UIColor ll_hex:@"#585858"]];
        UIView * view = [[UIView alloc] init];
        view.bounds = CGRectMake(0, 0, 60, 44);

        TyCountDownButton * countDownButton = [TyCountDownButton buttonWithType:UIButtonTypeCustom];
        countDownButton.timeInterval = 1;
        countDownButton.maxInteger = 60;
        countDownButton.minInteger = 0;
        countDownButton.frame = CGRectMake(0, 15, 60, 16);
        [countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [countDownButton setTitleColor:[UIColor ll_hex:@"#FFFFFF"] forState:UIControlStateNormal];
        [countDownButton setBackgroundImage:[UIImage ll_createImageWithColor:[UIColor themeColor]] forState:UIControlStateNormal];
        countDownButton.titleLabel.font = FONT(9);
        countDownButton.layer.cornerRadius = 8;
        countDownButton.layer.masksToBounds = YES;
        [countDownButton addCallBackAction:^(UIButton * _Nonnull button) {
            NSLog(@"111");
            button.enabled = NO;
            [(TyCountDownButton *)button startCountdown];
        }];
        [view addSubview:countDownButton];
        _pwdTF.rightView = view;
        _pwdTF.rightViewMode = UITextFieldViewModeAlways;
    }
    return _pwdTF;
}

- (YYLabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = ({
            YYLabel * object = [[YYLabel alloc] init];
            NSString * highlightString = @"用户服务条款、隐私条款";
            NSString * string = [NSString stringWithFormat:@"登录即同意%@", highlightString];
            NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:string];
            NSRange range            = [string rangeOfString:string options:NSCaseInsensitiveSearch];
            NSRange commentsRange            = [string rangeOfString:highlightString options:NSCaseInsensitiveSearch];

            [text yy_setFont:FONT(9) range:range];
            [text yy_setColor:[UIColor ll_hex:@"#989898"] range:range];
            [text yy_setFont:FONT(9) range:commentsRange];
            [text yy_setColor:[UIColor themeColor] range:commentsRange];
            text.yy_lineSpacing = 2 * SizeAdapter;
            text.yy_kern        = [NSNumber numberWithInt:1 * SizeAdapter];

            YYTextHighlight * textHighlight = [YYTextHighlight new];
            [textHighlight setColor:[UIColor themeColor]];
            [textHighlight setTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {

            }];
            [text yy_setTextHighlight:textHighlight range:commentsRange];
            object.attributedText = text;
            object.numberOfLines = 0;
            object.lineBreakMode = NSLineBreakByCharWrapping;
            object;
        });
    }
    return _infoLabel;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor ll_hex:@"FFFFFF"] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = FONT(15);
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_normal"] forState:UIControlStateNormal];
        TyLoginServices * service = [[TyLoginServices alloc] init];
        service.type = LoginTypeOne;
        [_loginBtn addTarget:service action:service.selector forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIView *)thridView{
    if (!_thridView) {
        _thridView = [[UIView alloc] init];
    }
    return _thridView;
}

- (UIButton *)wxButton{
    if (!_wxButton) {
        _wxButton = [[UIButton alloc]init];
        [_wxButton setBackgroundImage:[UIImage imageNamed:@"wx_icon"] forState:UIControlStateNormal];
        TyLoginServices * service = [[TyLoginServices alloc] init];
        service.type = LoginTypeWX;
        [_wxButton addTarget:service action:service.selector forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxButton;
}

@end

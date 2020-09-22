//
//  WYABottomLineTextField.h
//  WYA_OC_OA
//
//  Created by 1 on 2018/11/19.
//  Copyright © 2018年 weiyian. All rights reserved.
//

#define WYAOATFLineColor [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8]

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TextEditingBlock)(void);

//typedef NS_ENUM(NSUInteger, TextUIContentStyle) {
//    DarkContentStyle,  //默认样式
//    LightContentStyle, //白色清除按钮
//};

@interface TyBottomLineTextField : UITextField <UITextFieldDelegate>

/// 文本发生改变时回调
@property (nonatomic, copy) TextEditingBlock editingBlock;
/// 手机号码类型
@property (nonatomic, assign) BOOL isPhoneNumber;
/// 如果输入的是344格式的电话号码，返回原手机号
@property (nonatomic, copy) NSString * phoneNumberText;
/// 内部控件主体色，目前主要针对清除按钮
//@property (nonatomic, assign) TextUIContentStyle style;

/**
 设置占位文字的颜色

 @param color 色值
 */
- (void)setPlaceholderColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

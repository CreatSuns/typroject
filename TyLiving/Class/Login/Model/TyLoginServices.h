//
//  TyLoginServices.h
//  TyLiving
//
//  Created by 李世航 on 2020/9/15.
//  Copyright © 2020 李世航. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LoginType) {
    LoginTypeOne,   // 一键登录
    LoginTypeWX,    // 微信登录
    LoginTypeApple, // 苹果登录
};

@interface TyLoginServices : NSObject

@property (nonatomic, assign) LoginType type;

@property (nonatomic, assign) SEL selector;

/// 一键登录时model需要在主线程中调用，并传入方法中
@property (nonatomic, strong, nullable) TXCustomModel * model;
+ (TyLoginServices *)instance;

/// 释放资源
- (void)releaseData;
@end

NS_ASSUME_NONNULL_END

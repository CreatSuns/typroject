//
//  TyCountDownButton.h
//  TyLiving
//
//  Created by 李世航 on 2020/9/10.
//  Copyright © 2020 李世航. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TyCountDownButton : UIButton

@property (nonatomic, assign) NSUInteger timeInterval;
@property (nonatomic, assign) NSInteger maxInteger;
@property (nonatomic, assign) NSInteger minInteger;

- (void)startCountdown;
- (void)stopCountdown;
@end

NS_ASSUME_NONNULL_END

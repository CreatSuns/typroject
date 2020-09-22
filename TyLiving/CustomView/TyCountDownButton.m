//
//  TyCountDownButton.m
//  TyLiving
//
//  Created by 李世航 on 2020/9/10.
//  Copyright © 2020 李世航. All rights reserved.
//

#import "TyCountDownButton.h"

@interface TyCountDownButton ()
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSInteger currentInteger;
@property (nonatomic, assign) NSTimeInterval didEnterBackgroundTimestamp;
@end

@implementation TyCountDownButton

- (void)startCountdown {

    _currentInteger = _maxInteger;
    [self setTitle:[NSString stringWithFormat:@"%@s", @(MAX(_currentInteger, _minInteger)).stringValue] forState:UIControlStateDisabled];

    if (!_timer) {
        __weak typeof(self) weakSelf = self;
        if (@available(iOS 10.0, *)) {
            _timer = [NSTimer timerWithTimeInterval:_timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
                [weakSelf setButtonInfo];
            }];
        } else {
            // Fallback on earlier versions
            _timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(setButtonInfo) userInfo:nil repeats:YES];
        }
    }

    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)stopCountdown {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];

    [self setEnabled:YES];

    [_timer invalidate];
    _timer = nil;
}

- (void)setButtonInfo{
    [self setTitle:[NSString stringWithFormat:@"%@s", @(MAX(--self.currentInteger, self.minInteger)).stringValue] forState:UIControlStateDisabled];
    if (self.currentInteger <= self.minInteger) {
        [self stopCountdown];
    }
}

#pragma mark - Notifications

- (void)applicationDidEnterBackground:(id)sender {
    NSLog(@"%s", __func__);

    _didEnterBackgroundTimestamp = [[NSDate date] timeIntervalSince1970];
}

- (void)applicationWillEnterForeground:(id)sender {
    NSLog(@"%s", __func__);

    NSTimeInterval willEnterForegroundTimestamp = [[NSDate date] timeIntervalSince1970];

    NSInteger onBackgroundSeconds = floor((_didEnterBackgroundTimestamp == 0)? 0: (willEnterForegroundTimestamp - _didEnterBackgroundTimestamp));
    _currentInteger -= onBackgroundSeconds;
}

- (void)dealloc {
    NSLog(@"%s", __func__);

    [self stopCountdown];
}

@end

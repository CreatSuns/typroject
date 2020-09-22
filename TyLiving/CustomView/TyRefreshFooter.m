//
//  WYARefreshFooter.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/4/1.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "TyRefreshFooter.h"

@interface TyRefreshFooter ()
@property (weak, nonatomic) UILabel * label;
@property (weak, nonatomic) UIActivityIndicatorView * loading;
@end

@implementation TyRefreshFooter

// 设置初始样式
- (void)prepare {
    [super prepare];

    // 设置控件的高度
    self.mj_h = 50;

    // 添加label
    UILabel * label     = [[UILabel alloc] init];
//    label.textColor     = [UIColor wya_textDarkGrayColor];
    label.font          = FONT(15);
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;

    // loading
    UIActivityIndicatorView * loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

// 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];

    self.label.frame    = self.bounds;
    self.loading.center = CGPointMake(ScreenWidth / 2 - 60, self.mj_h * 0.5);
}

// 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

// 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

// 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

// 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
//    self.label.textColor = [UIColor wya_textGrayColor];
    self.label.font      = FONT(13);
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉加载数据";
            [self.loading stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在加载...";
            [self.loading startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"没有更多数据";

            [self.loading stopAnimating];
            break;
        default:
            break;
    }
}

@end

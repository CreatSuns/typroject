//
//  WYARefreshHeader.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/30.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "TyRefreshHeader.h"

@interface TyRefreshHeader ()
@property (nonatomic, strong) UILabel * refreshLabel;
@property (nonatomic, strong) UIImageView * imageView;
@property (weak, nonatomic) UIActivityIndicatorView * loading;
@end

@implementation TyRefreshHeader

// 设置初始样式
- (void)prepare {
    [super prepare];
    // 设置控件的高度
    self.mj_h = 44;
    // 添加label
    UILabel * label     = [[UILabel alloc] init];
//    label.textColor     = [UIColor wya_goldenColor];
    label.font          = FONT(15);
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.refreshLabel = label;

    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image         = [UIImage imageNamed:@"icon_arrrowDown"];
    [self addSubview:imageView];
    self.imageView = imageView;

    UIActivityIndicatorView * loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    loading.color                     = [UIColor wya_goldenColor];
    [self addSubview:loading];
    self.loading = loading;
}

// 设置子视图位置
- (void)placeSubviews {
    [super placeSubviews];

    self.refreshLabel.frame = self.bounds;
    self.imageView.center   = CGPointMake(ScreenWidth / 2 - 60, self.mj_h * 0.5);
    self.imageView.bounds   = CGRectMake(0, 0, 15 * SizeAdapter, 15 * SizeAdapter);
    self.loading.center     = CGPointMake(ScreenWidth / 2 - 60, self.mj_h * 0.5);
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

    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.imageView.image   = [UIImage imageNamed:@"icon_arrrowDown"];
            self.refreshLabel.text = @"下拉可以刷新";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.imageView.image   = [UIImage imageNamed:@"icon_arrrowup"];
            self.refreshLabel.text = @"释放立即刷新";
            break;
        case MJRefreshStateRefreshing:
            self.imageView.image   = nil;
            self.refreshLabel.text = @"正在刷新...";
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

@end

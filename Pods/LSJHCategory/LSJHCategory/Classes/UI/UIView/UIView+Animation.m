//
//  UIView+Animation.m
//
//  Created by 李世航 on 2018/12/20.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)ll_setRotationAnimation:(CGFloat)angle time:(CGFloat)time repeatCount:(NSUInteger)repeat
{
    CABasicAnimation * rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue    = [NSNumber numberWithFloat:(M_PI / 180.f) * angle];
    rotationAnimation.duration   = time;
    rotationAnimation.cumulative = (NSInteger)angle % 360 ? NO : YES;
    if (repeat) {
        rotationAnimation.repeatCount = repeat;
    } else {
        rotationAnimation.repeatCount = MAXFLOAT;
    }

    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)ll_removeRotationAnimation
{
    [self.layer removeAnimationForKey:@"rotationAnimation"];
}

- (void)ll_setFlipAnimation
{
    CABasicAnimation * rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.toValue     = [NSNumber numberWithFloat:(M_PI / 180.f) * 180];
    rotationAnimation.duration    = 0.5;
    rotationAnimation.cumulative  = NO;
    rotationAnimation.repeatCount = 1;

    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end

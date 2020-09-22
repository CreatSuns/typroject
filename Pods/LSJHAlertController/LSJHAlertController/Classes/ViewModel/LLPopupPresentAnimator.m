//
//  LLPopupPresentAnimator.m
//
//  Created by  on 16/11/3.
//  Copyright © 2016年 code. All rights reserved.
//

#import "LLPopupPresentAnimator.h"
#import "LLAlertController.h"

@implementation LLPopupPresentAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.presentStyle) {
        case LLPopupPresentStyleSystem:
            return 0.3;
        case LLPopupPresentStyleFadeIn:
            return 0.2;
        case LLPopupPresentStyleBounce:
            return 0.3;
        case LLPopupPresentStyleExpandHorizontal:
            return 0.3;
        case LLPopupPresentStyleExpandVertical:
            return 0.3;
        case LLPopupPresentStyleSlideDown:
            return 0.5;
        case LLPopupPresentStyleSlideUp:
            return 0.3;
        case LLPopupPresentStyleSlideLeft:
            return 0.4;
        case LLPopupPresentStyleSlideRight:
            return 0.4;
        case LLPopupPresentStyleFoucs:
            return 0.5;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [self animateWithStyle:self.presentStyle context:transitionContext];
}

- (void)animateWithStyle:(LLPopupPresentStyle)style
                 context:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (style) {
        case LLPopupPresentStyleSystem:
            [self systemAnimationWithContext:transitionContext];
            break;
        case LLPopupPresentStyleFadeIn:
            [self fadeInAnimationWithContext:transitionContext];
            break;
        case LLPopupPresentStyleBounce:
            [self bounceAnimationWithContext:transitionContext];
            break;
        case LLPopupPresentStyleExpandHorizontal:
            [self expandHorizontalAnimationWithContext:transitionContext];
            break;
        case LLPopupPresentStyleExpandVertical:
            [self expandVerticalAnimationWithContext:transitionContext];
            break;
        case LLPopupPresentStyleSlideDown:
            [self slideDownAnimationWithContext:transitionContext];
            break;
        case LLPopupPresentStyleSlideUp:
            [self slideUpAnimationWithContext:transitionContext];
            break;
        case LLPopupPresentStyleSlideLeft:
            [self slideLeftAnimationWithContext:transitionContext];
            break;
        case LLPopupPresentStyleSlideRight:
            [self slideRightAnimationWithContext:transitionContext];
            break;
        case LLPopupPresentStyleFoucs:
            [self foucsAnimationWithContext:transitionContext];
            break;
    }
}

- (void)systemAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundButton.alpha = 0;
    toVC.alertView.alpha        = 0;
    //    toVC.alertView.transform = CGAffineTransformMakeScale(1.3, 1.3);

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        toVC.backgroundButton.alpha = as_backgroundAlpha;
        toVC.alertView.alpha        = 1;
        //                         toVC.alertView.transform = CGAffineTransformIdentity;
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)fadeInAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.alpha = 0;

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{ toVC.view.alpha = 1; }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)bounceAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundButton.alpha = 0;
    toVC.alertView.alpha        = 1;
    toVC.alertView.transform    = CGAffineTransformMakeScale(0.3, 0.3);

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    delay:0
    usingSpringWithDamping:1
    initialSpringVelocity:50
    options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseIn
    animations:^{
        toVC.backgroundButton.alpha = as_backgroundAlpha;
        toVC.alertView.alpha        = 1;
        toVC.alertView.transform    = CGAffineTransformIdentity;
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)expandHorizontalAnimationWithContext:
(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundButton.alpha = 0;
    toVC.alertView.alpha        = 0;
    toVC.alertView.transform    = CGAffineTransformMakeScale(0, 1);

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        toVC.backgroundButton.alpha = as_backgroundAlpha;
        toVC.alertView.alpha        = 1;
        toVC.alertView.transform    = CGAffineTransformIdentity;
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)expandVerticalAnimationWithContext:
(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundButton.alpha = 0;
    toVC.alertView.alpha        = 0;
    toVC.alertView.transform    = CGAffineTransformMakeScale(1, 0);

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        toVC.backgroundButton.alpha = as_backgroundAlpha;
        toVC.alertView.alpha        = 1;
        toVC.alertView.transform    = CGAffineTransformIdentity;
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)slideDownAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundButton.alpha = 0;
    toVC.alertView.center =
    CGPointMake(toVC.view.center.x, -toVC.alertView.frame.size.height / 2.0);

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        toVC.backgroundButton.alpha = as_backgroundAlpha;
        toVC.alertView.center       = toVC.view.center;
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)slideUpAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundButton.alpha = 0;
    if (toVC.alertStyle == LLAlertStyleDefalut) {
        toVC.alertView.center =
        CGPointMake(toVC.view.center.x,
                    toVC.view.frame.size.height + toVC.alertView.frame.size.height / 2.0);

        UIView * containerView = [transitionContext containerView];
        [containerView addSubview:toVC.view];

        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration
        animations:^{
            toVC.backgroundButton.alpha = as_backgroundAlpha;
            toVC.alertView.center       = toVC.view.center;
        }
        completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
    } else if (toVC.alertStyle == LLAlertStyleSheet ||
               toVC.alertStyle == LLAlertStyleCustomSheet) {
        toVC.alertView.frame =
        CGRectMake((toVC.view.cmam_width - toVC.alertView.cmam_width) / 2, ScreenHeight,
                   toVC.alertView.cmam_width, toVC.alertView.cmam_height);
        UIView * containerView = [transitionContext containerView];
        [containerView addSubview:toVC.view];

        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration
        animations:^{
            toVC.backgroundButton.alpha = as_backgroundAlpha;
            toVC.alertView.frame =
            CGRectMake((toVC.view.cmam_width - toVC.alertView.cmam_width) / 2,
                       ScreenHeight - toVC.alertView.cmam_height, toVC.alertView.cmam_width,
                       toVC.alertView.cmam_height);
        }
        completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
    }
}

- (void)slideLeftAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundButton.alpha = 0;
    toVC.alertView.center       = CGPointMake(
    toVC.view.frame.size.width + toVC.alertView.frame.size.width / 2.0, toVC.view.center.y);

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        toVC.backgroundButton.alpha = as_backgroundAlpha;
        toVC.alertView.center       = toVC.view.center;
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)slideRightAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundButton.alpha = 0;
    toVC.alertView.center       = CGPointMake(-toVC.alertView.frame.size.width / 2.0, toVC.view.center.y);

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        toVC.backgroundButton.alpha = as_backgroundAlpha;
        toVC.alertView.center       = toVC.view.center;
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)foucsAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.alpha = 0;

    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        toVC.view.alpha = 1;
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

@end

//
//  LLPopupDismissAnimator.m
//
//  Created by  on 16/11/3.
//  Copyright © 2016年 code. All rights reserved.
//

#import "LLPopupDismissAnimator.h"
#import "LLAlertController.h"

@implementation LLPopupDismissAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.dismissStyle) {
        case LLPopupDismissStyleFadeOut:
            return 0.15;
        case LLPopupDismissStyleShrink:
            return 0.3;
        case LLPopupDismissStyleContractHorizontal:
            return 0.2;
        case LLPopupDismissStyleContractVertical:
            return 0.2;
        case LLPopupDismissStyleSlideDown:
            return 0.25;
        case LLPopupDismissStyleSlideUp:
            return 0.25;
        case LLPopupDismissStyleSlideLeft:
            return 0.2;
        case LLPopupDismissStyleSlideRight:
            return 0.2;
        case LLPopupDismissStyleOutofFocus:
            return 0.5;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [self animateWithStyle:self.dismissStyle context:transitionContext];
}

- (void)animateWithStyle:(LLPopupDismissStyle)style
                 context:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.dismissStyle) {
        case LLPopupDismissStyleFadeOut:
            [self fadeOutAnimationWithContext:transitionContext];
            break;
        case LLPopupDismissStyleShrink:
            [self shrinkAnimationWithContext:transitionContext];
            break;
        case LLPopupDismissStyleContractHorizontal:
            [self contractHorizontalAnimationWithContext:transitionContext];
            break;
        case LLPopupDismissStyleContractVertical:
            [self contractVerticalAnimationWithContext:transitionContext];
            break;
        case LLPopupDismissStyleSlideDown:
            [self slideDownAnimationWithContext:transitionContext];
            break;
        case LLPopupDismissStyleSlideUp:
            [self slideUpAnimationWithContext:transitionContext];
            break;
        case LLPopupDismissStyleSlideLeft:
            [self slideLeftAnimationWithContext:transitionContext];
            break;
        case LLPopupDismissStyleSlideRight:
            [self slideRightAnimationWithContext:transitionContext];
            break;
        case LLPopupDismissStyleOutofFocus:
            [self OutofFoucsAnimationWithContext:transitionContext];
            break;
    }
}

- (void)fadeOutAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{ fromVC.view.alpha = 0; }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)shrinkAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.backgroundButton.alpha = as_backgroundAlpha;
    fromVC.alertView.alpha        = 1;
    fromVC.alertView.transform    = CGAffineTransformMakeScale(1, 1);
    NSTimeInterval duration       = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    delay:0
    usingSpringWithDamping:0.95
    initialSpringVelocity:50
    options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
    animations:^{
        fromVC.backgroundButton.alpha = 0;
        fromVC.alertView.alpha        = 0;
        //        fromVC.alertView.transform = CGAffineTransformMakeRotation(M_PI);
        fromVC.alertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)contractHorizontalAnimationWithContext:
(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        fromVC.backgroundButton.alpha = 0;
        fromVC.alertView.transform    = CGAffineTransformMakeScale(0.001, 1);
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)contractVerticalAnimationWithContext:
(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        fromVC.backgroundButton.alpha = 0;
        fromVC.alertView.transform    = CGAffineTransformMakeScale(1, 0.01);
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)slideDownAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        fromVC.backgroundButton.alpha = 0;
        fromVC.alertView.center =
        CGPointMake(fromVC.view.center.x, fromVC.view.frame.size.height +
                                          fromVC.alertView.frame.size.height / 2.0);
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)slideUpAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    if (fromVC.alertStyle == LLAlertStyleDefalut) {
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration
        animations:^{
            fromVC.backgroundButton.alpha = 0;
            fromVC.alertView.center =
            CGPointMake(fromVC.view.center.x, -fromVC.alertView.frame.size.height / 2.0);
        }
        completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];

    } else if (fromVC.alertStyle == LLAlertStyleSheet ||
               fromVC.alertStyle == LLAlertStyleCustomSheet) {
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration
        animations:^{
            fromVC.backgroundButton.alpha = as_backgroundAlpha;
            fromVC.alertView.frame        = CGRectMake(
            (fromVC.view.cmam_width - fromVC.alertView.cmam_width) / 2, ScreenHeight,
            fromVC.alertView.cmam_width, fromVC.alertView.cmam_height);
        }
        completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
    }
}

- (void)slideLeftAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        fromVC.backgroundButton.alpha = 0;
        fromVC.alertView.center =
        CGPointMake(-fromVC.alertView.frame.size.width / 2.0, fromVC.view.center.y);
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)slideRightAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    LLAlertController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{
        fromVC.backgroundButton.alpha = 0;
        fromVC.alertView.center =
        CGPointMake(fromVC.view.frame.size.width + fromVC.alertView.frame.size.width / 2.0,
                    fromVC.view.center.y);
    }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

- (void)OutofFoucsAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
    animations:^{ fromVC.view.alpha = 0; }
    completion:^(BOOL finished) { [transitionContext completeTransition:YES]; }];
}

@end

//
//  LLPopupDismissAnimator.h
//
//  Created by  on 16/11/3.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLPopupDismissAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) LLPopupDismissStyle dismissStyle;

@end

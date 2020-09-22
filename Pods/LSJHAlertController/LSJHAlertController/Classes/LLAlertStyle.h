//
//  LLAlertStyle.h
//  LSJHAlertController
//
//  Created by 李世航 on 2020/6/2.
//

#ifndef LLAlertStyle_h
#define LLAlertStyle_h

/** present style */
typedef NS_ENUM(NSInteger, LLPopupPresentStyle) {
    //alert
    LLPopupPresentStyleSystem,           // 系统样式
    LLPopupPresentStyleFadeIn,           // 渐入
    LLPopupPresentStyleBounce,           // 弹出
    LLPopupPresentStyleExpandHorizontal, // 水平展开
    LLPopupPresentStyleExpandVertical,   // 垂直展开
    LLPopupPresentStyleSlideDown,        // 从上往下划入
    LLPopupPresentStyleSlideUp,          // 从下往上划入
    LLPopupPresentStyleSlideLeft,        // 从右往左划入
    LLPopupPresentStyleSlideRight,       // 从左往右划入

    // photoBrowser
    LLPopupPresentStyleFoucs, //聚焦
};

/** dismiss style */
typedef NS_ENUM(NSInteger, LLPopupDismissStyle) {
    //alert
    LLPopupDismissStyleFadeOut,            // 渐出
    LLPopupDismissStyleShrink,             // 缩起
    LLPopupDismissStyleContractHorizontal, // 水平收起
    LLPopupDismissStyleContractVertical,   // 垂直收起
    LLPopupDismissStyleSlideDown,          // 向下划出
    LLPopupDismissStyleSlideUp,            // 向上划出
    LLPopupDismissStyleSlideLeft,          // 向左划出
    LLPopupDismissStyleSlideRight,         // 向右划出

    // photoBrowser
    LLPopupDismissStyleOutofFocus, //失焦
};

typedef NS_ENUM(NSInteger, LLAlertStyle) {
    LLAlertStyleDefalut,
    LLAlertStyleSheet,
    LLAlertStyleCustomAlert,
    LLAlertStyleCustomSheet,
};

/**
 只有在LLAlertStyleDefalut模式下有效

 - LLAlertLayoutStyleHorizontal: 水平
 - LLAlertStyleSheetVertical: 垂直
 */
typedef NS_ENUM(NSInteger, LLAlertLayoutStyle) {
    LLAlertLayoutStyleHorizontal,
    LLAlertLayoutStyleVertical,
};


#endif /* LLAlertStyle_h */

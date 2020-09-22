//
//  RootViewController.m
//
//  Created by 李世航 on 2018/7/3.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

///// 存放初始化tabBar的数据模型
//@property (nonnull, nonatomic, strong) NSArray<RootControllerModel *> * tabBarModelArray;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBarModelArray];
    self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - createModel
- (void)createTabBarModelArray {
    NSMutableArray * array = [NSMutableArray array];
    RootControllerModel * item1Model = [RootControllerModel modelWithTitle:@"首页"
                                                                 className:@"TyHomeViewController"
                                                           normalImageName:@""
                                                         selectedImageName:@""];
    RootControllerModel * item2Model = [RootControllerModel modelWithTitle:@"体验"
                                                                 className:@"TyExpViewController"
                                                           normalImageName:@""
                                                         selectedImageName:@""];

    RootControllerModel * item3Model = [RootControllerModel modelWithTitle:@"消息"
                                                                 className:@"TyMessageViewController"
                                                           normalImageName:@""
                                                         selectedImageName:@""];

    RootControllerModel * item4Model = [RootControllerModel modelWithTitle:@"我的"
            className:@"TyMineViewController"
      normalImageName:@""
    selectedImageName:@""];

    [array addObject:item1Model];
    [array addObject:item2Model];
    [array addObject:item3Model];
    [array addObject:item4Model];
//    _tabBarModelArray = [array copy];
    [self creatViewWithControllers:array];
}

#pragma mark - UI
- (void)creatViewWithControllers:(NSMutableArray <RootControllerModel *>*)array {
    NSMutableArray * viewControllers = [NSMutableArray array];
    for (RootControllerModel * model in array) {

        NSString * className = model.className;
        UIViewController * viewController = [[NSClassFromString(className) alloc] init];

        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.tabBarItem.title         = model.tabBarTitle;
        nav.tabBarItem.image         = [model normalImage];
        nav.tabBarItem.selectedImage = [model selectedImage];
        CGFloat fontSize             = self.tabBarTitleFont == 0 ? 10 * SizeAdapter : self.tabBarTitleFont;
        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : self.normalTitleColor == nil ? [UIColor grayColor] : self.normalTitleColor,
                                                             NSFontAttributeName : FONT(fontSize) }
                                                 forState:UIControlStateNormal];

        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.selectedTitleColor == nil ? [UIColor blackColor] : self.selectedTitleColor, NSForegroundColorAttributeName, nil] forState:(UIControlStateSelected)];
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
#pragma mark - 调整文字和图片的间距
    for (UITabBarItem * i in self.tabBar.items) {
        i.titlePositionAdjustment = UIOffsetMake(0, -2);
        i.imageInsets             = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
}

- (void)setTabBarTitleFont:(CGFloat)tabBarTitleFont {
    _tabBarTitleFont = tabBarTitleFont;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : self.normalTitleColor == nil ? [UIColor grayColor] : self.normalTitleColor,
                                                         NSFontAttributeName : FONT(tabBarTitleFont) }
                                             forState:UIControlStateNormal];
}
- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    _normalTitleColor = normalTitleColor;
    CGFloat fontSize  = self.tabBarTitleFont == 0 ? 14 : self.tabBarTitleFont;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : _normalTitleColor,
                                                         NSFontAttributeName : FONT(fontSize) }
                                             forState:UIControlStateNormal];
}
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_selectedTitleColor, NSForegroundColorAttributeName, nil] forState:(UIControlStateSelected)];
}
@end

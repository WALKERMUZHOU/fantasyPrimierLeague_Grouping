//
//  MMJumpTool.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/11.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMJumpTool.h"
#import "AppDelegate.h"
@implementation MMJumpTool

+ (void)pushViewController:(UIViewController *)viewController{
    [[self class] pushViewController:viewController animate:YES];
}

+ (void)pushViewController:(UIViewController *)viewController animate:(BOOL)animated{
    UIViewController *selectVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([selectVC isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)selectVC pushViewController:viewController animated:animated];
    }else if ([selectVC isKindOfClass:[UITabBarController class]]){
        AppDelegate *appdelete = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UINavigationController *naviVC;
        naviVC = (UINavigationController *)appdelete.tabBarViewController.selectedViewController;
        viewController.hidesBottomBarWhenPushed = YES;
        [naviVC pushViewController:viewController animated:animated];
    }
}


+ (void)presentViewController:(UIViewController *)viewController animate:(BOOL)animated{
    [[MMJumpTool topViewController] presentViewController:viewController animated:YES completion:nil];
}

+ (void)popToRootViewController{
    [[self class] popToCurrentRootViewController];
}

+ (void)popToCurrentRootViewController{
    UIViewController *selectVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([selectVC isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)selectVC popToRootViewControllerAnimated:YES];
    }else {
        AppDelegate *appdelete = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UINavigationController *naviVC;
        naviVC = (UINavigationController *)appdelete.tabBarViewController.selectedViewController;
        [naviVC popToRootViewControllerAnimated:YES];
    }
}


+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [[self class] _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [[self class] _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [[self class] _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [[self class] _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


@end

//
//  MMNavigationViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMNavigationViewController.h"

@interface MMNavigationViewController ()

@end

@implementation MMNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialNavTint];
}

- (void)initialNavTint {
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.translucent = NO;
    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarBg"] forBarMetrics:UIBarMetricsDefault];
//    // 去掉下边线
//    [self.navigationBar setShadowImage:[UIImage new]];
//
//    self.navigationBar.tintColor = kNavTintColor;
//    self.navigationBar.titleTextAttributes = @{
//                                               NSForegroundColorAttributeName:kNavTintColor
//                                               };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

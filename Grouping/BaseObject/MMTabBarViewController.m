//
//  MMTabBarViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/11.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMTabBarViewController.h"

@interface MMTabBarViewController ()

@end

@implementation MMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialMainViewController];
}

- (void)initialMainViewController {
    
    [self initialTabBarTint];
    
//    CQMHomeController *homeVC = [[CQMHomeController alloc] init];
//    [self initialChildViewController:homeVC title:@"首页" imageName:@"tab_bar_home"];
//
//    CQMHelpViewController *smallLoanVC = [[CQMHelpViewController alloc] init];
//    [self initialChildViewController:smallLoanVC title:@"工具" imageName:@"tab_bar_loan_small"];
//
//    CQMDKMMessageCenterViewController *largeLoanVC = [[CQMDKMMessageCenterViewController alloc] init];
//    [self initialChildViewController:largeLoanVC title:@"消息" imageName:@"tab_bar_loan_large"];
//
//    CQMMineViewController *mineVC = [[CQMMineViewController alloc] init];
//    [self initialChildViewController:mineVC title:@"我的" imageName:@"tab_bar_account"];
}

- (void)initialTabBarTint {
    
//    self.tabBar.tintColor = kTabBarTintColor;
//    
//    //    [self.tabBar setShadowImage:[self imageWithColor:[UIColor blackColor]] size:CGSizeMake(kScreenWidth,0.5)];
//    [self.tabBar setBackgroundImage:[self imageWithColor:kTabBarBackGroundColor]];
//    //    [self.tabBar setShadowImage:[self imageWithColor:kTabBarShadowColor]];
//    [self.tabBar setShadowImage:[[UIImage alloc] init]];
//    self.tabBar.layer.shadowColor = kTabBarShadowColor.CGColor;
//    self.tabBar.layer.shadowOffset = CGSizeMake(0, -1);
//    self.tabBar.layer.shadowOpacity = 5;
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

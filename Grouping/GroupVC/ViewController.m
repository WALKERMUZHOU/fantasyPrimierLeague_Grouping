//
//  ViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/9/12.
//  Copyright © 2018年 zmm. All rights reserved.
//

#import "ViewController.h"
#import "CalculateVCViewController.h"
#import "CalculateGroupingHistoryViewController.h"
#import "MMTBProgressViewController.h"
#import "MMKeyboardSlideViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *rowCount;
@property (weak, nonatomic) IBOutlet UITextField *listCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:myTap];
    
    MMKeyboardSlideViewController *vc = [[MMKeyboardSlideViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    
}


- (void)tap{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (IBAction)calculateClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (!self.rowCount.text || self.rowCount.text.integerValue == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请输入队伍数量" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self.navigationController presentViewController:alertVC animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertVC dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        return;
    }
    
    if (!self.listCount.text || self.listCount.text.integerValue == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请输入每组人数" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self.navigationController presentViewController:alertVC animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertVC dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        return;
    }
    
    CalculateVCViewController *calcuVC = [[CalculateVCViewController alloc]init];
    calcuVC.teamCount = self.rowCount.text.integerValue;
    calcuVC.perTeamCount = self.listCount.text.integerValue;
    [self.navigationController pushViewController:calcuVC animated:YES];
    
}

- (IBAction)historyClick:(UIBarButtonItem *)sender {

    CalculateGroupingHistoryViewController *historyVC = [[CalculateGroupingHistoryViewController alloc]init];
    [self.navigationController pushViewController:historyVC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

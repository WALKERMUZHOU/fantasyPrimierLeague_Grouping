//
//  MMTBProgressViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/15.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMTBProgressViewController.h"

@interface MMTBProgressViewController ()

@end

@implementation MMTBProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"条纹"]];
    imageView.frame = CGRectMake(20, 200, 200, 30);
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 15;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:imageView];

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

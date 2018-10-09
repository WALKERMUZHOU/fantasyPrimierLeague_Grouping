//
//  MMBaseTableViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseTableViewController.h"
#import "ConstantFile.h"
#import "ColorFile.h"

@interface MMBaseTableViewController ()

@end

@implementation MMBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initTableViewWithStyle:(UITableViewStyle)style {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, KScreenHeightBar) style:style];
    [_tableView setBackgroundColor:UIColorFromRGB(kColorBackground)];
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = UIColorFromRGB(kColorBackgroundLightGray);
    _tableView.sectionFooterHeight = 0;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [self addBackIcon];
}

- (void)addBackIcon{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-23, -46-32, 46, 46)];
//    [imageView setImage:[UIImage imageNamed:@"public_icon_background"]];
//    [_tableView addSubview:imageView];
}
#pragma mark - coordinatorDelegate

//- (void)coordinator:(CQMBaseCoordinator *)coordinator data:(id)data {
//    [super coordinator:coordinator data:data];
//    [self.tableView reloadData];
//}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

#pragma mark - Others

- (UIScrollView *)getListView {
    return self.tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

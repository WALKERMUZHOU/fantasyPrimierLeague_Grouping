//
//  MMBaseTalbleView.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseTalbleView.h"

@implementation MMBaseTalbleView


- (instancetype)init {
    self = [super init];
    if (self) {
        _tableViewStyle = UITableViewStyleGrouped;
        [self initTableViewWithStyle:_tableViewStyle];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tableViewStyle = UITableViewStyleGrouped;
        [self initTableViewWithStyle:_tableViewStyle];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame];
    if (self) {
        _tableViewStyle = style;
        [self initTableViewWithStyle:_tableViewStyle];
    }
    return self;
}

- (void)initTableViewWithStyle:(UITableViewStyle)style {
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:style];
    [_tableView setBackgroundColor:[UIColor colorWithRed:245/255 green:245/255 blue:245/255 alpha:1]];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor colorWithRed:246/255 green:246/255 blue:246/255 alpha:1];
    [self addSubview:_tableView];
}

- (void)setFrame:(CGRect)frame {
    if(!CGRectEqualToRect(frame, self.frame)) {
        [super setFrame:frame];
        if (!_tableView) {
            [_tableView setFrame:self.bounds];
        }
    }
}

- (void)addBackIcon{
//    CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
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
{   UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - setListView
- (UIScrollView *)getListView {
    return self.tableView;
}


@end

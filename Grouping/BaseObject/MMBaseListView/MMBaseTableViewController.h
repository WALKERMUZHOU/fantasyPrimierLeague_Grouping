//
//  MMBaseTableViewController.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMBaseTableViewController : MMBaseListViewController<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) UITableViewStyle tableViewStyle;//default is UITableViewStyleGrouped
@property (strong, nonatomic) UITableView *tableView; //Default listView is UITableView

- (void)initTableViewWithStyle:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END

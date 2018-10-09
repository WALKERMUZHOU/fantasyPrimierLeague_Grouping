//
//  CalculateGroupingHistoryViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "CalculateGroupingHistoryViewController.h"
#import "CalculateStoreDataTool.h"
#import "MMGroupingModel.h"
#import "MMGroupingDateModel.h"
#import "CalculateModel.h"
#import "ColorFile.h"
@interface CalculateGroupingHistoryViewController ()

@end

@implementation CalculateGroupingHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"历史分组";
    [self getStoredData];
    [self initTableViewWithStyle:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView reloadData];
}

- (void)getStoredData{
    self.dataSource = [[CalculateStoreDataTool getStoredArray] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MMGroupingModel *model = [self.dataSource objectAtIndex:section];
    
    return model.dateGroupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMGroupingModel *model = [self.dataSource objectAtIndex:indexPath.section];
    MMGroupingDateModel *dateModel = [model.dateGroupArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = dateModel.currentTitle;
    cell.textLabel.textColor = UIColorFromRGB(kColorLightBlack);
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    view.backgroundColor = UIColorFromRGB(kColorBackgroundF2);
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 35)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    
    [view addSubview:titleLabel];
    
    MMGroupingModel *model = [self.dataSource objectAtIndex:section];
    titleLabel.text = model.dateString;
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 34;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    MMGroupingModel *model = [self.dataSource objectAtIndex:indexPath.section];
    if (model.dateGroupArray.count == 1) {
        [self.dataSource removeObjectAtIndex:indexPath.section];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        NSMutableArray *array = [model.dateGroupArray mutableCopy];
        [array removeObjectAtIndex:indexPath.row];
        model.dateGroupArray = array;
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {    //删除
    
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除分组" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler (YES);
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
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

//
//  CGHistoryDetailViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/16.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "CGHistoryDetailViewController.h"
#import "CalculateModel.h"
#import "CalculateStoreDataTool.h"
#import "CGItemView.h"
#import "ConstantFile.h"

@interface CGHistoryDetailViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger teamCount;
@property (nonatomic, assign) NSInteger perTeamCount;
@property (nonatomic, strong) NSArray *lastStoredArray;

@end

@interface CGHistoryDetailViewController ()

@end

@implementation CGHistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self createUI];
}

- (void)initData{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(groupClick:)];
    
    self.perTeamCount = self.dataArray.count;
    NSArray *teamArray = [self.dataArray firstObject];
    self.teamCount = teamArray.count;
    self.title = @"历史分组详情";
    
}

- (void)createUI{
    for (NSInteger i = 0; i < self.perTeamCount; i++) {
        
        CGFloat Width = self.view.bounds.size.width;
        CGFloat gap = 10;
        CGFloat textFieldW = (Width - gap * (self.teamCount + 1))/self.teamCount;
        CGFloat textFieldH = 60;
        for (NSInteger j= 0; j < self.teamCount; j++) {
            
            if(i == 0){
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(gap + j*(textFieldW+gap),kNavigationBarHeight + gap + i*(textFieldH + gap), textFieldW, textFieldH)];
                label.text = [NSString stringWithFormat:@"第%ld组",j+1];
                label.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:label];
            }
            
            CGItemView *itemView = [[CGItemView alloc]initWithFrame:CGRectMake(gap + j*(textFieldW+gap),textFieldH + kNavigationBarHeight + gap + i*(textFieldH + gap), textFieldW, textFieldH)];
            [self.view addSubview:itemView];
            
            NSMutableArray *array = [[self.dataArray objectAtIndex:i] mutableCopy];
            CalculateModel *model = [array objectAtIndex:j];
            [itemView setModel:model];
            itemView.save = ^(CalculateModel * _Nonnull model) {
                [array replaceObjectAtIndex:j withObject:model];
                [self.dataArray replaceObjectAtIndex:i withObject:array];
            };
        }
    }
    
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:myTap];
}

- (void)tap{
    [self.view endEditing:YES];
}

- (void)groupClick:(UIButton *)sender{
    [self.view endEditing:YES];
    _dateModel.currentDateArray = self.dataArray;
    [CalculateStoreDataTool reStoreOneDateDate:_dateModel];
//    NSMutableArray *dataArray = [NSMutableArray array];
//    for (NSInteger i= 0; i < self.dataArray.count; i++) {
//        NSArray *array = [self.dataArray objectAtIndex:i];
//        NSArray *titleArray = [self getNameArray:array];
//        NSArray *dividedArray = [self dividedArray:titleArray andGroupIndex:i];
//        [dataArray addObject:dividedArray];
//        for (NSInteger j = 0; j < array.count; j++) {
//            if (i == 0) break;
//
//            UITextField *textField = [array objectAtIndex:j];
//            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//                NSInteger random = arc4random()%array.count;
//                textField.text = [NSString stringWithFormat:@"%@",titleArray[random]];
//            }];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((i*3 + j*0.5 + 1)* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [timer invalidate];
//                CalculateModel *model = dividedArray[j];
//                textField.text = model.name;
//
//            });
//        }
//    }
//    [CalculateStoreDataTool storeCalculateData:dataArray];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSArray *array = [CalculateStoreDataTool getStoredArray];
//
//        NSLog(@"%@",array);
//    });
    
}

#pragma mark - history in
- (void)setCurrentStoreArray:(NSArray *)currentStoreArray{
    
}

- (void)setDateModel:(MMGroupingDateModel *)dateModel{
    _dateModel = dateModel;
    self.dataArray = [dateModel.currentDateArray mutableCopy];
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

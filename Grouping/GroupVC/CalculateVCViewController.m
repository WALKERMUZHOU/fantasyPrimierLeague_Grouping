//
//  CalculateVCViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/9/12.
//  Copyright © 2018年 zmm. All rights reserved.
//

#import "CalculateVCViewController.h"
#import "CalculateModel.h"
#import "CalculateStoreDataTool.h"
@interface CalculateVCViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CalculateVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self createUI];
}

- (void)initData{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分组";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"开始分组" style:UIBarButtonItemStyleDone target:self action:@selector(groupClick:)];
    
    if (self.lastStoredArray && self.lastStoredArray.count >0) {
        self.perTeamCount = self.lastStoredArray.count;
        NSArray *teamArray = [self.lastStoredArray firstObject];
        self.teamCount = teamArray.count;
        self.navigationItem.rightBarButtonItem = nil;
        self.title = @"历史分组";
    }
    
    self.dataArray = [NSMutableArray arrayWithCapacity:self.perTeamCount];
    
}

- (void)createUI{
    for (NSInteger i = 0; i < self.perTeamCount; i++) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.teamCount];
        
        CGFloat Width = self.view.bounds.size.width;
        CGFloat gap = 10;
        CGFloat textFieldW = (Width - gap * (self.teamCount + 1))/self.teamCount;
        CGFloat textFieldH = 60;
        for (NSInteger j= 0; j < self.teamCount; j++) {
            
            if(i == 0){
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(gap + j*(textFieldW+gap),64 + gap + i*(textFieldH + gap), textFieldW, textFieldH)];
                label.text = [NSString stringWithFormat:@"第%ld组",j+1];
                label.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:label];
            }
            
            UITextField *textfiled = [[UITextField alloc]initWithFrame:CGRectMake(gap + j*(textFieldW+gap),textFieldH + 64 + gap + i*(textFieldH + gap), textFieldW, textFieldH)];
            textfiled.textAlignment = NSTextAlignmentCenter;
            textfiled.placeholder = [NSString stringWithFormat:@"%ld",self.teamCount *i + j + 1];
            textfiled.backgroundColor = [UIColor blackColor];
            textfiled.textColor = [UIColor whiteColor];
            textfiled.layer.cornerRadius = 4;
            textfiled.clipsToBounds = YES;
            [textfiled setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];

            if (self.lastStoredArray && self.lastStoredArray.count > 0) {
                NSArray *array = [self.lastStoredArray objectAtIndex:i];
                CalculateModel *model = [array objectAtIndex:j];
                textfiled.text = model.name;
            }
            
            [self.view addSubview:textfiled];
            [array addObject:textfiled];
        }
        [self.dataArray addObject:array];
    }
    
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:myTap];
}

- (void)tap{
    [self.view endEditing:YES];
}

- (void)groupClick:(UIButton *)sender{
    [self.view endEditing:YES];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger i= 0; i < self.dataArray.count; i++) {
        NSArray *array = [self.dataArray objectAtIndex:i];
        NSArray *titleArray = [self getNameArray:array];
        NSArray *dividedArray = [self dividedArray:titleArray andGroupIndex:i];
        [dataArray addObject:dividedArray];
            for (NSInteger j = 0; j < array.count; j++) {
                if (i == 0) break;
                
                UITextField *textField = [array objectAtIndex:j];
                NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                    NSInteger random = arc4random()%array.count;
                    textField.text = [NSString stringWithFormat:@"%@",titleArray[random]];
                }];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((i*3 + j*0.5 + 1)* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [timer invalidate];
                    CalculateModel *model = dividedArray[j];
                    textField.text = model.name;
                    
                });
            }
    }
    [CalculateStoreDataTool storeCalculateData:dataArray];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *array = [CalculateStoreDataTool getStoredArray];
        
        NSLog(@"%@",array);
    });
    
}

- (NSArray *)getNameArray:(NSArray *)array{
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:array.count];
    for (NSInteger i = 0; i<array.count; i++) {
        UITextField *textField = [array objectAtIndex:i];
        if (!textField.text || [textField.text isEqualToString:@""]) {
            [tempArray addObject:textField.placeholder];
        }else{
            [tempArray addObject:textField.text];
        }
    }
    return tempArray;
}

//分组
- (NSArray *)dividedArray:(NSArray *)array andGroupIndex:(NSInteger)groupIndex{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:array];
    NSMutableArray *dividedArray = [NSMutableArray arrayWithCapacity:array.count];
    for (NSInteger i = 0; i< array.count; i++) {
        NSInteger index = arc4random()%(array.count - i);
        if(groupIndex == 0){
            index = i;
            CalculateModel *model = [[CalculateModel alloc]init];
            model.groupId = index;
            model.name = tempArray[index];
            [dividedArray addObject:model];
        }else{
            CalculateModel *model = [[CalculateModel alloc]init];
            model.groupId = index;
            model.name = tempArray[index];
            [dividedArray addObject:model];
            [tempArray removeObjectAtIndex:index];
        }
    }
    return dividedArray;
}

#pragma mark - history in
- (void)setCurrentStoreArray:(NSArray *)currentStoreArray{
    
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

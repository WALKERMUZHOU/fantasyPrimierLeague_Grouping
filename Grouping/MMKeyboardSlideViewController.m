//
//  MMKeyboardSlideViewController.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/18.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMKeyboardSlideViewController.h"
#import "MMKeyboardSlideView.h"
#import "UITextField+cursor.h"

@interface MMKeyboardSlideViewController ()<UITextFieldDelegate>{
    MMKeyboardSlideView *_slideView;
}

@end

@implementation MMKeyboardSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self addNotification];
    // Do any additional setup after loading the view.
}
- (void)createUI{
    _slideView = [[MMKeyboardSlideView alloc]initWithFrame:CGRectMake(0, self.view.kheight, kScreenWidth, 40)];
    [self.view addSubview:_slideView];
    
    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(10, 200, kScreenWidth - 20, 50)];
    textfield.placeholder = @"请输入网址";
    textfield.layer.borderWidth = 1;
    textfield.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
    textfield.layer.cornerRadius = 4;
    textfield.font = kFont(13);
    textfield.textColor = UIColorFromRGB(0x666666);
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfield.delegate = self;
    [self.view addSubview:textfield];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, textfield.kheight)];
    textfield.leftView = leftView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    _slideView.textField = textfield;
}
#pragma mark--添加通知---
-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardF.origin.y;
    
    [UIView animateWithDuration:duration animations:^{
        self->_slideView.kbottom = keyboardY;
    }];
}
- (void)keyboardWillhide:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardF.origin.y;
    
    [UIView animateWithDuration:duration animations:^{
        self->_slideView.ktop = self.view.kheight;
    }];
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    //    NSDictionary *userInfo = notification.userInfo;
    //    // 动画的持续时间
    //    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    // 键盘的frame
    //    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat keyboardY = keyboardF.origin.y;
    //
    //    [UIView animateWithDuration:duration animations:^{
    //        self.bottomBgView.Y = keyboardY-49;
    //    }];
}
- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    
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

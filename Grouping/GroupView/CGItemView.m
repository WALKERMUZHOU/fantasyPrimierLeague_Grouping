//
//  CGItemView.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/16.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "CGItemView.h"
#import "UIColor+RCColor.h"

static NSInteger scoreTag = 1000;
static NSInteger nameTag = 1001;

@interface CGItemView ()<UITextFieldDelegate>

@end

@implementation CGItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    
    return self;
}

- (void)createUI{
    self.backgroundColor = [UIColor blackColor];
    
    CGFloat width = self.frame.size.width - 20;
    CGFloat height = 38;
    _scoreTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 0,width, height)];
    _scoreTF.textColor = [UIColor whiteColor];
    _scoreTF.textAlignment = NSTextAlignmentLeft;
    _scoreTF.font = [UIFont boldSystemFontOfSize:20];
    _scoreTF.keyboardType = UIKeyboardTypeNumberPad;
    _scoreTF.placeholder = @"分数";
    [_scoreTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_scoreTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];

    [_scoreTF addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];
    _scoreTF.delegate = self;
    _scoreTF.tag = scoreTag;
    [self addSubview:_scoreTF];
    
    _nameTF = [[UITextField alloc]initWithFrame:CGRectMake(10, self.frame.size.height - height,width, height)];
    _nameTF.textColor = [UIColor whiteColor];
    _nameTF.textAlignment = NSTextAlignmentRight;
    _nameTF.font = [UIFont boldSystemFontOfSize:20];
    _nameTF.placeholder = @"姓名";
    _nameTF.delegate = self;
    _nameTF.tag = nameTag;
    [_nameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_nameTF setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];

    [_nameTF addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_nameTF];
    
}

- (void)setModel:(CalculateModel *)model{
    _model = model;
    if (_model.grade && ![_model.grade isEqualToString:@""]) {
        _scoreTF.text = _model.grade;
    }
    
    _nameTF.text = _model.name;
    
    if (_scoreTF.text.length >0 || _nameTF.text.length > 0) {
        [self setHasText];
    }else{
        [self setNoText];
    }
}

#pragma mark - textfield
- (void)textFieldDidChangeValue:(UITextField *)textField{
    if(textField.text.length >0){
        [self setHasText];
    }else{
        if (_scoreTF.text.length >0 || _nameTF.text.length > 0) {
            [self setHasText];
        }else{
            [self setNoText];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == nameTag) {
        _model.name = textField.text;
    }else{
        _model.grade = textField.text;
    }
    if (self.save) {
        self.save(_model);
    }
}

#pragma mark - method
- (void)setHasText{
    self.backgroundColor = UIColorFromRGB(0xffd900);
    _scoreTF.textColor = [UIColor blackColor];
    _nameTF.textColor = [UIColor blackColor];
}

- (void)setNoText{
    self.backgroundColor = [UIColor blackColor];
    _scoreTF.textColor = [UIColor whiteColor];
    _nameTF.textColor = [UIColor whiteColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

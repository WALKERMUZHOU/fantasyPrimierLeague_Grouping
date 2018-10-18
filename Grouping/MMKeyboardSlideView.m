//
//  MMKeyboardSlideView.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/18.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMKeyboardSlideView.h"

@interface MMKeyboardSlideView ()<UITextFieldDelegate>

@end

@implementation MMKeyboardSlideView{
    UISlider *_slider;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        
    }
    return self;
}

- (void)createUI{
    self.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, 10)];
    _slider.kcenterY = self.frame.size.height/2;
    _slider.backgroundColor = UIColorFromRGB(0xe5e6e7);
    _slider.layer.cornerRadius = 5;
    _slider.value = 0.5;
    _slider.tintColor = UIColorFromRGB(0xe5e6e7);
    _slider.minimumTrackTintColor = UIColorFromRGB(0xe5e6e7);
    _slider.maximumTrackTintColor = UIColorFromRGB(0xe5e6e7);
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_slider];
}

- (void)sliderValueChanged:(UISlider *)slider{
    CGFloat sliderValue = slider.value;
}

- (void)setTextField:(UITextField *)textField{
    _textField = textField;
    _textField.delegate = self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

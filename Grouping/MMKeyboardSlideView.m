//
//  MMKeyboardSlideView.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/18.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMKeyboardSlideView.h"
#import "MMAdapt/Categories/UIKits/UITextView/UITextField+cursor.h"
@interface MMKeyboardSlideView ()<UITextFieldDelegate>{
    CGFloat _position;
}

@end

static NSInteger sliderWidth = 200;

@implementation MMKeyboardSlideView{
    UISlider *_slider;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        //初始化时,slider在中间
        _position = 0.5f;
    }
    return self;
}

- (void)createUI{
    self.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(10, 10, sliderWidth, 10)];
    _slider.kcenterY = self.frame.size.height/2;
    _slider.kcenterX = self.frame.size.width/2;
    _slider.backgroundColor = UIColorFromRGB(0xe5e6e7);
    _slider.layer.cornerRadius = 5;
    _slider.value = 0.5;
    _slider.tintColor = UIColorFromRGB(0xe5e6e7);
    _slider.minimumTrackTintColor = UIColorFromRGB(0xe5e6e7);
    _slider.maximumTrackTintColor = UIColorFromRGB(0xe5e6e7);
    [_slider addTarget:self action:@selector(sliderTouched) forControlEvents:UIControlEventTouchDown];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderValueEnded:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_slider];
    
}

- (void)sliderTouched{
    if (self.beginBlock) {
        self.beginBlock();
    }
    CGFloat sliderEndWidth = kScreenWidth - 20;
    [UIView animateWithDuration:0.2 animations:^{
        self->_slider.frame = CGRectMake(10, (self.frame.size.height - 10)/2, sliderEndWidth, 10);
    }];
}

- (void)sliderValueChanged:(UISlider *)slider{
    CGFloat sliderValue = slider.value;
    [self calculatePostionChanged:sliderValue];
    NSLog(@"%lf",sliderValue);
}

- (void)sliderValueEnded:(UISlider *)slider{
    CGFloat sliderValue = slider.value;
    NSLog(@"ended%lf",sliderValue);
    [_slider setValue:0.5 animated:YES];
    _position = 0.5;
    if (self.endBlock) {
        self.endBlock();
    }
    [UIView animateWithDuration:0.2 animations:^{
        self->_slider.frame = CGRectMake((self.frame.size.width - sliderWidth)/2, (self.frame.size.height - 10)/2, sliderWidth, 10);
    }];
}

- (void)setTextField:(UITextField *)textField{
    _textField = textField;
    _textField.delegate = self;
}

- (void)calculatePostionChanged:(CGFloat)currentSliderValue{
    NSInteger textFiledLength = _textField.text.length;
    NSInteger cursorPoint = _textField.curOffset;
    CGFloat minGapValue = 0.25/textFiledLength;
    
    CGFloat swipeDistance = currentSliderValue - _position;//滑动距离
    if(swipeDistance < 0){// <0 往左滑动
        if (fabs(swipeDistance) > minGapValue ) {
            _position = currentSliderValue;
            NSInteger cursorMovePoint = fabs(swipeDistance)/minGapValue;
            if (cursorMovePoint == 0) {
                cursorMovePoint = 1;
            }
            if((cursorPoint - cursorMovePoint) < 0){
                [_textField makeOffsetFromBeginning:0];
            }else{
                [_textField makeOffset:-(cursorMovePoint)];
            }
            
        }
    }else{// >0 往右滑动
        if(fabs(swipeDistance) > minGapValue){
            _position = currentSliderValue;
            NSInteger cursorMovePoint = fabs(swipeDistance)/minGapValue;
            if((cursorPoint + cursorPoint)>textFiledLength){
                [_textField makeOffset:(textFiledLength - cursorPoint)];
            }else{
                [_textField makeOffset:cursorMovePoint];
            }
        }
    }
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

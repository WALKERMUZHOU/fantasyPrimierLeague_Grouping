//
//  MMKeyboardSlideView.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/18.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SliderBeginBlock)(void);
typedef void(^SliderEndBlock)(void);

@protocol MMKeyboardSlideViewDelegate <NSObject>

- (void)slideViewDidSlide:(NSInteger)cursorPoint;

@end

@interface MMKeyboardSlideView : MMBaseView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) SliderBeginBlock  beginBlock;
@property (nonatomic, copy) SliderEndBlock    endBlock;

@end

NS_ASSUME_NONNULL_END

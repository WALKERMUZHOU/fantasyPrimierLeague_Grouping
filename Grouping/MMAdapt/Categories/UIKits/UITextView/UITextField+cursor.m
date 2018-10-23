//
//  UITextField+cursor.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/18.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "UITextField+cursor.h"

@implementation UITextField (cursor)

- (NSInteger)curOffset{
    // 基于文首计算出到光标的偏移数值。
    return [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
}

- (void)makeOffset:(NSInteger)offset{
    
    UITextRange *selectedRange = [self selectedTextRange];
    
    NSInteger currentOffset = [self offsetFromPosition:self.beginningOfDocument toPosition:selectedRange.start];
    
    currentOffset += offset;
    
    UITextPosition *newPos = [self positionFromPosition:self.beginningOfDocument offset:currentOffset];
    self.selectedTextRange = [self textRangeFromPosition:newPos toPosition:newPos];
}

- (void)makeOffsetFromBeginning:(NSInteger)offset{
    
    // 先把光标移动到文首，然后再调用上面实现的偏移函数。
    UITextPosition *begin = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:begin offset:offset];
    UITextRange *range = [self textRangeFromPosition:start toPosition:start];
    [self setSelectedTextRange:range];
}

@end

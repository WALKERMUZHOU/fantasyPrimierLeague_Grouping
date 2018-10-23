//
//  UITextField+cursor.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/18.
//  Copyright © 2018 zmm. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UITextField (cursor)

- (NSInteger)curOffset;


/**
 以当前光标位置为起始位置
 offset<0 往左移动
 offset>0 往右移动
 @param offset 偏移的量
 */
- (void)makeOffset:(NSInteger)offset;

- (void)makeOffsetFromBeginning:(NSInteger)offset;

@end

NS_ASSUME_NONNULL_END

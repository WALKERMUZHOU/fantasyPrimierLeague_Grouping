//
//  CalclateModel.m
//  Grouping
//
//  Created by 朱成龙 on 2018/9/26.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "CalculateModel.h"

@implementation CalculateModel


#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.grade forKey:@"grade"];
    [aCoder encodeInteger:self.groupId forKey:@"groupId"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.grade = [aDecoder decodeObjectForKey:@"grade"];
        self.groupId = [aDecoder decodeIntegerForKey:@"groupId"];
    }
    
    return self;
}

@end

//
//  NSObject+DYModelArchive.m
//  DYModelMaker
//
//  Created by 杜燚 on 2018/9/12.
//  Copyright © 2018年 shuodakeji. All rights reserved.
//

#import "NSObject+DYModelArchive.h"
#import <objc/runtime.h>

@implementation NSObject (DYModelArchive)
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        u_int count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
        free(properties);
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    u_int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *key = [NSString stringWithUTF8String:propertyName];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(properties);
}
@end

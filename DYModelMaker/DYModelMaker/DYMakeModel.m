//
//  DYMakeModel.m
//  DYModelMaker
//
//  Created by 杜燚 on 2018/8/10.
//  Copyright © 2018年 shuodakeji. All rights reserved.
//

#import "DYMakeModel.h"
#import <objc/runtime.h>

@implementation DYMakeModel
- (NSMutableArray *)headArray {
    if (!_headArray) {
        _headArray = [NSMutableArray array];
    }
    return _headArray;
}

- (NSMutableArray *)footerArray {
    if (!_footerArray) {
        _footerArray = [NSMutableArray array];
    }
    return _footerArray;
}

- (NSMutableArray *)classArray {
    if (!_classArray) {
        _classArray = [NSMutableArray array];
    }
    return _classArray;
}

- (NSMutableString *)modelArrayString {
    if (!_modelArrayString) {
        _modelArrayString = [[NSMutableString alloc] init];
    }
    return _modelArrayString;
}

- (NSMutableString *)headStr {
    if (!_headStr) {
        _headStr = [[NSMutableString alloc] init];
    }
    return _headStr;
}

- (NSMutableString *)footerStr {
    if (!_footerStr) {
        _footerStr = [[NSMutableString alloc] init];
    }
    return _footerStr;
}



@end

@implementation DYHeadModel

@end




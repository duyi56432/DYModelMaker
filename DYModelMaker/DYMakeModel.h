//
//  DYMakeModel.h
//  DYModelMaker
//
//  Created by 杜燚 on 2018/8/10.
//  Copyright © 2018年 shuodakeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYMakeModel : NSObject
@property (nonatomic, copy) NSMutableArray *headArray;
@property (nonatomic, copy) NSMutableArray *footerArray;
@property (nonatomic, copy) NSMutableArray *classArray;

@property (nonatomic, copy) NSMutableString *modelArrayString;
@property (nonatomic, copy) NSMutableString *headStr;
@property (nonatomic, copy) NSMutableString *footerStr;
@property (nonatomic, strong) NSNumber *number;
@end

@interface DYHeadModel : NSObject
@property (nonatomic, copy) NSString *head;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, copy) NSString *className;
@end


//
//  DYTestModel.h
//  DYModelMaker
//
//  Created by 杜燚 on 2018/8/15.
//  Copyright © 2018年 shuodakeji. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DYTest2Model;

@interface DYTestModel : NSObject
@property (nonatomic, strong) NSNumber *testNumber;
@property (nonatomic, strong) NSString *testStr;
@property (nonatomic, strong) NSArray *testArr;
@property (nonatomic, assign) double testDouble;
@end

@interface DYTest1Model : NSObject
@property (nonatomic, strong) NSString *other;
@property (nonatomic, strong) NSString *testStr;
@end

@interface DYTest2Model : NSObject
@property (nonatomic, strong) NSNumber *testNumber;
@property (nonatomic, strong) NSString *testStr;
@property (nonatomic, strong) NSArray *testArr;
@property (nonatomic, strong) NSString *other;
@property (nonatomic, strong) NSString *other2;
@end

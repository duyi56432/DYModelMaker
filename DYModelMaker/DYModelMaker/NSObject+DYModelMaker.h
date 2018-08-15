//
//  NSObject+DYModelMaker.h
//  DYModelMaker
//
//  Created by 杜燚 on 2018/8/14.
//  Copyright © 2018年 shuodakeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "DYMakeModel.h"

typedef NS_ENUM(NSInteger,DYModelMakerType) {
    DYModelMakerTypeMJ,
    DYModelMakerTypeYY
};

@interface NSObject (DYModelMaker)
@property (nonatomic, assign, class) DYModelMakerType makerType;
@property (nonatomic, strong, class) NSString *modelKeyword;
@property (nonatomic, strong, class) DYHeadModel *headModel;

/**
 根据字典打印出对应属性模型
 
 @param dictionary 数据字典
 @param modelKeyword 模型前缀关键字 eg: DY....
 @param modelName 最外层模型名称,如果设置了前缀关键字会自动加上
 @param makerType 使用MJExtension 还是YYModel 自动生成模型中系统关键字替换和数组中字典转模型语法代码
 
 */
+ (void)DY_makeModelWithDictionary:(NSDictionary *)dictionary
                      modelKeyword:(NSString *)modelKeyword
                         modelName:(NSString *)modelName
                          makeType:(DYModelMakerType)makerType;

/**
 获取当前模型Interface部分
 */
+ (NSString *)currentInterfaceString;

/**
 获取当前模型Implementation部分
 */
+ (NSString *)currentImplementationString;

/**
 model赋值给toModel,只赋值属性名相同部分
 
 @param model 赋值model
 @param toModel 赋值对象的model
 */
+ (void)assignmentModel:(id)model toModel:(id)toModel;

/**
 copy 一个新的model
 
 @param model 需要copy的model
 @return 新的model
 */
+ (id)copyWithModel:(id)model;

/**
 将model1和model2合并到tomodel,相同属性model2覆盖model1
 
 @param model1 需要合并的model
 @param model2 需要合并的model
 @param tomodel 合并结果model
 */
+ (void)combineModelWithModel1:(id)model1 model2:(id)model2 toModel:(id)tomodel;
@end

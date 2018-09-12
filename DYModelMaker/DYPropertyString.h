//
//  DYPropertyString.h
//  DYModelMaker
//
//  Created by 杜燚 on 2018/9/12.
//  Copyright © 2018年 shuodakeji. All rights reserved.
//

#ifndef DYPropertyString_h
#define DYPropertyString_h

static NSString *stringClass = @"@property (nonatomic, copy) NSString *";
static NSString *numberClass = @"@property (nonatomic, strong) NSNumber *";
static NSString *nsnullClass = @"@property (nonatomic, strong) id ";
static NSString *doubleString = @"@property (nonatomic, assign) double ";
static NSString *dictionaryClass = @"@property (nonatomic, strong) ";
static NSString *arrayClass = @"@property (nonatomic, copy) NSArray *";
static NSString *MJ_ReplaceId = @"\n+(NSDictionary *)mj_replacedKeyFromPropertyName {\n  return @{@\"Id\" : @\"id\"};\n\n}";
static NSString *YY_ReplaceId = @"\n+(NSDictionary *)modelCustomPropertyMapper {\n  return @{@\"Id\" : @\"id\"};\n\n}";
static NSString *MJ_ArrIncludeDicToModelString = @"mj_objectClassInArray";
static NSString *YY_ArrIncludeDicToModelString = @"modelContainerPropertyGenericClass";
#endif /* DYPropertyString_h */

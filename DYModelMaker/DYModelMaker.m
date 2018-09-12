//
//  DYModelMaker.m
//  DYModelMaker
//
//  Created by 杜燚 on 2018/9/12.
//  Copyright © 2018年 shuodakeji. All rights reserved.
//

#import "DYModelMaker.h"
#import "DYPropertyString.h"
#import <objc/runtime.h>


@interface DYModelMaker ()
@property (nonatomic, strong) NSString *modelKeyword;
@property (nonatomic, strong) NSString *numberString;
@property (nonatomic, strong) DYHeadModel *headModel;
@end

@implementation DYModelMaker

static DYModelMaker *manager = nil;


+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DYModelMaker alloc] init];
        manager.numberString = numberClass;
    });
    return manager;
}

+ (NSString *)currentInterfaceString {
    return [NSString stringWithFormat:@"\n%@\n\n%@",manager.headModel.className,manager.headModel.head];
}

+ (NSString *)currentImplementationString {
    return [NSString stringWithFormat:@"\n%@",manager.headModel.footer];
}

- (void)setNumberType:(DYModelNumberType)numberType {
    switch (numberType) {
        case DYModelNumberTypeNumber:
            manager.numberString = numberClass;
            break;
        case DYModelNumberTypeString:
            manager.numberString = stringClass;
            break;
        case DYModelNumberTypeDouble:
            manager.numberString = doubleString;
            break;
        default:
            break;
    }
}

#pragma mark - 数据处理

+ (void)DY_makeModelWithDictionary:(NSDictionary *)dictionary
                      modelKeyword:(NSString *)modelKeyword
                         modelName:(NSString *)modelName {
    
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]] || dictionary.count == 0) {
        NSLog(@"非字典类型或字典为空!");
        return;
    }
    [DYModelMaker shareManager].modelKeyword = modelKeyword ?: @"";
    [DYModelMaker shareManager].headModel = [self dy_makeModelWithDictionary:dictionary ModelName:modelName];
    NSLog(@"====================@interface==================\n\n%@\n\n%@\n====================@implementation====================\n\n%@\n\n",manager.headModel.className,manager.headModel.head,manager.headModel.footer);
}

+ (DYHeadModel *)dy_makeModelWithDictionary:(NSDictionary *)dictionary ModelName:(NSString *)modelName {
    
    if (!dictionary) return nil;
    
    DYMakeModel *model = [[DYMakeModel alloc] init];
    [self modelHeadWithModelName:modelName MakeModel:model];
    
    for (id obj in dictionary) {
        if ([dictionary[obj] isKindOfClass:[NSString class]]) {
            
            [self modelWithString:obj ModelName:modelName MakeModel:model];
        } else if ([dictionary[obj] isKindOfClass:[NSNumber class]]) {
            
            [self modelWithNumber:obj ModelName:modelName MakeModel:model];
        } else if ([dictionary[obj] isKindOfClass:[NSDictionary class]]) {
            
            [self modelWithDictionary:obj ModelName:modelName MakeModel:model Dictionary:dictionary];
        } else if ([dictionary[obj] isKindOfClass:[NSArray class]]) {
            
            [self modelWithArray:obj ModelName:modelName MakeModel:model Dictionary:dictionary];
        } else if ([dictionary[obj] isKindOfClass:[NSNull class]]) {
            
            [model.headStr appendString:[NSString stringWithFormat:@"%@%@;\n",nsnullClass,obj]];
        } else {
            
            NSLog(@"%@不能识别的数据类型\n",obj);
        }
    }
    
    //数组中字典转模型
    if (model.modelArrayString.length > 0) {
        if (manager.makerType == DYModelMakerTypeMJ) {
            [model.footerStr appendFormat:@"\n+ (NSDictionary *)%@{\n return @{ %@ }; \n}",MJ_ArrIncludeDicToModelString,model.modelArrayString];
        } else if (manager.makerType == DYModelMakerTypeYY) {
            [model.footerStr appendFormat:@"\n+ (NSDictionary *)%@{\n return @{ %@ }; \n}",YY_ArrIncludeDicToModelString,model.modelArrayString];
        }
    }
    
    [self modelFooterWithMakeModel:model];
    
    NSString *classString = [model.classArray componentsJoinedByString:@""].length == 0 ? @"" : [NSString stringWithFormat:@"%@",[model.classArray componentsJoinedByString:@""]];
    
    DYHeadModel *headModel = [[DYHeadModel alloc] init];
    headModel.head = [model.headArray componentsJoinedByString:@"\n"];
    headModel.footer = [model.footerArray componentsJoinedByString:@"\n"];
    headModel.className = classString;
    
    return headModel;
}

+ (DYMakeModel *)modelHeadWithModelName:(NSString *)modelName MakeModel:(DYMakeModel *)model{
    
    [model.headStr appendString:[NSString stringWithFormat:@"@interface %@%@ : NSObject\n",manager.modelKeyword,[self capitalized:modelName]]];
    [model.footerStr appendString:[NSString stringWithFormat:@"@implementation %@%@\n",manager.modelKeyword,[self capitalized:modelName]]];
    if (modelName && modelName.length > 0) {
        [model.classArray addObject:[NSString stringWithFormat:@"@class %@%@;\n",manager.modelKeyword,[self capitalized:modelName]]];
    }
    return model;
}

+ (DYMakeModel *)modelFooterWithMakeModel:(DYMakeModel *)model{
    
    [model.headStr appendString:@"@end\n"];
    [model.footerStr appendString:@"\n@end\n"];
    [model.headArray insertObject:model.headStr atIndex:0];
    [model.footerArray insertObject:model.footerStr atIndex:0];
    return model;
}

+ (DYMakeModel *)modelWithString:(id)obj ModelName:(NSString *)modelName MakeModel:(DYMakeModel *)model{
    
    if ([obj isEqualToString:@"id"]) {
        [model.headStr appendString:[NSString stringWithFormat:@"%@Id;\n", stringClass]];
        //将id映射到Id
        if (manager.makerType == DYModelMakerTypeMJ) {
            [model.footerStr appendString:MJ_ReplaceId];
        } else if (manager.makerType == DYModelMakerTypeYY) {
            [model.footerStr appendString:YY_ReplaceId];
        }
        
    } else {
        [model.headStr appendString:[NSString stringWithFormat:@"%@%@;\n", stringClass, obj]];
    }
    return model;
}

+ (DYMakeModel *)modelWithNumber:(id)obj ModelName:(NSString *)modelName MakeModel:(DYMakeModel *)model {
    
    if ([obj isEqualToString:@"id"]) {
        [model.headStr appendString:[NSString stringWithFormat:@"%@Id;\n", manager.numberString]];
        if (manager.makerType == DYModelMakerTypeMJ) {
            [model.footerStr appendString:MJ_ReplaceId];
        } else if (manager.makerType == DYModelMakerTypeYY) {
            [model.footerStr appendString:YY_ReplaceId];
        }
    } else {
        [model.headStr appendString:[NSString stringWithFormat:@"%@%@;\n", manager.numberString, obj]];
    }
    return model;
}

+ (DYMakeModel *)modelWithDictionary:(id)obj ModelName:(NSString *)modelName MakeModel:(DYMakeModel *)model Dictionary:(NSDictionary *)dictionary{
    
    [model.headStr appendString:[NSString stringWithFormat:@"%@%@%@Model *%@;\n",dictionaryClass,manager.modelKeyword,[self capitalized:obj],obj]];
    DYHeadModel *headModel = [self dy_makeModelWithDictionary:dictionary[obj] ModelName:[NSString stringWithFormat:@"%@Model",obj]];
    
    [model.classArray addObject:headModel.className];
    [model.headArray addObject:headModel.head];
    [model.footerArray addObject:headModel.footer];
    return model;
}

+ (DYMakeModel *)modelWithArray:(id)obj ModelName:(NSString *)modelName MakeModel:(DYMakeModel *)model Dictionary:(NSDictionary *)dictionary{
    
    [model.headStr appendString:[NSString stringWithFormat:@"%@%@;\n",arrayClass,obj]];
    id resault = [self returnFirstObjWithArr:dictionary[obj]];
    if ([resault isKindOfClass:[NSDictionary class]]) {
        DYHeadModel *headModel = [self dy_makeModelWithDictionary:resault ModelName:[NSString stringWithFormat:@"%@Model",obj]];
        
        [model.classArray addObject:headModel.className];
        [model.headArray addObject:headModel.head];
        [model.footerArray addObject:headModel.footer];
        if (model.modelArrayString.length == 0) {
            [model.modelArrayString appendFormat:@"@\"%@\" : @\"%@%@Model\"", obj, manager.modelKeyword,[self capitalized:obj]];
        } else {
            [model.modelArrayString appendFormat:@",\n@\"%@\" : @\"%@%@Model\"\n", obj, manager.modelKeyword,[self capitalized:obj]];
        }
    }
    return model;
}

+ (id)returnFirstObjWithArr:(NSArray *)obj {
    
    if ([obj count] == 0) return nil;
    if ([[obj firstObject] isKindOfClass:[NSArray class]]) {
        return  [self returnFirstObjWithArr:[obj firstObject]];
    } else {
        return [obj firstObject];
    }
}

+ (NSString *)capitalized:(NSString *)string {
    NSMutableString *mStr = [NSMutableString stringWithString:string];
    if (string && string.length > 0) {
        char c = [string characterAtIndex:0];
        if(c>='a' && c<='z')
            c-=32;
        [mStr replaceCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%c",c]];
    }
    return mStr;
}

#pragma mark - 模型处理方法

+ (void)assignmentModel:(id)model toModel:(id)toModel {
    
    unsigned int modelCount = 0;
    Ivar *modelIvarList = class_copyIvarList([model class], &modelCount);
    
    for (NSInteger i = 0; i < modelCount; i++) {
        Ivar modelAivr = modelIvarList[i];
        Ivar toModelAivr = class_getInstanceVariable([toModel class], ivar_getName(modelAivr));
        if (object_getIvar(model, modelAivr)) {
            object_setIvar(toModel, toModelAivr, object_getIvar(model, modelAivr));
        }
    }
}

+ (id)copyWithModel:(id)model {
    
    if (!model) return nil;
    NSObject *newModel = [[[model class] alloc] init];
    unsigned int modelCount = 0;
    Ivar *modelIvarList = class_copyIvarList([model class], &modelCount);
    Ivar *newModelIvarList = class_copyIvarList([model class], &modelCount);
    
    for (NSInteger i = 0; i < modelCount; i++) {
        Ivar modelAivr = modelIvarList[i];
        Ivar newModelAivr = newModelIvarList[i];
        object_setIvar(newModel, newModelAivr, object_getIvar(model, modelAivr));
    }
    return newModel;
}

+ (void)combineModelWithModel1:(id)model1 model2:(id)model2 toModel:(id)tomodel {
    
    unsigned int toModelCount = 0;
    Ivar *toModelIvarList = class_copyIvarList([tomodel class], &toModelCount);
    
    for (NSInteger i = 0; i < toModelCount; i++) {
        Ivar toModelIvar = toModelIvarList[i];
        Ivar model1Ivar = class_getInstanceVariable([model1 class], ivar_getName(toModelIvar));
        Ivar model2Ivar = class_getInstanceVariable([model2 class], ivar_getName(toModelIvar));
        if (object_getIvar(model1, model1Ivar)) {
            object_setIvar(tomodel, toModelIvar, object_getIvar(model1, model1Ivar));
        }
        
        if (object_getIvar(model2, model2Ivar)) {
            object_setIvar(tomodel, toModelIvar, object_getIvar(model2, model2Ivar));
        }
    }
}

+ (BOOL)isEqualModel1:(id)model1 model2:(id)model2 {
    unsigned int modelCount = 0;
    Ivar *modelIvarList = class_copyIvarList([model1 class], &modelCount);
    BOOL isEqual = YES;
    for (NSInteger i = 0; i < modelCount; i++) {
        Ivar modelIvar = class_getInstanceVariable([model1 class], ivar_getName(modelIvarList[i]));
        if (object_getIvar(model1, modelIvar) != object_getIvar(model2, modelIvar)) {
            isEqual = NO;
            break;
        }
    }
    return isEqual;
}

@end

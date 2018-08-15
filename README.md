# DYModelMaker


# 中文说明

## 安装

### 使用 cocoapods

**pod 'DYModelMaker'**    


## 用法

目前提供了两类方法：
1.字典生成模型，支持多层模型嵌套，自动生成两种框架（MJExtension和YYModel）的系统关键字替换和数组中字典转模型代码，导入#import "NSObject+DYModelMaker.h"自动实现归档、解档，直接存取模型即可。

[![dicImg]](https://github.com/duyi56432/DYModelMaker/blob/master/dicImg.jpg)  

生成的结果

<pre><code> 
====================@interface==================

@class DYTestModel;
@class DYDataModel;
@class DYFlowinfoModel;
@class DYNextFlowIdModel;


@interface DYTestModel : NSObject
@property (nonatomic, strong) NSNumber *testModelId;
@property (nonatomic, strong) DataModel *data;
@end

@interface DYDataModel : NSObject
@property (nonatomic, strong) NSNumber *app_id;
@property (nonatomic, strong) NSNumber *flowTypeId;
@property (nonatomic, strong) NSArray *approveResultValue;
@property (nonatomic, strong) NSArray *flowinfo;
@property (nonatomic, strong) NSNumber *result;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, copy) NSString *forword_emp_name;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, strong) NextFlowIdModel *nextFlowId;
@end

@interface DYFlowinfoModel : NSObject
@property (nonatomic, strong) NSNumber *day_number;
@property (nonatomic, strong) NSNumber *flowinfoModelId;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *dept_name;
@property (nonatomic, strong) NSNumber *hour_number;
@property (nonatomic, copy) NSString *time2;
@end

@interface DYNextFlowIdModel : NSObject
@property (nonatomic, copy) NSString *test10;
@end

====================@implementation====================

@implementation DYTestModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
return @{@"Id" : @"id"};

}
@end

@implementation DYDataModel

+ (NSDictionary *)mj_objectClassInArray{
return @{ @"flowinfo" : @"DYFlowinfoModel" }; 
}
@end

@implementation DYFlowinfoModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
return @{@"Id" : @"id"};

}
@end

@implementation DYNextFlowIdModel

@end

</code></pre>

2.模型间赋值操作：
>>>>将model1 属性名相同的部分赋值给model2,不同部分互不影响
>>>>实现copy，深复制一个model
>>>>将model0 和 model1 合并赋值到model2，model2中和model0、model1不同属性部分互不影响

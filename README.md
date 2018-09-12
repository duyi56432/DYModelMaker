# DYModelMaker


# 中文说明

## 安装

### 使用 cocoapods

**pod 'DYModelMaker'**    

## 博客
[这里有更详细用法](https://www.jianshu.com/p/04f00837094c)

## 简介
@interface XYDHomeBannerModel : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *imgBg;

@property (nonatomic, copy) NSString *linkId;

@end

上面这段代码还在一个一个属性的敲吗？要是有100个字段呢？要是数据结构四五六七层呢？DYModelMaker解放你的双手，一行代码生成所有属性！

## 用法

目前提供了两类方法：

一.字典生成模型。

 1）支持多层模型嵌套，再也不怕数据结构复杂啦！
 
 2）自动生成两种框架（MJExtension和YYModel）的系统关键字替换和数组中字典转模型代码。
 
 3）导入#import "NSObject+DYModelMaker.h"自动实现归档、解档，直接存取模型即可.
 
 举个栗子：下面这段数据怕不怕？
![dicImg](https://github.com/duyi56432/DYModelMaker/blob/master/dicImg.jpg)  

使用DYModelMaker一行搞定

<pre><code>//直接放到网络请求结果调用，生成模型后删除就行，结果打印在控制台
[DYModelMaker DY_makeModelWithDictionary:dic modelKeyword:@"DY" modelName:@"testModel"  makeType:DYModelMakerTypeMJ];
</code></pre>

看结果--> 直接复制粘贴就行了

<pre><code> 
====================@interface==================

@class DYTestModel;
@class DYDataModel;
@class DYFlowinfoModel;
@class DYNextFlowIdModel;


@interface DYTestModel : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, strong) DYDataModel *data;
@end

@interface DYDataModel : NSObject
@property (nonatomic, copy) NSString *app_id;
@property (nonatomic, copy) NSString *flowTypeId;
@property (nonatomic, copy) NSArray *approveResultValue;
@property (nonatomic, copy) NSArray *flowinfo;
@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *forword_emp_name;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, strong) DYNextFlowIdModel *nextFlowId;
@end

@interface DYFlowinfoModel : NSObject
@property (nonatomic, copy) NSString *day_number;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *dept_name;
@property (nonatomic, copy) NSString *hour_number;
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


二.模型间赋值操作：
>1）将model1 属性名相同的部分赋值给model2,不同部分互不影响
<pre><code>DYTestModel *model0 = [[DYTestModel alloc] init];
model0.testStr = @"testStr0";
model0.testNumber = @10;

DYTest1Model *model1 = [[DYTest1Model alloc] init];
model1.testStr = @"testStr1";

[DYModelMaker assignmentModel:model0 toModel:model1]; </code></pre>
>2）实现copy，深复制一个model
<pre><code>DYTestModel *model0 = [[DYTestModel alloc] init];
model0.testStr = @"testStr0";
model0.testNumber = @10;

DYTestModel *model1 = [DYModelMaker copyWithModel:model0];</code></pre>
>3）将model0 和 model1 合并赋值到model2，model2中和model0、model1不同属性部分互不影响
<pre><code>DYTestModel *model0 = [[DYTestModel alloc] init];
model0.testNumber = @10;

DYTest1Model *model1 = [[DYTest1Model alloc] init];
model1.testStr = @"testStr1";

DYTest2Model *model2 = [[DYTest2Model alloc] init];
[DYModelMaker combineModelWithModel1:model0 model2:model1 toModel:model2];</code></pre>

//
//  ViewController.m
//  DYModelMaker
//
//  Created by 杜燚 on 17/3/1.
//  Copyright © 2017年 shuodakeji. All rights reserved.
//

#import "ViewController.h"
#import "DYModelMaker.h"
#import "DYTestModel.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //单利，只需配置一次
    [DYModelMaker shareManager].numberType = DYModelNumberTypeString;
    [DYModelMaker shareManager].makerType = DYModelMakerTypeMJ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self modelMakerTest];
            break;
        case 1:
            [self assignmentModelTest];
            break;
        case 2:
            [self copyModelTest];
            break;
        case 3:
            [self combineModelTest];
            break;
        case 4:
            [self isEqualModelTest];
            break;
        case 5:
            [self initModelTest];
            break;
        default:
            break;
    }
}

//生成model
- (void)modelMakerTest {
    NSDictionary *dic= @{@"id":@1,
                         @"data":@{@"app_id":@3,
                                   @"nextFlowId":@{@"test10":@""},
                                   @"approveResultValue":@[],
                                   @"title":@"加班流程",
                                   @"level":@1,
                                   @"flowinfo":@[@{@"reason":@"有其他事",
                                                   @"day_number":@6,
                                                   @"id":@(11),
                                                   @"time2":@"2017-03-03 11:28:00",
                                                   @"dept_name":@"技术部",
                                                   @"hour_number":@4}],
                                   @"flowTypeId":@4,
                                   @"department":@"技术部",
                                   @"result":@0,
                                   @"forword_emp_name":@"管理员 狗蛋 "}};
    
    [DYModelMaker DY_makeModelWithDictionary:dic
                            modelKeyword:@"DY"
                               modelName:@"testModel"];
}

//归档测试
- (void)archiverTest {

    DYTestModel *model0 = [[DYTestModel alloc] init];
    model0.testStr = @"testStr0";
    
    DYTestModel *model = [[DYTestModel alloc] init];
    model.testStr = @"testStr";
    model.testArr = @[model0];
    model.testNumber = @(1/3.0);
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"cache001"];
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
    DYMakeModel *tmodel = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

}

//将model0 属性名相同的部分赋值给model1
- (void)assignmentModelTest {
    DYTestModel *model0 = [[DYTestModel alloc] init];
    model0.testStr = @"testStr0";
    model0.testNumber = @10;
    
    DYTest1Model *model1 = [[DYTest1Model alloc] init];
    model1.testStr = @"testStr1";
    
    [DYModelMaker assignmentModel:model0 toModel:model1];
}

//copy model0新生成一个model1
- (void)copyModelTest {
    DYTestModel *model0 = [[DYTestModel alloc] init];
    model0.testStr = @"testStr0";
    model0.testNumber = @10;
    
    DYTestModel *model1 = [DYModelMaker copyWithModel:model0];
}

//model0 和 model1 合并到model2
- (void)combineModelTest {
    DYTestModel *model0 = [[DYTestModel alloc] init];
    model0.testNumber = @10;
    
    DYTest1Model *model1 = [[DYTest1Model alloc] init];
    model1.testStr = @"testStr1";
    
    DYTest2Model *model2 = [[DYTest2Model alloc] init];
    [DYModelMaker combineModelWithModel1:model0 model2:model1 toModel:model2];

}

//判断两个Model的所有属性值是否相等
- (void)isEqualModelTest {
    DYTestModel *model0 = [[DYTestModel alloc] init];
    model0.testNumber = @10;
    model0.testStr = @"model0";
    
    DYTestModel *model1 = [[DYTestModel alloc] init];
    model1.testNumber = @11;
    model1.testStr = @"model1";
    
    DYTestModel *model2 = [[DYTestModel alloc] init];
    model2.testNumber = @10;
    model2.testStr = @"model0";
    
    NSLog(@"model0 %@ model1",[DYModelMaker isEqualModel1:model0 model2:model1]? @"等于" : @"不等于");
    NSLog(@"model0 %@ model2",[DYModelMaker isEqualModel1:model0 model2:model2]? @"等于" : @"不等于");
}

//初始化model中所有属性的值，已经有值的属性不受影响
- (void)initModelTest {
    DYTestModel *model = [[DYTestModel alloc] init];
    model.testNumber = @1;
    [DYModelMaker initWithModel:model];
    
    DYTestModel *model1 = [[DYTestModel alloc] init];
    model1.testNumber = @1;
    [DYModelMaker initAllPropertyWithModel:model1];
    
}
@end

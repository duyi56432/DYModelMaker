//
//  ViewController.m
//  DYModelMaker
//
//  Created by 杜燚 on 17/3/1.
//  Copyright © 2017年 shuodakeji. All rights reserved.
//

#import "ViewController.h"
//#import "DYModelMaker.h"
#import "MJExtension.h"
#import "NSObject+DYModelMaker.h"
#import "DYTestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    
    [NSObject DY_makeModelWithDictionary:dic modelKeyword:@"DY" modelName:@"testModel"  makeType:DYModelMakerTypeMJ];
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
    NSLog(@"%@",[tmodel mj_JSONString]);
}

//将model0 属性名相同的部分赋值给model1
- (void)assignmentModelTest {
    DYTestModel *model0 = [[DYTestModel alloc] init];
    model0.testStr = @"testStr0";
    model0.testNumber = @10;
    
    DYTest1Model *model1 = [[DYTest1Model alloc] init];
    model1.testStr = @"testStr1";
    
    [NSObject assignmentModel:model0 toModel:model1];
    NSLog(@"%@",[model1 mj_JSONString]);
}

//copy model0新生成一个model1
- (void)copyModelTest {
    DYTestModel *model0 = [[DYTestModel alloc] init];
    model0.testStr = @"testStr0";
    model0.testNumber = @10;
    
    DYTestModel *model1 = [NSObject copyWithModel:model0];
    NSLog(@"%@",[model1 mj_JSONString]);
}

//model0 和 model1 合并到model2
- (void)combineModelTest {
    DYTestModel *model0 = [[DYTestModel alloc] init];
    model0.testNumber = @10;
    
    DYTest1Model *model1 = [[DYTest1Model alloc] init];
    model1.testStr = @"testStr1";
    
    DYTest2Model *model2 = [[DYTest2Model alloc] init];
    [NSObject combineModelWithModel1:model0 model2:model1 toModel:model2];
    NSLog(@"%@",[model2 mj_JSONString]);
}
@end

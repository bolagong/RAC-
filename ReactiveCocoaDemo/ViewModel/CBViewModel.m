//
//  CBViewModel.m
//  MVVM_Demo
//
//  Created by c on 2019/7/31.
//  Copyright © 2019 CB. All rights reserved.
//

#import "CBViewModel.h"
#import "CBModel.h"

@interface CBViewModel ()

@property (nonatomic,strong) CBModel *aModel;

@end


@implementation CBViewModel


- (void)getModelDataAction {
    
    // 模拟请求数据
    [self setupRequestCommand];
    
    NSDictionary *infoDict = @{@"title":@"xxxx", @"name":@"xxx", @"sex":@"xx", @"age":@"xx"};
    self.messageDict = @{@"data":infoDict, @"code":@"1", @"message":@""};
}

- (void)setupRequestCommand {
    @weakify(self)
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        // 这里模拟请求登录
        return [self requestData];
    }];
    
    // 正在执行中
    [[self.requestCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        if (x.integerValue == 1) {
            self.indicatorHidden = x;
        }else {
            // 信号结束
            self.indicatorHidden = x;
        }
    }];
    
    // 最后一条信号
    [[self.requestCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.messageDict = x;
        });
    }];
    
    // 错误信号
    [self.requestCommand.errors subscribeNext:^(NSError * _Nullable x) {
        //@strongify(self)
        NSLog(@"失败");
    }];
}

- (RACSignal *)requestData {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:1.6];
            NSDictionary *infoDict = nil;
            NSInteger random = arc4random_uniform(4); // 0-3
            if (random == 0) {
                infoDict = @{@"title":@"个人信息", @"name":@"张大豪", @"sex":@"男", @"age":@"19"};
            }else if (random == 1) {
                infoDict = @{@"title":@"个人信息", @"name":@"糖衣炮弹", @"sex":@"女", @"age":@"23"};
            }else if (random == 2) {
                infoDict = @{@"title":@"个人信息", @"name":@"威武", @"sex":@"男", @"age":@"26"};
            }else if (random == 3) {
                infoDict = @{@"title":@"个人信息", @"name":@"赵灵儿", @"sex":@"女", @"age":@"20"};
            }
            NSDictionary *dataDict = @{@"data":infoDict, @"code":@"1", @"message":@""};
            [subscriber sendNext:dataDict];
            [subscriber sendCompleted];
            
            //[subscriber sendError:(nullable NSError *)]
        });
        return nil;
    }];
    return signal;
}


- (void)loadDataAction {
    // 执行信号
    [self.requestCommand execute:@"请求数据"];
}



@end

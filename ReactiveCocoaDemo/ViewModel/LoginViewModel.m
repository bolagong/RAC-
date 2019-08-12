//
//  LoginViewModel.m
//  ReactiveCocoaDemo
//
//  Created by changbo on 2019/8/8.
//  Copyright © 2019 CB. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (void)dealloc {
    NSLog(@"---LoginViewModel--dealloc---");
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        
        // 账号-头像绑定
        // skip:1 跳过第一次
        // map: 映射
        // distinctUntilChanged: 避免重复发送相同信号
        RAC(self, iconUrlStr) = [[[RACObserve(self, accountStr) skip:1] map:^id _Nullable(id  _Nullable value) {
            //通过映射 获取到x后，可以 进行处理后 再发送信号，比如给图片的名字前面统一加pic前缀
            //通过映射 获取到x后，可以 进行处理后 再发送信号，比如给图片的名字前面统一加pic前缀
            
            return [NSString stringWithFormat:@"pic%@",value];
        }] distinctUntilChanged];
        
        
        
        // 判断登录按钮的高亮是否可点击 信号
        // 组合信号 combineLatest
        NSArray *combineArr = @[RACObserve(self, accountStr), RACObserve(self, passwordStr)];
        self.loginEnableSignal = [RACSignal combineLatest:combineArr reduce:^(NSString *account, NSString *password) {
            
            return @(account.length>0 && password.length>0);
        }];
        
        
        // 登录状态文字的信号
        self.loginStatusSubject = [RACSubject subject];
        self.isLogin = @(0);
        
        // 登录请求逻辑
        [self setupLoginCommand];
        
        
        
    }
    return self;
}


// 登录请求逻辑
- (void)setupLoginCommand {
    @weakify(self)
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self)
        // 这里模拟请求登录
        return [self loginRequestData];
    }];
    
    // 正在执行中
    [[self.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        if (x.integerValue == 1) {
            self.indicatorHidden = x;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.loginStatusSubject sendNext:@"正在登录中..."];
            });
            
        }else {
            // 信号结束
            self.indicatorHidden = x;
        }
    }];
    
    // 最后一条信号
    [[self.loginCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"登录成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loginStatusSubject sendNext:@"登录成功"];
            self.isLogin = @(1);
        });
    }];
    
    // 错误信号
    [self.loginCommand.errors subscribeNext:^(NSError * _Nullable x) {
        @strongify(self)
        NSLog(@"登录失败");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loginStatusSubject sendNext:@"登录失败"];
            self.isLogin = @(0);
        });
    }];
}

- (RACSignal *)loginRequestData {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:3];
            if ([self.accountStr isEqualToString:@"01234"] && [self.passwordStr isEqualToString:@"01234"]) {
                [subscriber sendNext:@"登录成功"];
                [subscriber sendCompleted];
            }else {
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:400 userInfo:@{@"success":@"0",@"message":@"登录失败"}];
                [subscriber sendError:error];
            }
        });
        return nil;
    }];
    return signal;
}


@end

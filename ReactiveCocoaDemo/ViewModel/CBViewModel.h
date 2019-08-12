//
//  CBViewModel.h
//  MVVM_Demo
//
//  Created by c on 2019/7/31.
//  Copyright © 2019 CB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBViewModel : NSObject

// 命令 信号 模拟请求数据
@property (nonatomic,strong) RACCommand *requestCommand;

@property (nonatomic,strong) NSNumber *indicatorHidden;

@property (nonatomic,copy) NSDictionary *messageDict;


- (void)getModelDataAction;

- (void)loadDataAction;

@end

NS_ASSUME_NONNULL_END

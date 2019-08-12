//
//  LoginViewModel.h
//  ReactiveCocoaDemo
//
//  Created by changbo on 2019/8/8.
//  Copyright © 2019 CB. All rights reserved.
//  ViewModel理论上不应该出现 UIKit 相关的东西

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

// 图片的url
@property (nonatomic,copy) NSString *iconUrlStr;

// 账号
@property (nonatomic,copy) NSString *accountStr;

// 密码
@property (nonatomic,copy) NSString *passwordStr;

// 登录按钮是否开启 信号
@property (nonatomic,strong) RACSignal *loginEnableSignal;

// 登录 命令 信号，用来做请求数据
@property (nonatomic,strong) RACCommand *loginCommand;

// navigationBar显示登录的状态 信号
@property (nonatomic,strong) RACSubject *loginStatusSubject;

// 是否显示菊花 1显示，0隐藏
@property (nonatomic,strong) NSNumber *indicatorHidden;

// 是否登录成功 1成功，0失败
@property (nonatomic,strong) NSNumber *isLogin;


@end

NS_ASSUME_NONNULL_END

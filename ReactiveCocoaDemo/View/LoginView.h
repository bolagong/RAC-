//
//  LoginView.h
//  ReactiveCocoaDemo
//
//  Created by changbo on 2019/8/8.
//  Copyright © 2019 CB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView

@property (nonatomic,strong) UIImageView *headImageView;

@property (nonatomic,strong) UITextField *accountTextField;

@property (nonatomic,strong) UITextField *passwordTextField;

@property (nonatomic,strong) UIButton *loginButon;

@property (nonatomic,strong) LoginViewModel *loginVM;

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;


- (void)showConfigView:(LoginViewModel *)loginVM;

@end

NS_ASSUME_NONNULL_END

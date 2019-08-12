//
//  CBView.h
//  MVVM_Demo
//
//  Created by c on 2019/7/31.
//  Copyright © 2019 CB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBView : UIView

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) UILabel *sexLabel;

@property (nonatomic,strong) UILabel *ageLabel;

@property (nonatomic,strong) UIButton *sureBtn;

@property (nonatomic,strong) UILabel *successLabel;

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;


@property (nonatomic,strong) CBViewModel *aViemModel;

- (void)showView:(CBViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END

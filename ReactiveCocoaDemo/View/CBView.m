//
//  CBView.m
//  MVVM_Demo
//
//  Created by c on 2019/7/31.
//  Copyright © 2019 CB. All rights reserved.
//

#import "CBView.h"

@implementation CBView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        
        [self viewLayout];
    }
    return self;
}

- (void)viewLayout {
    CGSize mainSize = self.frame.size;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 80, mainSize.width-12*2, 30)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_titleLabel.frame)+30, 200, 30)];
    _nameLabel.font = [UIFont systemFontOfSize:16.0];
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
    
    _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_nameLabel.frame)+30, 100, 30)];
    _sexLabel.backgroundColor = [UIColor lightGrayColor];
    _sexLabel.font = [UIFont systemFontOfSize:16.0];
    _sexLabel.textColor = [UIColor whiteColor];
    [self addSubview:_sexLabel];
    
    _ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_sexLabel.frame)+30, 100, 30)];
    _ageLabel.backgroundColor = [UIColor lightGrayColor];
    _ageLabel.font = [UIFont systemFontOfSize:16.0];
    _ageLabel.textColor = [UIColor whiteColor];
    [self addSubview:_ageLabel];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(90, CGRectGetMaxY(_ageLabel.frame)+30, mainSize.width-90*2, 40);
    [_sureBtn setTitle:@"刷新数据" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(onPrintClick:) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn.layer.borderColor = [UIColor brownColor].CGColor;
    _sureBtn.layer.borderWidth = 1.0;
    _sureBtn.layer.cornerRadius = _sureBtn.frame.size.height/2.0;
    _sureBtn.layer.masksToBounds = YES;
    [self addSubview:_sureBtn];
    
    _successLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_sureBtn.frame)+50, mainSize.width-30*2, 40)];
    _successLabel.font = [UIFont boldSystemFontOfSize:16.0];
    _successLabel.textAlignment = NSTextAlignmentCenter;
    _successLabel.textColor = [UIColor blueColor];
    [self addSubview:_successLabel];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicatorView.frame = CGRectMake((CGRectGetWidth(self.frame)-50)/2.0, 200, 50, 50);
    _indicatorView.color = [UIColor cyanColor];
    _indicatorView.layer.cornerRadius = 4.0;
    _indicatorView.layer.masksToBounds = YES;
    _indicatorView.hidesWhenStopped = YES;
    [self addSubview:_indicatorView];
}

- (void)onPrintClick:(UIButton *)sender {
    [self.aViemModel loadDataAction];
}


- (void)showView:(CBViewModel *)viewModel {
    
    self.aViemModel = viewModel;
    
    @weakify(self)
    [RACObserve(self.aViemModel, messageDict) subscribeNext:^(NSDictionary * x) {
        @strongify(self);
        if (x && [x isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDict = [x objectForKey:@"data"];
            if (dataDict && [dataDict isKindOfClass:[NSDictionary class]]) {
                self.titleLabel.text = [dataDict objectForKey:@"title"];
                self.nameLabel.text = [NSString stringWithFormat:@"名字: %@",[dataDict objectForKey:@"name"]];
                self.sexLabel.text = [NSString stringWithFormat:@"性别: %@",[dataDict objectForKey:@"sex"]];
                self.ageLabel.text = [NSString stringWithFormat:@"年龄: %@",[dataDict objectForKey:@"age"]];
                //self.successLabel.text = [dataDict objectForKey:@"age"];
            }
        }
    }];
    
    // 监听 加载菊花 是否显示
    [[RACObserve(self.aViemModel, indicatorHidden) skip:1] subscribeNext:^(NSNumber * x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (x.integerValue == 0) {
                [self.indicatorView stopAnimating];
            }else {
                [self.indicatorView startAnimating];
            }
        });
    }];
}



@end

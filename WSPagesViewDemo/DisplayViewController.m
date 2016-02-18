//
//  DisplayViewController.m
//  WSPagesViewDemo
//
//  Created by shenma on 2/18/16.
//  Copyright © 2016 shenma. All rights reserved.
//

#import "DisplayViewController.h"
#import "Masonry.h"

@implementation DisplayViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    UILabel *topView = [[UILabel alloc] initWithFrame:CGRectZero];
    topView.text = @"Top View";
    topView.backgroundColor = [UIColor greenColor];
    
    //    CGRectMake(0.0, self.view.frame.size.height - 40.0f, 100.0f, 40.0f)
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40.f);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(10.0);
    }];
    
    UILabel *bottomView = [[UILabel alloc] initWithFrame:CGRectZero];
    bottomView.text = @"Bottom View";
    bottomView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40.f);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10.0);
    }];
    //    bottomView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    
    
    
}

@end

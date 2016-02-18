//
//  WSPagesViewTopBar.h
//  WSlideViewDemo
//
//  Created by shenma on 2/18/16.
//  Copyright © 2016 shenma. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSPagesViewTopBarDelegate;

@interface WSPagesViewTopBar : UIView<UIScrollViewDelegate>
{
    
}

@property (nonatomic, weak)  id<WSPagesViewTopBarDelegate> topBarDelegate;

//正常颜色
@property (nonatomic, strong) UIColor *tabItemNormalColor;
//选中颜色
@property (nonatomic, strong) UIColor *tabItemSelectedColor;

@property(nonatomic, assign) NSInteger selectedIndex;

-(void)buildUI;

@end

@protocol WSPagesViewTopBarDelegate <NSObject>

@required

//顶部tab个数
- (NSUInteger)numberOfTab:(WSPagesViewTopBar *)view;

//每个tab所属的所展示的对象
- (NSObject *)slideSwitchView:(WSPagesViewTopBar *)view viewOfTab:(NSUInteger)number;

@optional

//选中后触发事件
- (void)slideSwitchView:(WSPagesViewTopBar *)view didselectTab:(NSUInteger)number;

@end


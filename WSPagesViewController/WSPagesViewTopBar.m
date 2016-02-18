//
//  WSPagesViewTopBar.m
//  WSlideViewDemo
//
//  Created by shenma on 2/18/16.
//  Copyright © 2016 shenma. All rights reserved.
//

#import "WSPagesViewTopBar.h"

static const CGFloat kWidthOfButtonMargin = 10.0f;
static const CGFloat kFontSizeOfSelectedTabButton = 17.0f;
static const CGFloat kButtonOfDeltaTag = 100;

@interface WSPagesViewTopBar ()

@property (nonatomic, assign) NSInteger userSelectedChannelID;

@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) UIImageView *shadowImageView; //选中阴影

@end

@implementation WSPagesViewTopBar

#pragma mark - Initialization

- (void)setUp
{    self.userSelectedChannelID = kButtonOfDeltaTag;
    _viewArray = [[NSMutableArray alloc] init];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}


#pragma mark - 创建控件
/**
 *  创建子视图
 */
- (void)buildUI
{
    NSUInteger number = [self.topBarDelegate numberOfTab:self];
    
    for (int i=0; i<number; i++) {
        NSObject *obj = [self.topBarDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:obj];
    }
    
    [self createNameButtons];
    //默认选中0
    self.selectedIndex = 0;
    
}

/**
 *  初始化顶部tab的各个按钮
 */
- (void)createNameButtons
{
    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = kWidthOfButtonMargin;
    //每个tab偏移量
    CGFloat xOffset = kWidthOfButtonMargin;
    
    CGFloat eqButtonWidth = 0.0f;
    if ([_viewArray count] > 0) {
        eqButtonWidth = (self.bounds.size.width - kWidthOfButtonMargin * ([_viewArray count] + 1)) / [_viewArray count];
    }
    
    for (int i = 0; i < [_viewArray count]; i++) {
        NSString *title = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //累计每个tab文字的长度
        topScrollViewContentWidth += kWidthOfButtonMargin + eqButtonWidth;
        //设置按钮尺寸
        [button setFrame:CGRectMake(xOffset,0,
                                    eqButtonWidth, self.bounds.size.height)];
        
        //计算下一个tab的x偏移量
        xOffset += eqButtonWidth + kWidthOfButtonMargin;
        
        [button setTag:i + kButtonOfDeltaTag];
        
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.backgroundColor = [UIColor clearColor];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfSelectedTabButton];
        [button addTarget:self action:@selector(titleButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    self.shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidthOfButtonMargin, 0, eqButtonWidth, CGRectGetHeight(self.bounds))];
    [self.shadowImageView setImage:[UIImage imageNamed:@"red_line_and_shadow.png"]];
    [self addSubview:self.shadowImageView];
    
}

#pragma mark * Overwritten setters

-(NSInteger)selectedIndex {
    
    return self.userSelectedChannelID - kButtonOfDeltaTag;
}

/**
 *  手动触发选中
 *
 *  @param index 新索引
 */
- (void)setSelectedIndex:(NSInteger)index
{
    NSInteger tag = index + kButtonOfDeltaTag;
    UIButton *button = (UIButton *)[self viewWithTag:tag];
    if (button) {
        [self selectNameButton:button needCallBack:NO];
    }
}

#pragma mark - Privates
/**
 *  选中一个按钮
 *
 *  @param sender   按钮
 *  @param callBack 是否触发选中回调
 */
- (void)selectNameButton:(UIButton *)sender needCallBack:(BOOL)callBack
{
    //如果更换按钮
    if (sender.tag != self.userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self viewWithTag:self.userSelectedChannelID];
        lastButton.selected = NO;
        
        //赋值按钮ID
        self.userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [self slideTabBg:sender];
        
        if (callBack && self.topBarDelegate && [self.topBarDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
            [self.topBarDelegate slideSwitchView:self didselectTab:self.userSelectedChannelID - kButtonOfDeltaTag];
        }
    }
    //重复点击选中按钮
    else {
        
    }
}

-(void)titleButtonClickHandler:(UIButton *)sender
{
    [self selectNameButton:sender needCallBack:YES];
}

//切换滑块位置
- (void)slideTabBg:(UIButton *)btn {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationDelegate:self];
    CGRect btnCGRect = btn.frame;
    
    self.shadowImageView.frame = btnCGRect;
    
    [UIView commitAnimations];
    
}

-(void)dealloc
{
    self.topBarDelegate = nil;
}

@end




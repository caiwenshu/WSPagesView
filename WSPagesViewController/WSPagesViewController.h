//
//  WSPagesViewController.h
//  WSlideViewDemo
//
//  Created by shenma on 2/18/16.
//  Copyright © 2016 shenma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSPagesViewController : UIViewController

//------Content Views------
@property (nonatomic,strong ) NSMutableArray     *viewControllers;

//-------Scroll Enabled-----
@property(nonatomic, assign) BOOL disabledScroll; //禁止滚动.默认可滚动

/**
 A hight of the top bar. This is 40. by default.
 */
@property (assign, nonatomic) NSUInteger topBarHeight;

- (id)initWithViewControllers:(NSArray *)viewControllers;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;

//滚动到对应页面的回调
- (void)scrollToViewController:(id)viewController index:(NSUInteger)index;

- (void)scrollViewWillBeginDraggingWithViewController;

@end

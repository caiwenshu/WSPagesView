//
//  WSPagesViewController.m
//  WSlideViewDemo
//
//  Created by shenma on 2/18/16.
//  Copyright © 2016 shenma. All rights reserved.
//

#import "WSPagesViewController.h"
#import "WSPagesViewTopBar.h"

@interface WSPagesViewController ()<UIScrollViewDelegate,WSPagesViewTopBarDelegate>

//------Views------
@property (nonatomic, strong) WSPagesViewTopBar   *slideViewTopBar;
@property (nonatomic,strong ) UIScrollView       *scrollView;

//当前visible 子类controller
@property (nonatomic, strong) UIViewController *currentChildController;

@end

@implementation WSPagesViewController

#pragma mark - Initialization


- (id)initWithViewControllers:(NSArray *)viewControllers{
    self = [super init];
    if (self) {
        [self setUp];
        self.viewControllers = [NSMutableArray arrayWithArray:viewControllers];
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.topBarHeight = 44.;
}

-(void)setUpScrollViewWithCount:(NSInteger)count
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, self.topBarHeight, CGRectGetWidth(self.view.bounds), self.scrollHeight)];
    
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = !self.disabledScroll;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.scrollView.layer.shadowOffset = CGSizeMake(0, 0);
    self.scrollView.layer.shadowOpacity = 0.5;
    self.scrollView.layer.shadowRadius = 1;
    self.scrollView.scrollsToTop = NO;
    
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * count, self.scrollView.bounds.size.height);
}

- (void)setupWSlideSwitchView
{
    
    self.slideViewTopBar = [[WSPagesViewTopBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.bounds), self.topBarHeight)];
    self.slideViewTopBar.backgroundColor = [UIColor yellowColor];
    
    self.slideViewTopBar.topBarDelegate = self;
    self.slideViewTopBar.tabItemNormalColor   = [UIColor blackColor];
    self.slideViewTopBar.tabItemSelectedColor = [UIColor redColor];
    [self.view addSubview:self.slideViewTopBar];
    
}


#pragma mark - View life cycle
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self layoutSubviews];
    
    UIViewController *vc = [self.viewControllers objectAtIndex:self.slideViewTopBar.selectedIndex];
    [vc viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIViewController *vc = [self.viewControllers objectAtIndex:self.slideViewTopBar.selectedIndex];
    [vc viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark - Public
- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated {
    
    if (self.slideViewTopBar == nil || self.viewControllers == nil) {
        return;
    }
    
    self.slideViewTopBar.selectedIndex = index;
    
    //把当前index的页面显示出来，避免同时加载造成的卡顿
    [self loadCurrentViewWithIndex:self.slideViewTopBar.selectedIndex];
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.bounds) * index, 0) animated:animated];
}

- (void)setViewControllers:(NSMutableArray *)vControllers
{
    if (_viewControllers != vControllers) {
        _viewControllers = vControllers;
        
        NSUInteger count = 0;
        if (vControllers && vControllers.count > 0) {
            count = vControllers.count;
        }
        
        // Do any additional setup after loading the view.
        [self setUpScrollViewWithCount:count];
        
        //特殊处理,需要在segmentcontrol外 包一层view。
        //让badge出现在包这层上
        [self setupWSlideSwitchView];
        
        [self.slideViewTopBar buildUI];
        
        //把当前index的页面显示出来，避免同时加载造成的卡顿
        [self loadCurrentViewWithIndex:self.slideViewTopBar.selectedIndex];
    }
}

#pragma mark - WSlideTopViewDelegate
- (NSUInteger)numberOfTab:(WSPagesViewTopBar *)view
{
    NSArray *titleArray = [self obtainTitlesInViewController];
    
    return  [titleArray count];
}


- (NSObject *)slideSwitchView:(WSPagesViewTopBar *)view viewOfTab:(NSUInteger)number
{
    NSArray *titleArray = [self obtainTitlesInViewController];
    
    return  [titleArray objectAtIndex:number];
}

- (void)slideSwitchView:(WSPagesViewTopBar *)view didselectTab:(NSUInteger)selectIndex
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * selectIndex, 0) animated:!self.disabledScroll];
    [self loadCurrentViewWithIndex:selectIndex];
    
    UIViewController *vc = [self.viewControllers objectAtIndex:selectIndex];
    [self scrollToViewController:vc index:selectIndex];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self scrollViewWillBeginDraggingWithViewController];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    
    CGFloat targetIndex = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    
    self.slideViewTopBar.selectedIndex = targetIndex;
    [self loadCurrentViewWithIndex:targetIndex];
    
    UIViewController *vc = [self.viewControllers objectAtIndex:targetIndex];
    [self scrollToViewController:vc index:targetIndex];
}



#pragma mark - 子类调用
- (void)scrollToViewController:(id)viewController index:(NSUInteger)index{
    
}

- (void)scrollViewWillBeginDraggingWithViewController {
    
}

#pragma mark - Privates

- (void)layoutSubviews
{
    NSUInteger count = 0;
    if (self.viewControllers && self.viewControllers.count > 0) {
        count = self.viewControllers.count;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * count, self.scrollView.bounds.size.height);
}

/**
 *  获取标题集合
 *
 *  @return 标题
 */
-(NSMutableArray *)obtainTitlesInViewController
{
    NSMutableArray *titleArray = [NSMutableArray array];
    for (int i = 0 ; i < [self.viewControllers count] ; i ++) {
        UIViewController *viewController = [self.viewControllers objectAtIndex:i];
        if ([viewController.title isEqualToString:@""] || !viewController.title) {
            [titleArray addObject:@""];
        }else{
            [titleArray addObject:[NSString stringWithFormat:@"%@",viewController.title]];
        }
    }
    
    return titleArray;
}

//通过索引加载当前页面
- (void)loadCurrentViewWithIndex:(NSUInteger)index{
    
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    
    //如果当前页面还没有加载到view中，则加载页面
    if (![self.childViewControllers containsObject:viewController]) {
        UIViewController *vc = [self.viewControllers objectAtIndex:index];
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(self.scrollWidth * index, 0.0f,self.scrollWidth, self.scrollHeight);
        [self.scrollView addSubview:vc.view];
        
    }
    
    self.currentChildController = viewController;
    //    [self layoutSubviews];
    
    //    [viewController viewDidAppear:YES];
}

- (CGFloat)scrollHeight
{
    return CGRectGetHeight(self.view.frame) - self.topBarHeight;
}

- (CGFloat)scrollWidth
{
    return CGRectGetWidth(self.scrollView.bounds);
}


#pragma mark - Memory Manager
- (void)dealloc{
    //    self.viewControllers = nil;
    self.scrollView.delegate = nil;
    [self.scrollView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  WSPagesViewDemo
//
//  Created by shenma on 2/18/16.
//  Copyright © 2016 shenma. All rights reserved.
//

#import "ViewController.h"
#import "DisplayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DisplayViewController *mainView = [[DisplayViewController alloc] init];
    
    mainView.title = @"TAB1";
    mainView.view.backgroundColor = [UIColor brownColor];
    
    DisplayViewController *allFirendsView = [[DisplayViewController alloc] init];
    allFirendsView.view.backgroundColor = [UIColor yellowColor];
    allFirendsView.title = @"TAB2";
    
    DisplayViewController *industryVC = [[DisplayViewController alloc] init];
    industryVC.title = @"TAB3";
    industryVC.view.backgroundColor = [UIColor brownColor];
    self.viewControllers = [NSMutableArray arrayWithArray:@[mainView, allFirendsView, industryVC]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

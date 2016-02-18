//
//  AppDelegate.m
//  WSPagesViewDemo
//
//  Created by shenma on 2/18/16.
//  Copyright © 2016 shenma. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // bug fix for switch view in category background for black.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [self InitializationTabbar];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (UITabBarController *)InitializationTabbar {
    
    //首页
    UINavigationController* tranbController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    tranbController.navigationBarHidden = YES;
    UITabBarItem *tranbTabbar = [[UITabBarItem alloc] initWithTitle:@"bottom4"
                                                              image:nil
                                                      selectedImage:nil];

    
    tranbController.tabBarItem = tranbTabbar;
    
    
    //人脉
    UINavigationController* peopleController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    
    UITabBarItem *peopleTabbar = [[UITabBarItem alloc] initWithTitle:@"bottom1"
                                                               image:nil
                                                       selectedImage:nil];

    peopleController.tabBarItem = peopleTabbar;
    
    
    //我要买
    UINavigationController* functionController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] ;
    
    UITabBarItem *functionTabbar = [[UITabBarItem alloc] initWithTitle:@"bottom2"
                                                                 image:nil
                                                         selectedImage:nil];

    
    functionController.tabBarItem = functionTabbar;
    
    //我要卖
    UINavigationController *navIWantSale = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    UITabBarItem *iWantSaleTabbar = [[UITabBarItem alloc] initWithTitle:@"bottom3"
                                                                  image:nil
                                                          selectedImage:nil];

    navIWantSale.tabBarItem = iWantSaleTabbar;
    
    
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
    tabbarController.viewControllers = @[tranbController,
                                         peopleController,
                                         functionController,
                                         navIWantSale];
    
    tabbarController.tabBar.translucent = NO;
    return tabbarController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  AppDelegate.m
//  AutoLayoutExplained
//
//  Created by Lucas Smith on 10/15/14.
//  Copyright (c) 2014 Volan Studio, llc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *daysViewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:daysViewController];
    
    UINavigationBar *navigationBar = navigationController.navigationBar;
    navigationBar.barTintColor = [UIColor colorWithHue:0.0f/360.0f saturation:0.0f brightness:0.97f alpha:1.0f];
    navigationBar.barStyle = UIBarStyleDefault;
    
    self.window.rootViewController = navigationController;
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

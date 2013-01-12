//
//  LLAppDelegate.m
//  iOSInstalledApps
//
//  Created by Aravind Krishnaswamy on 02/09/12.
//  Copyright (c) 2012 Aravind Krishnaswamy. All rights reserved.
//

#import "LLAppDelegate.h"
#import "LLInstalledApps.h"

@implementation LLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    // Get list of running apps (process names)
    NSArray* processes = [LLInstalledApps runningApps];
    assert(processes);
    NSLog(@"Process List: %@", processes);
    
    // Pass in a few URL schemes to lookup
    NSArray* schemes = @[ @"tel:", @"sms:", @"mailto:",@"mailto:",@"fb:",@"twitter:",@"instagram"
    ];
    
    NSDictionary* dict = [LLInstalledApps appsInstalledWithSchemes:schemes];
    assert(dict);
    NSLog(@"Installed apps: %@", dict);

    dict = [LLInstalledApps appsInstalledWithSchemes:schemes withProgressCallback:^(id count) {
        NSLog(@"Progress: %@", count);
    }];
    assert(dict);
    NSLog(@"Installed apps: %@", dict);

    
    return YES;
}
							
@end

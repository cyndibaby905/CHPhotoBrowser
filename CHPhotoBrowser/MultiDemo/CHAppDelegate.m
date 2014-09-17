//
//  CHAppDelegate.m
//  MultiDemo
//
//  Created by hangchen on 9/15/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import "CHPhotoBrowserViewController.h"
#import "CHAppDelegate.h"

@implementation CHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSArray *remoteImages = @[@"http://mg.soupingguo.com/bizhi/big/10/273/104/10273104.jpg",
                              @"http://cdn.duitang.com/uploads/item/201310/10/20131010184344_wQhKC.jpeg",
                              @"http://cdn.duitang.com/uploads/item/201304/27/20130427014412_KU2jV.jpeg",
                              @"http://apple.xdnice.com/uploads/allimg/121009/10144S355-0.jpg",
                              @"http://apple.xdnice.com/uploads/allimg/121106/12233610J-0.jpg",
                              @"http://cdn.duitang.com/uploads/item/201306/24/20130624132605_eBKVA.jpeg",
                              @"http://img2.duitang.com/uploads/item/201304/27/20130427021414_YQE2w.jpeg",
                              @"http://img4.duitang.com/uploads/item/201304/27/20130427014742_aFFaw.jpeg",
                              @"http://cdn.duitang.com/uploads/item/201304/27/20130427012418_HehyL.jpeg",
                              @"http://apple.xdnice.com/uploads/allimg/121106/12204K313-0.jpg"];
        
    self.window.rootViewController = [[CHPhotoBrowserViewController alloc] initWithImages:remoteImages];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  CHAppDelegate.m
//  MultiDemo
//
//  Created by hangchen on 9/15/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import "CHPhotoBrowserViewController.h"
#import "CHAppDelegate.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation CHAppDelegate {
    ALAssetsLibrary *library_;
}

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
@end

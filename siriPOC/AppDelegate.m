//
//  AppDelegate.m
//  siriPOC
//
//  Created by Lefteris Karamolegkos on 15/04/2019.
//  Copyright © 2019 Lefteris Karamolegkos. All rights reserved.
//

#import "AppDelegate.h"
#import <Intents/Intents.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
        NSLog(@"Siri Authorization status...%ld", status);
    }];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {
    // Check to make sure it's the correct activity type
    if ([userActivity.activityType isEqualToString:@"gr.indice.POC.demo"])
    {
        // Extract the remote ID from the user info
        NSString* id = [userActivity.userInfo objectForKey:@"ID"];
        
        // Restore the remote screen...
        
        return YES;
    }
    return NO;
}


@end

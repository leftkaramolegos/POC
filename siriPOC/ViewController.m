//
//  ViewController.m
//  siriPOC
//
//  Created by Lefteris Karamolegkos on 15/04/2019.
//  Copyright © 2019 Lefteris Karamolegkos. All rights reserved.
//

#import "ViewController.h"
#import <Intents/Intents.h>
#import "TransferIntent.h"
#import "IntentHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 12.0, *)) {
        NSUserActivity* userActivity = [[NSUserActivity alloc] initWithActivityType:@"com.unified.UR.Remote"];
        userActivity.title = [NSString stringWithFormat:@"Open %@ Remote", @"transfer"];
        userActivity.eligibleForPrediction = YES;
        userActivity.userInfo = @{@"ID" : @"gr.indice.POC.sayhi"};
        userActivity.requiredUserInfoKeys = [NSSet setWithArray:userActivity.userInfo.allKeys];
        self.userActivity = userActivity; // Calls becomeCurrent/resignCurrent for us...
    }
}

- (IBAction)trigger:(id)sender {
    [self userTriggeredAnAction];
}

- (void)userTriggeredAnAction {
    // Constructor intent and set parameters
    // IMPORTANT: Parameters must match one of the shortcut types that you defined in the intents definition file. Otherwise the donation with fail.
    TransferIntent* intent = [[TransferIntent alloc] init];
//    intent.remote = self.remote.ID;
//    intent.remoteName = self.remote.name;
//    intent.action = action.name;
//    intent.actionName = [[action.name stringByReplacingOccurrencesOfString:@"_" withString:@" "] capitalizedString];
    intent.amount = @(50);
    intent.contactStr = @"Mom";
    
    
    // Set a suggested phrase (displayed when creating shortcuts)
    intent.suggestedInvocationPhrase = [NSString stringWithFormat:@"Left send %@ %@", intent.amount, intent.contactStr];

    // Donate the interaction shortcut
    INInteraction* interaction = [[INInteraction alloc] initWithIntent:intent response:nil];
//    [interaction initWithIntent:intent response:<#(nullable INIntentResponse *)#>
    [interaction donateInteractionWithCompletion:^(NSError * _Nullable error)
     {
//         [IntentHandler intent]
         if (error)
         {
             NSLog(@"Failed to donate interaction: %@ ", [error localizedDescription] );
         }
     }];
}

@end

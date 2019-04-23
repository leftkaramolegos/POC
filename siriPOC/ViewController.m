//
//  ViewController.m
//  siriPOC
//
//  Created by Lefteris Karamolegkos on 15/04/2019.
//  Copyright © 2019 Lefteris Karamolegkos. All rights reserved.
//

#import "ViewController.h"
#import <Intents/Intents.h>
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

    INSpeakableString* speakStr = [[INSpeakableString new] initWithSpokenPhrase:@"asd"];
    INBillPayee* bill = [[INBillPayee new] initWithNickname:speakStr number:@"7" organizationName:speakStr];
    INPaymentAccount* account = [[INPaymentAccount new] initWithNickname:speakStr number:@"7" accountType:INAccountTypeCredit organizationName:speakStr balance:nil secondaryBalance:nil];
    INCurrencyAmount *currencyAmt = [[INCurrencyAmount alloc] initWithAmount:[NSDecimalNumber decimalNumberWithString:@"100"] currencyCode:@"USD"];
    INPaymentAmount* paymentAmount = [[INPaymentAmount new] initWithAmountType:INAmountTypeAmountDue amount:currencyAmt];
    INPayBillIntent* intent = [[INPayBillIntent new] initWithBillPayee:bill fromAccount:account transactionAmount:paymentAmount transactionScheduledDate:nil transactionNote:@"" billType:INBillTypeGas dueDate:nil];
    
//
//    // Donate the interaction shortcut
    INInteraction* interaction = [[INInteraction alloc] initWithIntent:intent response:nil];
    [interaction donateInteractionWithCompletion:^(NSError * _Nullable error)
     {
         [[IntentHandler new] publicHandle];
         if (error)
         {
             NSLog(@"Failed to donate interaction: %@ ", [error localizedDescription] );
         }
     }];
}

@end

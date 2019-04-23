//
//  IntentHandler.h
//  Intents
//
//  Created by ΚΑΡΑΜΟΛΕΓΚΟΣ Γ. ΕΛΕΥΘΕΡΙΟΣ on 23/04/2019.
//  Copyright © 2019 Lefteris Karamolegkos. All rights reserved.
//

#import <Intents/Intents.h>
//#import "INTransferMoneyIntent.h"

@interface IntentHandler : INExtension <INPayBillIntentHandling>

- (void)publicHandle;

@end

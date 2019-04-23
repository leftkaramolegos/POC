//
//  IntentHandler.m
//  Intents
//
//  Created by ΚΑΡΑΜΟΛΕΓΚΟΣ Γ. ΕΛΕΥΘΕΡΙΟΣ on 23/04/2019.
//  Copyright © 2019 Lefteris Karamolegkos. All rights reserved.
//

#import "IntentHandler.h"

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self;
}

- (void)confirmPayBill:(INPayBillIntent *)intent
            completion:(void (^)(INPayBillIntentResponse *response))completion {
    NSLog(@"\n%s", __func__);
    INPayBillIntentResponse *response = [[INPayBillIntentResponse alloc] initWithCode:INPayBillIntentResponseCodeSuccess userActivity:nil];
    completion(response);
}

- (void)handlePayBill:(INPayBillIntent *)intent
           completion:(void (^)(INPayBillIntentResponse *response))completion {
    NSLog(@"\n%s", __func__);
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INPayBillIntent class])];
    
    INPayBillIntentResponse *response = [[INPayBillIntentResponse alloc] initWithCode:INPayBillIntentResponseCodeReady userActivity:userActivity];
    completion(response);
    
}

- (void)resolveBillPayeeForPayBill:(INPayBillIntent *)intent
                    withCompletion:(void (^)(INBillPayeeResolutionResult *resolutionResult))completion {
    NSLog(@"\n%s", __func__);
    
    INSpeakableString *speakableStr = [[INSpeakableString alloc] initWithIdentifier:@"XYZ Bill" spokenPhrase:@"XYZ Bill" pronunciationHint:@"XYZ Bill"];
    INSpeakableString *speakableStr1 = [[INSpeakableString alloc] initWithIdentifier:@"XYZ Bill Payments" spokenPhrase:@"XYZ Payments" pronunciationHint:@"XYZ Bills"];
    
    INBillPayee *billPayee = [[INBillPayee alloc] initWithNickname:speakableStr number:@"10112122112" organizationName:speakableStr1];
    
    INBillPayeeResolutionResult *finalResult = [INBillPayeeResolutionResult successWithResolvedBillPayee:billPayee];
    
    completion(finalResult);
}

- (void)resolveFromAccountForPayBill:(INPayBillIntent *)intent
                      withCompletion:(void (^)(INPaymentAccountResolutionResult *resolutionResult))completion {
    NSLog(@"\n%s", __func__);
    INSpeakableString *speakableStr2 = [[INSpeakableString alloc] initWithIdentifier:@"john.smith" spokenPhrase:@"john.smith" pronunciationHint:@"john.smith"];
    INSpeakableString *speakableStr3 = [[INSpeakableString alloc] initWithIdentifier:@"" spokenPhrase:@"" pronunciationHint:@"organisation"];
    
    INPaymentAccount *fromAccount = [[INPaymentAccount alloc] initWithNickname:speakableStr2 number:@"10112122112" accountType:INAccountTypeCredit organizationName:speakableStr3];
    
    
    INPaymentAccountResolutionResult *finalResult = [INPaymentAccountResolutionResult successWithResolvedPaymentAccount:fromAccount];
    
    completion(finalResult);
}

- (void)resolveTransactionAmountForPayBill:(INPayBillIntent *)intent
                            withCompletion:(void (^)(INPaymentAmountResolutionResult *resolutionResult))completion {
    NSLog(@"\n%s", __func__);
    
    INCurrencyAmount *currencyAmt = [[INCurrencyAmount alloc] initWithAmount:[NSDecimalNumber decimalNumberWithString:@"100"] currencyCode:@"USD"];
    
    INPaymentAmount *transactionAmt = [[INPaymentAmount alloc] initWithAmountType:INAmountTypeAmountDue amount:currencyAmt];
    
    INPaymentAmountResolutionResult *finalResult = [INPaymentAmountResolutionResult successWithResolvedPaymentAmount:transactionAmt];
    
    completion(finalResult);
    
}

- (void)resolveTransactionScheduledDateForPayBill:(INPayBillIntent *)intent
                                   withCompletion:(void (^)(INDateComponentsRangeResolutionResult *resolutionResult))completion {
    
    completion([INDateComponentsRangeResolutionResult notRequired]);
    
}

- (void)resolveTransactionNoteForPayBill:(INPayBillIntent *)intent
                          withCompletion:(void (^)(INStringResolutionResult *resolutionResult))completion {
    NSLog(@"\n%s", __func__);
    INStringResolutionResult *finalResult = [INStringResolutionResult successWithResolvedString:@"Bill Payment"];
    
    completion(finalResult);
}

- (void)resolveBillTypeForPayBill:(INPayBillIntent *)intent
                   withCompletion:(void (^)(INBillTypeResolutionResult *resolutionResult))completion {
    NSLog(@"\n%s", __func__);
    INBillTypeResolutionResult *finalResult = [INBillTypeResolutionResult successWithResolvedValue:INBillTypeElectricity];
    
    completion(finalResult);
    
}

- (void)resolveDueDateForPayBill:(INPayBillIntent *)intent
                  withCompletion:(void (^)(INDateComponentsRangeResolutionResult *resolutionResult))completion {
    NSLog(@"%s", __func__);
    completion([INDateComponentsRangeResolutionResult notRequired]);
}

- (void)publicHandle {
    INSpeakableString* speakStr = [[INSpeakableString new] initWithSpokenPhrase:@"asd"];
    INBillPayee* bill = [[INBillPayee new] initWithNickname:speakStr number:@"7" organizationName:speakStr];
    INPaymentAccount* account = [[INPaymentAccount new] initWithNickname:speakStr number:@"7" accountType:INAccountTypeCredit organizationName:speakStr balance:nil secondaryBalance:nil];
    INCurrencyAmount *currencyAmt = [[INCurrencyAmount alloc] initWithAmount:[NSDecimalNumber decimalNumberWithString:@"100"] currencyCode:@"USD"];
    INPaymentAmount* paymentAmount = [[INPaymentAmount new] initWithAmountType:INAmountTypeAmountDue amount:currencyAmt];
    INPayBillIntent* intent = [[INPayBillIntent new] initWithBillPayee:bill fromAccount:account transactionAmount:paymentAmount transactionScheduledDate:nil transactionNote:@"" billType:INBillTypeGas dueDate:nil];
    [self handlePayBill:intent completion:^(INPayBillIntentResponse * _Nonnull response) {
        int x = 0;
        x++;
    }];
}

@end

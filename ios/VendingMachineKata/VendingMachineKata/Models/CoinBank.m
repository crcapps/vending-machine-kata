//
//  CoinBank.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinBank.h"
#import "NSCountedSet+CoinValue.h"
#import "Notifications.h"
#import "CoinSlot.h"
#import "CoinData.h"

@implementation CoinBank

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _bankedCoins = [NSCountedSet new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sufficientCredit:) name:kNotificationItemSelectedSufficientCredit object:nil];
    }
    
    return self;
}

/*
 <SPOILER>
 We're going greedy!!!!
 There are a finite number of coins in the machine.
 QED: Don't worry about DynP.
 </SPOILER>
 */

- (BOOL)canMakeChangeForAmount:(NSDecimalNumber *)amount {
    BOOL canMakeChange = NO;
    if ([amount compare:[NSDecimalNumber zero]] == NSOrderedSame) {
        canMakeChange = YES;
    }
    if ([amount compare:self.bankedCoins.value] != NSOrderedDescending) {
        NSDecimalNumber *amountRemaining = amount;
        CoinData *coinData = nil;
        // One pass over coins for each coin type, largest denomination to smallest
        // Quarters
        NSEnumerator *allQuarters = [self.bankedCoins objectEnumerator];
        while (coinData = [allQuarters nextObject]) {
            while ([amountRemaining compare:[NSDecimalNumber decimalNumberWithDecimal:[@0.25 decimalValue]]] != NSOrderedAscending) {
                if (coinData.coinType == kCoinTypeQuarter) {
                    [amountRemaining decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue]];
                }
            }
        }
        // Dimes
        NSEnumerator *allDimes = [self.bankedCoins objectEnumerator];
        while (coinData = [allDimes nextObject]) {
            while ([amountRemaining compare:[NSDecimalNumber decimalNumberWithDecimal:[@0.10 decimalValue]]] != NSOrderedAscending) {
                if (coinData.coinType == kCoinTypeDime) {
                    [amountRemaining decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue]];
                }
            }
        }
        // Nickels
        NSEnumerator *allNickels = [self.bankedCoins objectEnumerator];
        while (coinData = [allNickels nextObject]) {
            while ([amountRemaining compare:[NSDecimalNumber decimalNumberWithDecimal:[@0.05 decimalValue]]] != NSOrderedAscending) {
                if (coinData.coinType == kCoinTypeNickel) {
                    [amountRemaining decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue]];
                }
            }
        }
        // Nothing should be leftover, since we don't accept pennies
        if ([amountRemaining compare:[NSDecimalNumber zero]]) {
            canMakeChange = YES;
        }
    }
    return canMakeChange;
}

- (void)sufficientCredit:(NSNotification *)notification {
    NSDecimalNumber *amount = [notification.userInfo objectForKey:kUserInfoKeyChange];
    BOOL canMakeChange = [self canMakeChangeForAmount:amount];
    NSString *notificationName = canMakeChange ? kNotificationCanMakeChangeForSelection : kNotificationCannotMakeChangeForSelection;
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:notification.userInfo];
}

- (void)makeChangeForAmount:(NSDecimalNumber *)amount {
    NSCountedSet *coinReturn = [CoinSlot sharedInstance].returnedCoins;
    NSDecimalNumber *amountRemaining = amount;
    if ([amountRemaining compare:[NSDecimalNumber zero]] != NSOrderedSame) {
        CoinData *coinData = nil;
        // One pass over coins for each coin type, largest denomination to smallest
        // Doing the same thing as when we check, but actually transferring the coinage now.
        // Quarters
        NSEnumerator *allQuarters = [self.bankedCoins objectEnumerator];
        while (coinData = [allQuarters nextObject]) {
            while ([amountRemaining compare:[NSDecimalNumber decimalNumberWithDecimal:[@0.25 decimalValue]]] != NSOrderedAscending) {
                if (coinData.coinType == kCoinTypeQuarter) {
                    [coinReturn addObject:coinData];
                    [amountRemaining decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue]];
                }
            }
        }
        // Dimes
        NSEnumerator *allDimes = [self.bankedCoins objectEnumerator];
        while (coinData = [allDimes nextObject]) {
            while ([amountRemaining compare:[NSDecimalNumber decimalNumberWithDecimal:[@0.10 decimalValue]]] != NSOrderedAscending) {
                if (coinData.coinType == kCoinTypeDime) {
                    [coinReturn addObject:coinData];
                    [amountRemaining decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue]];
                }
            }
        }
        // Nickels
        NSEnumerator *allNickels = [self.bankedCoins objectEnumerator];
        while (coinData = [allNickels nextObject]) {
            while ([amountRemaining compare:[NSDecimalNumber decimalNumberWithDecimal:[@0.05 decimalValue]]] != NSOrderedAscending) {
                if (coinData.coinType == kCoinTypeNickel) {
                    [coinReturn addObject:coinData];
                    [amountRemaining decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue]];
                }
            }
        }
        // Nothing should be leftover, since we don't accept pennies
        // Lets get these out of the bank since we don't have entangled coins.
        // They're only in one place at a time!
        NSEnumerator *returnedCoins = [coinReturn objectEnumerator];
        while (coinData = [returnedCoins nextObject]) {
            [self.bankedCoins removeObject:coinData];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

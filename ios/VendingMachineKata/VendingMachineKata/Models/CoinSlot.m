//
//  CoinSlot.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinSlot.h"
#import "CoinData.h"
#import "Notifications.h"
#import "NSCountedSet+CoinValue.h"
#import "Inventory.h"
#import "CoinBank.h"

@implementation CoinSlot

- (instancetype)init {
    self = [super init];
    if (self) {
        _insertedCoins= [NSCountedSet new];
        _returnedCoins = [NSCountedSet new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemWasSelected:) name:kNotificationItemSelected object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseWasCompleted:) name:kNotificationPurchaseCompleted object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDispensed:) name:kNotificationChangeDispensed object:nil];
    }
    
    return self;
}

- (void)dropCoinWithDiameter:(NSNumber *)diameter mass:(NSNumber *)mass thickness:(NSNumber *)thickness {
    CoinData *coinData = [CoinData identifyCoinForDiameter:diameter mass:mass thickness:thickness];
    if (coinData.isAccepted) {
        [self.insertedCoins addObject:coinData];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCoinAccepted object:self userInfo:@{@"text":self.insertedCoins.valueText}];
    } else {
        [self.returnedCoins addObject:coinData];
    }
}

- (void)itemWasSelected:(NSNotification *)notification {
    NSDecimalNumber *price = [notification.userInfo valueForKey:kUserInfoKeyPrice];
    NSNumber *item = [notification.userInfo valueForKey:kUserInfoKeyItem];
    NSComparisonResult compare = [price compare:self.insertedCoins.value];
    if (compare == NSOrderedDescending) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kNotificationItemSelectedInsufficientCredit
         object:self userInfo:@{
                                kUserInfoKeyPrice : price,
                                kUserInfoKeyCredit : self.insertedCoins.value,
                                kUserInfoKeyItem : item
                                }];
    } else {
        NSDecimalNumber *change = [self.insertedCoins.value decimalNumberBySubtracting:price];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kNotificationItemSelectedSufficientCredit
         object:self userInfo:@{
                                kUserInfoKeyPrice : price,
                                kUserInfoKeyCredit : self.insertedCoins.value,
                                kUserInfoKeyItem : item,
                                kUserInfoKeyChange : change,
                                kUserInfoKeyCoins : self.insertedCoins
                                }];
    }
}

- (void)purchaseWasCompleted:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kNotificationBankCoinsAndMakeChange object:self userInfo:notification.userInfo];
    _insertedCoins = [NSCountedSet new];
}

- (void)changeDispensed:(NSNotification *)notification {
    NSCountedSet *change = [notification.userInfo objectForKey:kUserInfoKeyCoins];
    for (NSObject *object in change) {
        [self.returnedCoins addObject:object];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

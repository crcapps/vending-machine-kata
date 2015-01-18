//
//  CoinSlot.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinSlot.h"
#import "CoinBag.h"
#import "CoinData.h"
#import "Notifications.h"

@implementation CoinSlot

- (instancetype)init {
    self = [super init];
    if (self) {
        _insertedCoins= [CoinBag new];
        _returnedCoins = [CoinBag new];
    }
    
    return self;
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemWasSelected:) name:kNotificationItemSelected object:nil];
}

- (void)dropCoinWithDiameter:(NSNumber *)diameter mass:(NSNumber *)mass thickness:(NSNumber *)thickness {
    CoinData *coinData = [CoinData identifyCoinForDiameter:diameter mass:mass thickness:thickness];
    if (coinData.isAccepted) {
        [self.insertedCoins addCoin:coinData amount:1];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kNotificationCoinAccepted
         object:self userInfo:@{kUserInfoKeyCredit : self.insertedCoins.value}];
    } else if (coinData.coinType != kCoinTypeSlug) {
        [self.returnedCoins addCoin:coinData amount:1];
    }
}

#pragma mark - Notification Handlers

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
                                kUserInfoKeyItem : item,
                                kUserInfoKeyQuantity : [notification.userInfo objectForKey:kUserInfoKeyQuantity]
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
                                kUserInfoKeyCoins : self.insertedCoins,
                                kUserInfoKeyQuantity : [notification.userInfo objectForKey:kUserInfoKeyQuantity]
                                }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

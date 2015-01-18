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

- (void)dropCoinWithDiameter:(NSNumber *)diameter mass:(NSNumber *)mass thickness:(NSNumber *)thickness {
    CoinData *coinData = [CoinData identifyCoinForDiameter:diameter mass:mass thickness:thickness];
    if (coinData.isAccepted) {
        [self.insertedCoins addCoin:coinData amount:1];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kNotificationCoinAccepted
         object:self userInfo:@{
                                kUserInfoKeyText:self.insertedCoins.localizedValueString,
                                kUserInfoKeyCredit : self.insertedCoins.value
                                }];
    } else if (coinData.coinType != kCoinTypeSlug) {
        [self.returnedCoins addCoin:coinData amount:1];
    }
}

@end

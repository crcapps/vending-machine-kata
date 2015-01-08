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

@implementation CoinSlot

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _insertedCoins= [NSCountedSet new];
        _returnedCoins = [NSCountedSet new];
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

@end

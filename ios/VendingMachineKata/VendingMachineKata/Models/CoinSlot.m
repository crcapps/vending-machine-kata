//
//  CoinSlot.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinSlot.h"
#import "CoinData.h"

@implementation CoinSlot

- (instancetype)init {
    self = [super init];
    if (self) {
        _insertedCoins = [NSCountedSet new];
        _returnedCoins = [NSCountedSet new];
    }
    
    return self;
}

- (void)dropCoinWithDiameter:(NSNumber *)diameter Mass:(NSNumber *)mass Thickness:(NSNumber *)thickness {
    CoinData *coinData = [CoinData identifyCoinForDiameter:diameter Mass:mass Thickness:thickness];
    if (coinData.isAccepted) {
        [self.insertedCoins addObject:coinData];
    } else {
        [self.returnedCoins addObject:coinData];
    }
}

- (NSDecimalNumber *)insertedCoinsValue {
    NSDecimalNumber *totalValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    for (CoinData *coinData in self.insertedCoins) {
        NSDecimalNumber *new = [NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue];
        totalValue = [totalValue decimalNumberByAdding:new];
    }
    return totalValue;
}

@end

//
//  CoinSlot.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinSlot.h"
#import "CoinRecognizer.h"
#import "CoinData.h"

@implementation CoinSlot

- (instancetype)init {
    self = [super init];
    if (self) {
        _insertedCoins = [NSCountedSet new];
    }
    
    return self;
}

- (NSDecimalNumber *)dropCoinWithDiameter:(NSNumber *)diameter Mass:(NSNumber *)mass Thickness:(NSNumber *)thickness {
    CoinData *coinData = [CoinRecognizer identifyCoinForDiameter:diameter Mass:mass Thickness:thickness];
    [self.insertedCoins addObject:coinData];
    return [NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue];
}

- (NSDecimalNumber *)currentTotalValue {
    NSDecimalNumber *totalValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    for (CoinData *coinData in self.insertedCoins) {;
        NSDecimalNumber *new = [NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue];
        totalValue = [totalValue decimalNumberByAdding:new];
    }
    return totalValue;
}

@end

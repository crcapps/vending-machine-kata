//
//  CoinSlot.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinSlot.h"
#import "CoinRecognizer.h"

@implementation CoinSlot

- (NSDecimalNumber *)dropCoinWithDiameter:(NSNumber *)diameter Mass:(NSNumber *)mass Thickness:(NSNumber *)thickness {
    CoinData coinData = [CoinRecognizer identifyCoinForDiameter:diameter Mass:mass Thickness:thickness];
    return [NSDecimalNumber decimalNumberWithDecimal:coinData.coinValue];
}

@end

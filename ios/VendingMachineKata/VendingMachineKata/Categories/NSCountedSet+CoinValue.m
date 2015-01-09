//
//  NSCountedSet+CoinValue.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "NSCountedSet+CoinValue.h"
#import "CoinData.h"

@implementation NSCountedSet (CoinValue)

- (NSDecimalNumber *)value {
    NSDecimalNumber *totalValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    for (NSObject *object in self) {
        if ([object isKindOfClass:[CoinData class]]) {
            NSDecimalNumber *new = [NSDecimalNumber decimalNumberWithDecimal:((CoinData *)object).coinValue];
            totalValue = [totalValue decimalNumberByAdding:new];
        }
    }
    return totalValue;
}

- (NSString *)valueText {
    return [NSNumberFormatter localizedStringFromNumber:self.value numberStyle:NSNumberFormatterCurrencyStyle];
}

- (NSInteger)coins {
    NSInteger totalCount = 0;
    for (NSObject *object in self) {
        if ([object isKindOfClass:[CoinData class]]) {
            totalCount++;
        }
    }
    return totalCount;
}

- (void)empty {
    NSCountedSet *tempBag = [NSCountedSet new];
    for (NSObject *object in self) {
        [tempBag addObject:object];
    }
    for (NSObject *object in tempBag) {
        [self removeObject:object];
    }
}

- (void)emptyInto:(NSCountedSet *)bag {
    for (NSObject *object in self) {
        [bag addObject:object];
    }
    for (NSObject *object in bag) {
        [self removeObject:object];
    }
}

@end


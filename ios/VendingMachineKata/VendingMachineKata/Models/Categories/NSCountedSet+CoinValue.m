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
            NSDecimalNumber *value = [NSDecimalNumber decimalNumberWithDecimal:((CoinData *)object).coinValue];
            NSUInteger count = [self countForObject:object];
            NSDecimalNumber *decimalCount = [NSDecimalNumber decimalNumberWithDecimal:[@(count) decimalValue]];
            NSDecimalNumber *new = [value decimalNumberByMultiplyingBy:decimalCount];
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
            totalCount += [self countForObject:object];
        }
    }
    return totalCount;
}

- (void)empty {
    NSCountedSet *tempBag = [self copy];
    for (NSObject *object in tempBag) {
        [self removeObject:object];
    }
}

- (void)emptyInto:(NSCountedSet *)bag {
    NSCountedSet *objects = [self copy];
    for (NSObject *object in objects) {
        [bag addObject:object];
        [self removeObject:objects];
    }
}

- (NSInteger)quarters {
    return [self countForObject:[CoinData quarter]];
}

- (NSInteger)nickels {
    return [self countForObject:[CoinData nickel]];
}

- (NSInteger)dimes {
    return [self countForObject:[CoinData dime]];
}

@end


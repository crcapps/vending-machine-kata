//
//  CoinBag.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinBag.h"
#import "CoinData.h"
#import "NSDecimalNumber+Currency.h"

@implementation CoinBag

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _quarters = 0;
        _dimes = 0;
        _nickels = 0;
        _pennies = 0;
    }
    
    return self;
}

- (NSInteger)coins {
    return self.quarters + self.dimes + self.nickels + self.pennies;
}

- (BOOL)removeCoin:(CoinData *)coin amount:(NSInteger)amount {
    BOOL removed = NO;
    switch (coin.coinType) {
        case kCoinTypeQuarter:
            if (self.quarters - amount >= 0) {
                _quarters -= amount;
                removed = YES;
            }
            break;
        case kCoinTypeDime:
            if (self.dimes - amount >= 0) {
                _dimes -= amount;
                removed = YES;
            }
            break;
        case kCoinTypeNickel:
            if (self.nickels - amount >= 0) {
                _nickels -= amount;
                removed = YES;
            }
            break;
        case kCoinTypePenny:
            if (self.pennies - amount >= 0) {
                _pennies -= amount;
                removed = YES;
            }
            break;
        default:
            break;
    }
    return removed;
}

- (void)addCoin:(CoinData *)coin amount:(NSInteger)amount {
    switch (coin.coinType) {
        case kCoinTypeQuarter:
            _quarters += amount;
            break;
        case kCoinTypeDime:
            _dimes += amount;
            break;
        case kCoinTypeNickel:
            _nickels += amount;
            break;
        case kCoinTypePenny:
            _pennies += amount;
            break;
        default:
            break;
    }
}

- (BOOL)transferCoin:(CoinData *)coin amount:(NSInteger)amount toBag:(CoinBag *)bag {
    BOOL transferred = NO;
    transferred = [self removeCoin:coin amount:amount];
    if (transferred) {
        [bag addCoin:coin amount:amount];
    }
    return transferred;
}

- (NSDecimalNumber *)value {
    NSDecimalNumber *total = [NSDecimalNumber zero];
    total = [total decimalNumberByAdding:[self quartersValue]];
    total = [total decimalNumberByAdding:[self dimesValue]];
    total = [total decimalNumberByAdding:[self nickelsValue]];
    total = [total decimalNumberByAdding:[self penniesValue]];
    return total;
}

- (NSString *)localizedValueString {
    return self.value.localizedCurrencyString;
}

- (NSDecimalNumber *)quartersValue {
    NSDecimalNumber *count = [NSDecimalNumber
                              decimalNumberWithNumber:@(self.quarters)];
    NSDecimalNumber *value = [NSDecimalNumber decimalNumberWithDecimal:[CoinData quarter].coinValue];
    return [count decimalNumberByMultiplyingBy:value];
}

- (NSDecimalNumber *)dimesValue {
    NSDecimalNumber *count = [NSDecimalNumber
                              decimalNumberWithNumber:@(self.dimes)];
    NSDecimalNumber *value = [NSDecimalNumber decimalNumberWithDecimal:[CoinData dime].coinValue];
    return [count decimalNumberByMultiplyingBy:value];
}

- (NSDecimalNumber *)nickelsValue {
    NSDecimalNumber *count = [NSDecimalNumber
                              decimalNumberWithNumber:@(self.nickels)];
    NSDecimalNumber *value = [NSDecimalNumber decimalNumberWithDecimal:[CoinData nickel].coinValue];
    return [count decimalNumberByMultiplyingBy:value];
}

- (NSDecimalNumber *)penniesValue {
    NSDecimalNumber *count = [NSDecimalNumber
                              decimalNumberWithNumber:@(self.pennies)];
    NSDecimalNumber *value = [NSDecimalNumber decimalNumberWithDecimal:[CoinData penny].coinValue];
    return [count decimalNumberByMultiplyingBy:value];
}

- (void)emptyInto:(CoinBag *)bag {
    [bag addCoin:[CoinData quarter] amount:self.quarters];
    [bag addCoin:[CoinData dime] amount:self.dimes];
    [bag addCoin:[CoinData nickel] amount:self.nickels];
    [bag addCoin:[CoinData penny] amount:self.pennies];
    _quarters = 0;
    _dimes = 0;
    _nickels = 0;
    _pennies = 0;
}


@end

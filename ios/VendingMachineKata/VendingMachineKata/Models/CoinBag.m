//
//  CoinBag.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/9/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinBag.h"

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

- (void)removeCoin:(CoinData *)coin {
    switch (coin.coinType) {
        case kCoinTypeQuarter:
            _quarters--;
            break;
        case kCoinTypeDime:
            _dimes--;
            break;
        case kCoinTypeNickel:
            _nickels--;
            break;
        case kCoinTypePenny:
            _pennies--;
            break;
        default:
            break;
    }
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

- (void)addCoin:(CoinData *)coin {
    [self addCoin:coin amount:1];
}

- (NSDecimalNumber *)value {
    NSDecimalNumber *total = [NSDecimalNumber zero];
    total = [total decimalNumberByAdding:[self quartersValue]];
    total = [total decimalNumberByAdding:[self dimesValue]];
    total = [total decimalNumberByAdding:[self nickelsValue]];
    total = [total decimalNumberByAdding:[self penniesValue]];
    return total;
}

- (NSString *)valueText {
    return [NSNumberFormatter localizedStringFromNumber:self.value numberStyle:NSNumberFormatterCurrencyStyle];
}

- (NSDecimalNumber *)quartersValue {
    NSDecimalNumber *count = [NSDecimalNumber
                              decimalNumberWithDecimal:[@(self.quarters) decimalValue]];
    NSDecimalNumber *value = [NSDecimalNumber decimalNumberWithDecimal:[CoinData quarter].coinValue];
    return [count decimalNumberByMultiplyingBy:value];
}

- (NSDecimalNumber *)dimesValue {
    NSDecimalNumber *count = [NSDecimalNumber
                              decimalNumberWithDecimal:[@(self.dimes) decimalValue]];
    NSDecimalNumber *value = [NSDecimalNumber decimalNumberWithDecimal:[CoinData dime].coinValue];
    return [count decimalNumberByMultiplyingBy:value];
}

- (NSDecimalNumber *)nickelsValue {
    NSDecimalNumber *count = [NSDecimalNumber
                              decimalNumberWithDecimal:[@(self.nickels) decimalValue]];
    NSDecimalNumber *value = [NSDecimalNumber decimalNumberWithDecimal:[CoinData nickel].coinValue];
    return [count decimalNumberByMultiplyingBy:value];
}

- (NSDecimalNumber *)penniesValue {
    NSDecimalNumber *count = [NSDecimalNumber
                              decimalNumberWithDecimal:[@(self.pennies) decimalValue]];
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

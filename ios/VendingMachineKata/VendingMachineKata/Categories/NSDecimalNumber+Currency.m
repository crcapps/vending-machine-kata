//
//  NSDecimalNumber+Currency.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "NSDecimalNumber+Currency.h"

@implementation NSDecimalNumber (Currency)

- (NSString *)localizedCurrencyString {
    return [NSNumberFormatter localizedStringFromNumber:self numberStyle:NSNumberFormatterCurrencyStyle];
}

+ (NSDecimalNumber *)decimalNumberWithNumber:(NSNumber *)number {
    return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
}

@end

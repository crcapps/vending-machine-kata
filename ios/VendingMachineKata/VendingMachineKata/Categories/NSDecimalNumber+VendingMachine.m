//
//  NSDecimalNumber+VendingMachine.m
//  VendingMachineKata
//
//  Created by the Heatherness on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "NSDecimalNumber+VendingMachine.h"

@implementation NSDecimalNumber (VendingMachine)

/** Constructs an NSDecimalNumber* out of a double with no fuss.
 Not manipulating structs because it doesn't have to be SUPER fast.
 */
+ (NSDecimalNumber *)decimalNumberWithDouble:(double)doubleValue {
    NSNumber *numberValue = [NSNumber numberWithDouble:doubleValue];
    NSDecimal decimalValue = [numberValue decimalValue];
    return [NSDecimalNumber decimalNumberWithDecimal:decimalValue];
}

@end

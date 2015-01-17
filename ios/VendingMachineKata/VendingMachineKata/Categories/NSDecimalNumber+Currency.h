//
//  NSDecimalNumber+Currency.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Currency)

@property (strong, nonatomic, readonly) NSString *localizedCurrencyString;

+ (NSDecimalNumber *)decimalNumberWithNumber:(NSNumber *)number;

@end

//
//  CurrencyTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NSDecimalNumber+Currency.h"

@interface CurrencyTests : XCTestCase

@end

@implementation CurrencyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDecimalNumberWithNumber {
    NSDecimalNumber *expected = [NSDecimalNumber decimalNumberWithDecimal:[@0.99 decimalValue]];
    NSDecimalNumber *actual = [NSDecimalNumber decimalNumberWithNumber:@0.99];
    NSComparisonResult compare = [expected compare:actual];
    XCTAssertEqual(NSOrderedSame, compare, @"** - (NSDecimalNumber *)decimalNumberWithNumber returned incorrect value!  Expected %@ but got %@", expected, actual);
}

- (void)testLocalizedCurrencyStringForDecimalNumber {
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithNumber:@0.99];
    NSString *expectedStringForDevelopmentLocation = @"$0.99";
    NSString *actual = [decimalNumber localizedCurrencyString];
    XCTAssert([expectedStringForDevelopmentLocation isEqualToString:actual], @"** - (NSString *)localizedCurrencyString returned incorrect value for en-us!  Expected %@ but got %@.", expectedStringForDevelopmentLocation, actual);
}

@end

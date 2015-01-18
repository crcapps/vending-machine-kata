//
//  AcceptCoinsTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/15/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinSlot.h"
#import "CoinData.h"
#import "CoinBag.h"
#import "Display.h"

#import "NSDecimalNumber+Currency.h"

/**
 Accept Coins
 
 As a vendor
 I want a vending machine that accepts coins
 So that I can collect money from the customer
 
 The vending machine will accept valid coins (nickels, dimes, and quarters) and reject invalid ones (pennies). When a valid coin is inserted the amount of the coin will be added to the current amount and the display will be updated. When there are no coins inserted, the machine displays INSERT COIN. Rejected coins are placed in the coin return.
 */

@interface AcceptCoinsTests : XCTestCase

@end

@implementation AcceptCoinsTests

CoinSlot *coinSlot;
Display *display;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
    display = [Display new];
}

- (void)testItAcceptsValidCoinsAndRejectsInvalidCoins {
    NSLog(@"** The vending machine will accept valid coins (nickels, dimes, and quarters) and reject invalid ones (pennies).");
    
    NSInteger numberOfQuarters = 3;
    NSInteger numberOfDimes = 1;
    NSInteger numberOfNickels = 2;
    NSInteger numberOfPennies = 4;
    NSInteger expectedNumberAccepted = 6;
    NSInteger expectedNumberRejected = 4;
    
    [self dropCoin:kCoinTypeQuarter amount:numberOfQuarters];
    [self dropCoin:kCoinTypeDime amount:numberOfDimes];
    [self dropCoin:kCoinTypeNickel amount:numberOfNickels];
    [self dropCoin:kCoinTypePenny amount:numberOfPennies];
    
    [self dropCoin:kCoinTypeSlug amount:255];
    [self dropCoin:NSIntegerMin amount:99];
    
    XCTAssertEqual(expectedNumberAccepted, coinSlot.insertedCoins.coins, @"*** The wrong number of coins were accepted!  Expected %ld but got %ld", (long)expectedNumberAccepted, (long)coinSlot.insertedCoins.coins);
    XCTAssertEqual(expectedNumberRejected, coinSlot.returnedCoins.coins, @"*** The wrong number of coins were accepted!  Expected %ld but got %ld", (long)expectedNumberRejected, (long)coinSlot.returnedCoins.coins);
}

- (void)testItAddsValueOfInsertedCoinToCurrentAmountAndUpdatesDisplay {
    NSLog(@"** When a valid coin is inserted the amount of the coin will be added to the current amount and the display will be updated.");
    
    NSInteger numberOfQuarters = 3;
    [self dropCoin:kCoinTypeQuarter amount:numberOfQuarters];
    [self dropCoin:kCoinTypePenny amount:1];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithNumber:@0.75];
    NSString *expectedText = @"$0.75";
    NSComparisonResult compare = [expectedValue compare:coinSlot.insertedCoins.value];
    NSString *actualText = display.text;
    
    XCTAssertEqual(NSOrderedSame, compare, @"*** Value of inserted coins was wrong!  Expected %@ but got %@", expectedValue, coinSlot.insertedCoins.value);
    XCTAssert([expectedText isEqualToString:actualText], @"*** Proper amount was not displayed.  Expected %@ but got %@", expectedText, actualText);
}

- (void)testItDisplaysCorrectMessageWhenNoCoinsAreInserted {
    NSLog(@"** When there are no coins inserted, the machine displays INSERT COIN.");
    
    XCTAssert([self itDisplaysValidInitialValue], @"A valid initial message was not displayed when no coins are inserted.");
}

- (void)testItPlacesRejectedCoinsInTheCoinReturn {
    NSLog(@"** Rejected coins are placed in the coin return.");
    
    NSInteger numberOfQuarters = 2;
    NSInteger numberOfPennies = 3;
    
    [self dropCoin:kCoinTypeQuarter amount:numberOfQuarters];
    [self dropCoin:kCoinTypePenny amount:numberOfPennies];
    [self dropCoin:kCoinTypeSlug amount:1];
    
    XCTAssertEqual(coinSlot.returnedCoins.coins, numberOfPennies, @"The wrong number of coins were in the coin return!  Expected %ld but got %ld", numberOfPennies, coinSlot.returnedCoins.coins);
}

#pragma mark - Helper Methods

- (BOOL)itDisplaysValidInitialValue {
    BOOL initialValueIsValid = NO;
    
    if ([display.text isEqualToString:kDisplayTextInsertCoin]) {
        initialValueIsValid = YES;
    }
    
    return initialValueIsValid;
}

- (void)dropCoin:(CoinType)coin amount:(NSInteger)amount {
    if (amount > 0) {
        NSNumber *diameter = nil;
        NSNumber *mass = nil;
        NSNumber *thickness = nil;
        switch (coin) {
            case kCoinTypeSlug:
                diameter = @24.26;
                mass = @5.000;
                thickness = @1.52;
                break;
            case kCoinTypeQuarter:
                diameter = @24.26;
                mass = @5.670;
                thickness = @1.75;
                break;
            case kCoinTypeDime:
                diameter = @17.91;
                mass = @2.268;
                thickness = @1.35;
                break;
            case kCoinTypeNickel:
                diameter = @21.21;
                mass = @5.000;
                thickness = @1.95;
                break;
            case kCoinTypePenny:
                diameter = @19.05;
                mass = @2.500;
                thickness = @1.52;
                break;
            default:
                break;
        }
        for (NSInteger index = 0; index < amount; index++) {
            [coinSlot dropCoinWithDiameter:diameter mass:mass thickness:thickness];
        }
    }
}

@end

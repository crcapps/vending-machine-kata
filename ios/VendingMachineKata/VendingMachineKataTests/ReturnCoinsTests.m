//
//  ReturnCoinsTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinSlot.h"
#import "CoinBag.h"
#import "CoinData.h"
#import "Display.h"

#import "NSDecimalNumber+Currency.h"

/**
 Return Coins
 
 As a customer
 I want to have my money returned
 So that I can change my mind about buying stuff from the vending machine
 
 When the return coins is selected, the money the customer has placed in the machine is returned and the display shows INSERT COIN.
 */

@interface ReturnCoinsTests : XCTestCase

@end

@implementation ReturnCoinsTests

CoinSlot *coinSlot;
Display *display;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
    display = [Display new];
}

- (void)testItReturnsInsertedMoneyAndDisplayShowsCorrectMessage {
    NSLog(@"** When the return coins is selected, the money the customer has placed in the machine is returned and the display shows INSERT COIN.");
    
    [self dropCoin:kCoinTypeQuarter amount:4];
    
    [coinSlot returnCoins];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithNumber:@1.00];
    NSComparisonResult compare = [expectedValue compare:coinSlot.returnedCoins.value];
    
    XCTAssert([self coinSlotIsEmpty], @"*** Inserted coins not emptied after return coin pressed!");
    XCTAssertEqual(NSOrderedSame, compare, @"*** Coin returned contained the wrong amount of change!  Expected %@ but got %@", expectedValue.localizedCurrencyString, coinSlot.returnedCoins.localizedValueString);
}

#pragma mark - Helper Methods

- (BOOL)coinSlotIsEmpty {
    return ([coinSlot.insertedCoins.value compare:[NSDecimalNumber decimalNumberWithNumber:@0.00]] == NSOrderedSame);
}

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

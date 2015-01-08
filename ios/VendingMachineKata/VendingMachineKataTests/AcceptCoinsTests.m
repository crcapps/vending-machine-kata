//
//  AcceptCoins.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NSCountedSet+CoinValue.h"

#import "CoinSlot.h"
#import "Display.h"
#import "CoinData.h"

/**
 As a vendor
 I want a vending machine that accepts coins
 So that I can collect money from the customer
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

- (void)tearDown {
    [super tearDown];
}

- (void)testInitialDisplayText {
    NSString *expectedText = kDisplayTextInsertCoin;
    NSComparisonResult compare = [expectedText caseInsensitiveCompare:display.text];
    XCTAssertEqual(NSOrderedSame, compare);
}

#pragma mark - Coin Recognition Tests

- (void)testCoinRecognizerQuarter {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@24.26 mass:@5.670 thickness:@1.75];
    XCTAssertEqual(kCoinTypeQuarter, coinData.coinType, "Quarter was not recognized!");
}

- (void)testCoinRecognizerDime {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@17.91 mass:@2.268 thickness:@1.35];
    XCTAssertEqual(kCoinTypeDime, coinData.coinType, "Dime was not recognized!");
}

- (void)testCoinRecognizerNickel {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@21.21 mass:@5.000 thickness:@1.95];
    XCTAssertEqual(kCoinTypeNickel, coinData.coinType, "Nickel was not recognized!");
}

- (void)testCoinRecognizerPenny {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@19.05 mass:@2.500 thickness:@1.52];
    XCTAssertEqual(kCoinTypePenny, coinData.coinType, "Penny was not recognized!");
}

- (void)testCoinRecognizerSlug {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@24.26 mass:@5.000 thickness:@1.52];
    XCTAssertEqual(kCoinTypeSlug, coinData.coinType, "Slug was not recognized!");
}

#pragma mark - Coin Slot Tests

- (void)testCoinSlotDroppedQuarter {
    [self testInitialDisplayText];
    
    [self dropCoin:kCoinTypeQuarter];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.25 decimalValue]];
    NSInteger expectedAcceptedCount = 1;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a quarter but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a quarter but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a quarter but didn't get expected value back.");
}

- (void)testCoinSlotDroppedDime {
    [self testInitialDisplayText];
    
    [self dropCoin:kCoinTypeDime];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.10 decimalValue]];
    NSInteger expectedAcceptedCount = 1;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a dime but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a dime but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a dime but didn't get expected value back.");
}

- (void)testCoinSlotDroppedNickel {
    [self testInitialDisplayText];
    
    [self dropCoin:kCoinTypeNickel];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.05 decimalValue]];
    NSInteger expectedAcceptedCount = 1;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a nickel but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a nickel but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a nickel but didn't get expected value back.");
}

- (void)testCoinSlotDroppedPenny {
    [self testInitialDisplayText];
    
    [self dropCoin:kCoinTypePenny];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSInteger expectedAcceptedCount = 0;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 1;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a penny but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a penny but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a penny but it was assigned a value.");
}

- (void)testCoinSlotDroppedSlug {
    [self testInitialDisplayText];
    
    [self dropCoin:kCoinTypeSlug];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSInteger expectedAcceptedCount = 0;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 1;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a slug but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a slug but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a slug but it was assigned a value.");
}

- (void)testDropFourQuarters {
    [self testInitialDisplayText];
    
    [self dropCoin:kCoinTypeQuarter amount:4];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSInteger expectedAcceptedCount = 4;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped four quarters but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped four quarters but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped four quarters but it didn't add up to a dollar.");
}

- (void)testDropThreeQuartersTwoPenniesFiveNickelsAndThreeSlugs {
    [self testInitialDisplayText];
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    [self dropCoin:kCoinTypePenny amount:2];
    [self dropCoin:kCoinTypeNickel amount:5];
    [self dropCoin:kCoinTypeSlug amount:3];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSInteger expectedAcceptedCount = 8; // The pennies and slugs shouldn't end up in the value bag.
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 5;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped lots of coins but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped lots of coins but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped lots of coins but it didn't add up correctly");
}

#pragma mark - Helper Methods

- (void)dropCoin:(CoinType)coin amount:(NSInteger)amount {
    if (amount > 0) {
        NSNumber *diameter = @0.00;
        NSNumber *mass = @0.00;
        NSNumber *thickness = @0.00;
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

- (void)dropCoin:(CoinType)coin {
    [self dropCoin:coin amount:1];
}

@end

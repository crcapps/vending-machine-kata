//
//  ModelTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinSlot.h"
#import "Display.h"
#import "CoinData.h"

#pragma mark - Coinage setup

@interface ModelTests : XCTestCase

@end

@implementation ModelTests

CoinSlot *coinSlot;
Display *display;
CoinData *coinRecognizer;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
    display = [Display new];
    coinRecognizer = [CoinData new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Sanity Checks

- (void)testClassesExist {
    XCTAssertNotNil(coinSlot, @"CoinSlot class doesn't exist!");
    XCTAssertNotNil(coinRecognizer, @"CoinData class doesn't exist!");
    XCTAssertNotNil(display, @"Display class doesn't exist!");
}

#pragma mark - Coin Recognition Tests

- (void)testCoinRecognizerQuarter {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    XCTAssertEqual(kCoinTypeQuarter, coinData.coinType, "Quarter was not recognized!");
}

- (void)testCoinRecognizerDime {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@17.91 Mass:@2.268 Thickness:@1.35];
    XCTAssertEqual(kCoinTypeDime, coinData.coinType, "Dime was not recognized!");
}

- (void)testCoinRecognizerNickel {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    XCTAssertEqual(kCoinTypeNickel, coinData.coinType, "Nickel was not recognized!");
}

- (void)testCoinRecognizerPenny {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@19.05 Mass:@2.500 Thickness:@1.52];
    XCTAssertEqual(kCoinTypePenny, coinData.coinType, "Penny was not recognized!");
}

- (void)testCoinRecognizerSlug {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    XCTAssertEqual(kCoinTypeSlug, coinData.coinType, "Slug was not recognized!");
}

#pragma mark - Coin Slot Tests

- (void)testCoinSlotDroppedQuarter {
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.25 decimalValue]];
    NSInteger expectedAcceptedCount = 1;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.count;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a quarter but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a quarter but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a quarter but didn't get expected value back.");
}

- (void)testCoinSlotDroppedDime {
    [coinSlot dropCoinWithDiameter:@17.91 Mass:@2.268 Thickness:@1.35];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.10 decimalValue]];
    NSInteger expectedAcceptedCount = 1;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.count;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a dime but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a dime but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a dime but didn't get expected value back.");
}

- (void)testCoinSlotDroppedNickel {
    [coinSlot dropCoinWithDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.05 decimalValue]];
    NSInteger expectedAcceptedCount = 1;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.count;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a nickel but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a nickel but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a nickel but didn't get expected value back.");
}

- (void)testCoinSlotDroppedPenny {
    [coinSlot dropCoinWithDiameter:@19.05 Mass:@2.500 Thickness:@1.52];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSInteger expectedAcceptedCount = 0;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.count;
    NSInteger expectedRejectedCount = 1;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a penny but the wrong number were in the value bag.");
    
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a penny but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a penny but it was assigned a value.");
}

- (void)testCoinSlotDroppedSlug {
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSInteger expectedAcceptedCount = 0;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.count;
    NSInteger expectedRejectedCount = 1;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a slug but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a slug but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a slug but it was assigned a value.");
}

- (void)testDropFourQuarters {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSInteger expectedAcceptedCount = 4;
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.count;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped four quarters but the wrong number were in the value bag.");
    
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped four quarters but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped four quarters but it didn't add up to a dollar.");
}

- (void)testDropThreeQuartersTwoPenniesFiveNickelsAndThreeSlugs {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSInteger expectedAcceptedCount = 8; // The pennies and slugs shouldn't end up in the value bag.
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@19.05 Mass:@2.500 Thickness:@1.52];
    [coinSlot dropCoinWithDiameter:@19.05 Mass:@2.500 Thickness:@1.52];
    [coinSlot dropCoinWithDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    [coinSlot dropCoinWithDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    [coinSlot dropCoinWithDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    [coinSlot dropCoinWithDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    [coinSlot dropCoinWithDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    NSDecimalNumber *actualValue = coinSlot.insertedCoinsValue;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.count;
    NSInteger expectedRejectedCount = 5;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.count;
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped lots of coins but the wrong number were in the value bag.");
    
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped lots of coins but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped lots of coins but it didn't add up correctly");
}

@end

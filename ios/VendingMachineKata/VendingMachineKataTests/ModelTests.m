//
//  ModelTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "VendingMachine.h"
#import "CoinSlot.h"
#import "Display.h"
#import "CoinReturn.h"
#import "CoinData.h"

#pragma mark - Coinage setup

@interface ModelTests : XCTestCase

@end

@implementation ModelTests

VendingMachine *vendingMachine;
CoinSlot *coinSlot;
Display *display;
CoinReturn *coinReturn;
CoinData *coinRecognizer;

- (void)setUp {
    [super setUp];
    vendingMachine = [VendingMachine new];
    coinSlot = [CoinSlot new];
    display = [Display new];
    coinReturn = [CoinReturn new];
    coinRecognizer = [CoinData new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Sanity Checks

- (void)testClassesExist {
    XCTAssertNotNil(vendingMachine, @"VendingMachine class doesn't exist!");
    XCTAssertNotNil(coinSlot, @"CoinSlot class doesn't exist!");
    XCTAssertNotNil(coinRecognizer, @"CoinRecognizer class doesn't exist!");
    XCTAssertNotNil(display, @"Display class doesn't exist!");
    XCTAssertNotNil(coinReturn, @"CoinReturn class doesn't exist!");
}

- (void)testVendingMachineIntegrity {
    CoinSlot *slot = vendingMachine.coinSlot;
    XCTAssertNotNil(slot, @"Vending machine doesn't have a coin slot!");
    Display *screen = vendingMachine.display;
    XCTAssertNotNil(screen, @"Vending machine doesn't have a display!");
    CoinReturn *returned = vendingMachine.coinReturn;
    XCTAssertNotNil(returned, @"Vending machine doesn't have a coin return!");
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
    NSInteger expectedCount = 1;
    NSInteger actualCount = coinSlot.insertedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(expectedCount, actualCount, @"Dropped a quarter but the wrong number were in the value bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a quarter but didn't get expected value back.");
}

- (void)testCoinSlotDroppedDime {
    [coinSlot dropCoinWithDiameter:@17.91 Mass:@2.268 Thickness:@1.35];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.10 decimalValue]];
    NSInteger expectedCount = 1;
    NSInteger actualCount = coinSlot.insertedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(expectedCount, actualCount, @"Dropped a dime but the wrong number were in the value bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a dime but didn't get expected value back.");
}

- (void)testCoinSlotDroppedNickel {
    [coinSlot dropCoinWithDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.05 decimalValue]];
    NSInteger expectedCount = 1;
    NSInteger actualCount = coinSlot.insertedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(expectedCount, actualCount, @"Dropped a nickel but the wrong number were in the value bag.");    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a nickel but didn't get expected value back.");
}

- (void)testCoinSlotDroppedPenny {
    [coinSlot dropCoinWithDiameter:@19.05 Mass:@2.500 Thickness:@1.52];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSInteger expectedCount = 0;
    NSInteger actualCount = coinSlot.insertedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(expectedCount, actualCount, @"Dropped a penny but the wrong number were in the value bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a penny but it was assigned a value.");
}

- (void)testCoinSlotDroppedSlug {
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSInteger expectedCount = 0;
    NSInteger actualCount = coinSlot.insertedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(expectedCount, actualCount, @"Dropped a quarter but the wrong number were in the value bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a slug but it was assigned a value.");
}

- (void)testDropFourQuarters {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSInteger expectedCount = 4;
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    NSInteger actualCount = coinSlot.insertedCoins.count;
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(expectedCount, actualCount, @"Dropped four quarters but the wrong number were in the value bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped four quarters but it didn't add up to a dollar.");
}

- (void)testDropThreeQuartersTwoPenniesFiveNickelsAndThreeSlugs {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSInteger expectedCount = 8; // The pennies and slugs shouldn't end up in the value bag.
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
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    NSInteger actualCount = coinSlot.insertedCoins.count;
    XCTAssertEqual(expectedCount, actualCount, @"Dropped lots of coins but the wrong number were in the value bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped lots of coins but it didn't add up correctly");
}

@end

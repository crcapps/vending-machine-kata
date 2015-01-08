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

#pragma mark - Sanity Check

- (void)testVendingMachineClassExists {
    XCTAssertNotNil(vendingMachine, @"VendingMachine class doesn't exist!");
}

- (void)testCoinSlotClassExists {
    XCTAssertNotNil(coinSlot, @"CoinSlot class doesn't exist!");
}

- (void)testCoinRecognizerClassExists {
    XCTAssertNotNil(coinRecognizer, @"CoinRecognizer class doesn't exist!");
}

- (void)testDisplayClassExists {
    XCTAssertNotNil(display, @"Display class doesn't exist!");
}

- (void)testCoinReturnClassExists {
    XCTAssertNotNil(coinReturn, @"CoinReturn class doesn't exist!");
}

#pragma mark - Vending Machine Integrity

- (void)testVendingMachineHasCoinSlot {
    CoinSlot *slot = vendingMachine.coinSlot;
    XCTAssertNotNil(slot, @"Vending machine doesn't have a coin slot!");
}

- (void)testVendingMachineHasDisplay {
    Display *screen = vendingMachine.display;
    XCTAssertNotNil(screen, @"Vending machine doesn't have a display!");
}

- (void)testVendingMachineHasCoinReturn {
    CoinReturn *returned = vendingMachine.coinReturn;
    XCTAssertNotNil(returned, @"Vending machine doesn't have a coin return!");
}

#pragma mark - Coin Recognizer Tests

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

- (void)testCoinSlotDroppedQuarterValue {
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.25 decimalValue]];
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a quarter but didn't get expected value back.");
}

- (void)testCoinSlotDroppedDimeValue {
    [coinSlot dropCoinWithDiameter:@17.91 Mass:@2.268 Thickness:@1.35];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.10 decimalValue]];
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a dime but didn't get expected value back.");
}

- (void)testCoinSlotDroppedNickelValue {
    [coinSlot dropCoinWithDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.05 decimalValue]];
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a nickel but didn't get expected value back.");
}

- (void)testCoinSlotDropPennyForZeroValue {
    [coinSlot dropCoinWithDiameter:@19.05 Mass:@2.500 Thickness:@1.52];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a penny but it was assigned a value.");
}

- (void)testCoinSlotDropSlugForZeroValue {
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a slug but it was assigned a value.");
}

- (void)testDropFourQuartersForValue {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped four quarters but it didn't add up to a dollar.");
}

- (void)testDropThreeQuartersTwoPenniesFiveNickelsAndThreeSlugsForValue {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
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
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped lots of coins but it didn't add up correctly");
}

- (void)testDropThreeQuartersTwoPenniesFiveNickelsAndThreeSlugsForCount {
    NSInteger expectedValue = 8; // The pennies and slugs shouldn't end up in the value bag.
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
    NSInteger actualValue = coinSlot.insertedCoins.count;
    XCTAssertEqual(expectedValue, actualValue, @"Dropped lots of coins but the wrong number were in the value bag.");
}

@end

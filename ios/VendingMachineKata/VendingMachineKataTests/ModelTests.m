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
#import "CoinRecognizer.h"

#pragma mark - Coinage setup

@interface ModelTests : XCTestCase

@end

@implementation ModelTests

VendingMachine *vendingMachine;
CoinSlot *coinSlot;
Display *display;
CoinReturn *coinReturn;
CoinRecognizer *coinRecognizer;

- (void)setUp {
    [super setUp];
    vendingMachine = [VendingMachine new];
    coinSlot = [CoinSlot new];
    display = [Display new];
    coinReturn = [CoinReturn new];
    coinRecognizer = [CoinRecognizer new];
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
    CoinData coinData = [CoinRecognizer identifyCoinForDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    XCTAssertEqual(kCoinTypeQuarter, coinData.coinType, "Quarter was not recognized!");
}

- (void)testCoinRecognizerDime {
    CoinData coinData = [CoinRecognizer identifyCoinForDiameter:@17.91 Mass:@2.268 Thickness:@1.35];
    XCTAssertEqual(kCoinTypeDime, coinData.coinType, "Dime was not recognized!");
}

- (void)testCoinRecognizerNickel {
    CoinData coinData = [CoinRecognizer identifyCoinForDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    XCTAssertEqual(kCoinTypeNickel, coinData.coinType, "Nickel was not recognized!");
}

- (void)testCoinRecognizerPenny {
    CoinData coinData = [CoinRecognizer identifyCoinForDiameter:@19.05 Mass:@2.500 Thickness:@1.52];
    XCTAssertEqual(kCoinTypePenny, coinData.coinType, "Penny was not recognized!");
}

- (void)testCoinRecognizerSlug {
    CoinData coinData = [CoinRecognizer identifyCoinForDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    XCTAssertEqual(kCoinTypeSlug, coinData.coinType, "Slug was not recognized!");
}

#pragma mark - Coin Slot Tests

- (void)testCoinSlotDroppedQuarterValue {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.25 decimalValue]];
    NSDecimalNumber *actualValue = [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.670 Thickness:@1.75];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a quarter but didn't get expected value back.");
}

- (void)testCoinSlotDroppedDimeValue {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.10 decimalValue]];
    NSDecimalNumber *actualValue = [coinSlot dropCoinWithDiameter:@17.91 Mass:@2.268 Thickness:@1.35];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a dime but didn't get expected value back.");
}

- (void)testCoinSlotDroppedNickelValue {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.05 decimalValue]];
    NSDecimalNumber *actualValue = [coinSlot dropCoinWithDiameter:@21.21 Mass:@5.000 Thickness:@1.95];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a nickel but didn't get expected value back.");
}

- (void)testCoinSlotDropPennyForZeroValue {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSDecimalNumber *actualValue = [coinSlot dropCoinWithDiameter:@19.05 Mass:@2.500 Thickness:@1.52];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a penny but it was assigned a value.");
}

- (void)testCoinSlotDropSlugForZeroValue {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSDecimalNumber *actualValue = [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a slug but it was assigned a value.");
}

- (void)dropFourQuartersForValue {
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    [coinSlot dropCoinWithDiameter:@24.26 Mass:@5.000 Thickness:@1.52];
    NSDecimalNumber *actualValue = coinSlot.currentTotalValue;
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped four quarters but it didn't add up to a dollar.");
}

@end

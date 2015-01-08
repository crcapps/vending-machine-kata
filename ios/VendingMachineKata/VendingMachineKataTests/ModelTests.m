//
//  ModelTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NSDecimalNumber+VendingMachine.h"
#import "VendingMachine.h"
#import "CoinSlot.h"
#import "Display.h"
#import "CoinReturn.h"
#import "CoinRecognizer.h"

#pragma mark - Coinage setup

/** Struct for mocking coin drops and comparing the results to the expected values */
struct Coin {
    double diameter;
    double mass;
    double thickness;
    double expectedValue;
};
typedef struct Coin Coin;

// Quarter
static double const kQuarterDiameterValue = 24.26;
static double const kQuarterMassValue = 5.670;
static double const kQuarterThicknessValue = 1.75;
static double const kQuarterExpectedValue = 0.25;
static Coin const kQuarter = {
    .diameter = kQuarterDiameterValue,
    .mass = kQuarterMassValue,
    .thickness = kQuarterThicknessValue,
    .expectedValue = kQuarterExpectedValue
};

// Dime
static double const kDimeDiameterValue = 17.91;
static double const kDimeMassValue = 2.268;
static double const kDimeThicknessValue = 1.35;
static double const kDimeExpectedValue = 0.10;
static Coin const kDime = {
    .diameter = kDimeDiameterValue,
    .mass = kDimeMassValue,
    .thickness = kDimeThicknessValue,
    .expectedValue = kDimeExpectedValue
};

// Nickel
static double const kNickelDiameterValue = 21.21;
static double const kNickelMassValue = 5.000;
static double const kNickelThicknessValue = 1.95;
static double const kNickelExpectedValue = 0.05;
static Coin const kNickel = {
    .diameter = kNickelDiameterValue,
    .mass = kNickelMassValue,
    .thickness = kNickelThicknessValue,
    .expectedValue = kNickelExpectedValue
};

// Penny
static double const kPennyDiameterValue = 19.05;
static double const kPennyMassValue = 2.500;
static double const kPennyThicknessValue = 1.52;
static double const kPennyExpectedValue = 0.01;
static Coin const kPenny = {
    .diameter = kPennyDiameterValue,
    .mass = kPennyMassValue,
    .thickness = kPennyThicknessValue,
    .expectedValue = kPennyExpectedValue
};

// Slug
static double const kSlugDiameterValue = 24.26;
static double const kSlugMassValue = 2.500;
static double const kSlugThicknessValue = 1.95;
static double const kSlugExpectedValue = 0.00;
static Coin const kSlug = {
    .diameter = kSlugDiameterValue,
    .mass = kSlugMassValue,
    .thickness = kSlugThicknessValue,
    .expectedValue = kSlugExpectedValue
};

static double const kRejectedCoinExpectedValue = 0.00;

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
    CoinData coinData = [self identifyCoin:kQuarter];
    XCTAssertEqual(kCoinTypeQuarter, coinData.coinType, "Quarter was not recognized!");
}

- (void)testCoinRecognizerDime {
    CoinData coinData = [self identifyCoin:kDime];
    XCTAssertEqual(kCoinTypeDime, coinData.coinType, "Dime was not recognized!");
}

- (void)testCoinRecognizerNickel {
    CoinData coinData = [self identifyCoin:kNickel];
    XCTAssertEqual(kCoinTypeNickel, coinData.coinType, "Nickel was not recognized!");
}

- (void)testCoinRecognizerPenny {
    CoinData coinData = [self identifyCoin:kPenny];
    XCTAssertEqual(kCoinTypePenny, coinData.coinType, "Penny was not recognized!");
}

- (void)testCoinRecognizerSlug {
    CoinData coinData = [self identifyCoin:kSlug];
    XCTAssertEqual(kCoinTypeSlug, coinData.coinType, "Slug was not recognized!");
}

#pragma mark - Coin Slot Tests

- (void)testCoinSlotDroppedQuarterValue {
    NSDecimalNumber *expectedValue = [self expectedValueForCoin:kQuarter];
    NSDecimalNumber *actualValue = [self dropCoin:kQuarter];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a quarter but didn't get expected value back.");
}

- (void)testCoinSlotDroppedDimeValue {
    NSDecimalNumber *expectedValue = [self expectedValueForCoin:kDime];
    NSDecimalNumber *actualValue = [self dropCoin:kDime];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a dime but didn't get expected value back.");
}

- (void)testCoinSlotDroppedNickelValue {
    NSDecimalNumber *expectedValue = [self expectedValueForCoin:kNickel];
    NSDecimalNumber *actualValue = [self dropCoin:kNickel];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a nickel but didn't get expected value back.");
}

- (void)testCoinSlotDropPennyForRejection {
    NSDecimalNumber *expectedValue = [self expectedValueForRejectedCoin];
    NSDecimalNumber *actualValue = [self dropCoin:kPenny];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a penny and was not rejected.");
}

- (void)testCoinSlotDropSlugForRejection {
    NSDecimalNumber *expectedValue = [self expectedValueForRejectedCoin];
    NSDecimalNumber *actualValue = [self dropCoin:kSlug];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a slug and was not rejected.");
}
                                     
#pragma mark - Supporting Methods

- (NSDecimalNumber *)expectedValueForCoin:(Coin)coin {
    return [NSDecimalNumber decimalNumberWithDouble:coin.expectedValue];
}

- (NSDecimalNumber *)expectedValueForRejectedCoin {
    return [NSDecimalNumber decimalNumberWithDouble:kRejectedCoinExpectedValue];
}

- (CoinData)identifyCoin:(Coin)coin {
    NSNumber *diameter = [NSNumber numberWithDouble:coin.diameter];
    NSNumber *mass = [NSNumber numberWithDouble:coin.mass];
    NSNumber *thickness = [NSNumber numberWithDouble:coin.thickness];
    return [CoinRecognizer identifyCoinForDiameter:diameter Mass:mass Thickness:thickness];
}

- (NSDecimalNumber *)dropCoin:(Coin)coin{
    NSNumber *diameter = [NSNumber numberWithDouble:coin.diameter];
    NSNumber *mass = [NSNumber numberWithDouble:coin.mass];
    NSNumber *thickness = [NSNumber numberWithDouble:coin.thickness];
    return [coinSlot dropCoinWithDiameter:diameter Mass:mass Thickness:thickness];
}


@end

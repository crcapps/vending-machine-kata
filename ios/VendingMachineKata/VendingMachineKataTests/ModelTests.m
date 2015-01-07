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

#pragma mark - Coinage setup

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
static double const kPennyDiameterValue = 0.750;
static double const kPennyMassValue = 2.500;
static double const kPennyThicknessValue = 1.52;
static double const kPennyExpectedValue = 0.01;
static Coin const kPenny = {
    .diameter = kPennyDiameterValue,
    .mass = kPennyMassValue,
    .thickness = kPennyThicknessValue,
    .expectedValue = kPennyExpectedValue
};

static double const kRejectedCoinExpectedValue = 0.00;

@interface ModelTests : XCTestCase

@end

@implementation ModelTests

VendingMachine *vendingMachine;
CoinSlot *coinSlot;
Display *display;
CoinReturn *coinReturn;

- (void)setUp {
    [super setUp];
    vendingMachine = [VendingMachine new];
    coinSlot = [CoinSlot new];
    display = [Display new];
    coinReturn = [CoinReturn new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVendingMachineClassExists {
    XCTAssertNotNil(vendingMachine, @"VendingMachine class exists.");
}

- (void)testCoinSlotClassExists {
    XCTAssertNotNil(coinSlot, @"CoinSlot class exists");
}

- (void)testDisplayClassExists {
    XCTAssertNotNil(display, @"Display class exists");
}

- (void)testCoinReturnClassExists {
    XCTAssertNotNil(coinReturn, @"CoinReturn class exists");
}

- (void)testVendingMachineHasCoinSlot {
    CoinSlot *slot = vendingMachine.coinSlot;
    XCTAssertNotNil(slot);
}

- (void)testVendingMachineHasDisplay {
    Display *screen = vendingMachine.display;
    XCTAssertNotNil(screen);
}

- (void)testVendingMachineHasCoinReturn {
    CoinReturn *returned = vendingMachine.coinReturn;
    XCTAssertNotNil(returned);
}

- (void)testCoinSlotDropQuarter {
    NSDecimalNumber *expectedValue = [self expectedValueForCoin:kQuarter];
    NSDecimalNumber *actualValue = [self dropCoin:kQuarter];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue]);
}

- (void)testCoinSlotDropDime {
    NSDecimalNumber *expectedValue = [self expectedValueForCoin:kDime];
    NSDecimalNumber *actualValue = [self dropCoin:kDime];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue]);
}

- (void)testCoinSlotDropNickel {
    NSDecimalNumber *expectedValue = [self expectedValueForCoin:kNickel];
    NSDecimalNumber *actualValue = [self dropCoin:kNickel];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue]);
}

- (void)testCoinSlotDropPenny {
    NSDecimalNumber *expectedValue = [self expectedValueForRejectedCoin];
    NSDecimalNumber *actualValue = [self dropCoin:kPenny];
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue]);
}
                                     
#pragma mark - Supporting Methods

- (NSDecimalNumber *)expectedValueForCoin:(Coin)coin {
    return [NSDecimalNumber decimalNumberWithDouble:coin.expectedValue];
}

- (NSDecimalNumber *)expectedValueForRejectedCoin {
    return [NSDecimalNumber decimalNumberWithDouble:kRejectedCoinExpectedValue];
}

- (NSDecimalNumber *)dropCoin:(Coin)coin{
    NSNumber *diameter = [NSNumber numberWithDouble:coin.diameter];
    NSNumber *mass = [NSNumber numberWithDouble:coin.mass];
    NSNumber *thickness = [NSNumber numberWithDouble:coin.thickness];
    return [coinSlot dropCoinWithDiameter:diameter Mass:mass Thickness:thickness];
}


@end

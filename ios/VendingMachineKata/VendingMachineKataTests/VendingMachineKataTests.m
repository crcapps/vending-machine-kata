//
//  VendingMachineKataTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NSCountedSet+CoinValue.h"

#import "CoinSlot.h"
#import "Display.h"
#import "CoinData.h"
#import "Inventory.h"

@interface VendingMachineKataTests : XCTestCase

@end

@implementation VendingMachineKataTests

CoinSlot *coinSlot;
Display *display;
CoinData *coinDataTest;
Inventory *inventory;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
    display = [Display new];
    coinDataTest = [CoinData new];
    inventory = [Inventory new];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Sanity Checks

- (void)testClassesExist {
    XCTAssertNotNil(coinSlot, @"CoinSlot class doesn't exist!");
    XCTAssertNotNil(coinDataTest, @"CoinData class doesn't exist!");
    XCTAssertNotNil(display, @"Display class doesn't exist!");
    
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

#pragma mark - Display Tests

// This runs on its own at first, then is called by each coin drop to test precondition.
- (void)testInitialDisplayText {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
}

#pragma mark - Accept Coins Tests

/*
 As a vendor
 I want a vending machine that accepts coins
 So that I can collect money from the customer
 */

- (void)testCoinSlotDroppedQuarter {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeQuarter];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.25 decimalValue]];
    NSString *expectedText = [NSNumberFormatter localizedStringFromNumber:expectedValue numberStyle:NSNumberFormatterCurrencyStyle];
    NSInteger expectedAcceptedCount = 1;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a quarter but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a quarter but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a quarter but didn't get expected value back.");
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
}

- (void)testCoinSlotDroppedDime {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeDime];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.10 decimalValue]];
    NSString *expectedText = [NSNumberFormatter localizedStringFromNumber:expectedValue numberStyle:NSNumberFormatterCurrencyStyle];
    NSInteger expectedAcceptedCount = 1;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a dime but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a dime but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a dime but didn't get expected value back.");
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
}

- (void)testCoinSlotDroppedNickel {
    XCTAssert([self displayTextIsValidInitialValue],@"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeNickel];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.05 decimalValue]];
    NSString *expectedText = [NSNumberFormatter localizedStringFromNumber:expectedValue numberStyle:NSNumberFormatterCurrencyStyle];
    NSInteger expectedAcceptedCount = 1;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a nickel but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a nickel but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a nickel but didn't get expected value back.");
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
}

- (void)testCoinSlotDroppedPenny {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;;
    
    [self dropCoin:kCoinTypePenny];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSString *expectedText = kDisplayTextInsertCoin;
    NSInteger expectedAcceptedCount = 0;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 1;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a penny but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a penny but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a penny but it was assigned a value.");
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
}

- (void)testCoinSlotDroppedSlug {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeSlug];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSString *expectedText = kDisplayTextInsertCoin;
    NSInteger expectedAcceptedCount = 0;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 1;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a slug but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a slug but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a slug but it was assigned a value.");
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
}

- (void)testDropFourQuarters {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeQuarter amount:4];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSString *expectedText = [NSNumberFormatter localizedStringFromNumber:expectedValue numberStyle:NSNumberFormatterCurrencyStyle];
    NSInteger expectedAcceptedCount = 4;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 0;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped four quarters but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped four quarters but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped four quarters but it didn't add up to a dollar.");
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
}

- (void)testDropThreeQuartersTwoPenniesFiveNickelsAndThreeSlugs {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    [self dropCoin:kCoinTypePenny amount:2];
    [self dropCoin:kCoinTypeNickel amount:5];
    [self dropCoin:kCoinTypeSlug amount:3];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSString *expectedText = [NSNumberFormatter localizedStringFromNumber:expectedValue numberStyle:NSNumberFormatterCurrencyStyle];
    NSInteger expectedAcceptedCount = 8; // The pennies and slugs shouldn't end up in the value bag.
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 5;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped lots of coins but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped lots of coins but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped lots of coins but it didn't add up correctly");
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
}

#pragma mark - Select Product Tests

/*
 As a vendor
 I want customers to select products
 So that I can give them an incentive to put money in the machine
 */

- (void)testSelectColaWithoutEnoughMoney {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeDime amount:2];
    
    NSDecimalNumber *actualPrice = [inventory selectItem:kInventoryItemCola];
    
    NSDecimalNumber *expectedPrice = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSString *expectedPriceText = [NSNumberFormatter localizedStringFromNumber:expectedPrice numberStyle:NSNumberFormatterCurrencyStyle];
    NSString *expectedText = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, expectedPriceText];

    XCTAssertEqual(NSOrderedSame, [actualPrice compare:expectedPrice], @"Item price query returned incorrect amount.");
    XCTAssert([display.text isEqualToString:expectedText], @"Item price was not displayed after selection.");
    NSString *currentAmountText = [NSNumberFormatter localizedStringFromNumber:coinSlot.insertedCoins.value numberStyle:NSNumberFormatterCurrencyStyle];
    XCTAssert([display.text isEqualToString:currentAmountText], @"Display was not reset to current credit.");
}

- (void)testSelectColaWithEnoughMoney {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeQuarter amount:4];
    
    NSDecimalNumber *actualPrice = [inventory selectItem:kInventoryItemCola];[inventory selectItem:kInventoryItemCola];
    
    NSDecimalNumber *expectedPrice = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    
    XCTAssertEqual(NSOrderedSame, [actualPrice compare:expectedPrice], @"Item price query returned incorrect amount.");
    XCTAssert([display.text isEqualToString:kDisplayTextThankYou], @"Customer was not thanked after purchase.");
    XCTAssert([self coinSlotIsEmpty], @"Inserted coins were not emptied out after purchase.");
    XCTAssert([self displayTextIsValidInitialValue], @"Display was not reset to valid inital value after purchase.");
}

- (void)testSelectChipsWithoutEnoughMoney {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeDime amount:2];
    
    NSDecimalNumber *actualPrice = [inventory selectItem:kInventoryItemChips];
    
    NSDecimalNumber *expectedPrice = [NSDecimalNumber decimalNumberWithDecimal:[@0.50 decimalValue]];
    NSString *expectedPriceText = [NSNumberFormatter localizedStringFromNumber:expectedPrice numberStyle:NSNumberFormatterCurrencyStyle];
    NSString *expectedText = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, expectedPriceText];

    XCTAssertEqual(NSOrderedSame, [actualPrice compare:expectedPrice], @"Item price query returned incorrect amount.");
    XCTAssert([display.text isEqualToString:expectedText], @"Item price was not displayed after selection.");
    NSString *currentAmountText = [NSNumberFormatter localizedStringFromNumber:coinSlot.insertedCoins.value numberStyle:NSNumberFormatterCurrencyStyle];
    XCTAssert([display.text isEqualToString:currentAmountText], @"Display was not reset to current credit.");
}

- (void)testSelectChipsWithEnoughMoney {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeQuarter amount:2];
    
    NSDecimalNumber *actualPrice = [inventory selectItem:kInventoryItemChips];
    
    NSDecimalNumber *expectedPrice = [NSDecimalNumber decimalNumberWithDecimal:[@0.50 decimalValue]];
    
    XCTAssertEqual(NSOrderedSame, [actualPrice compare:expectedPrice], @"Item price query returned incorrect amount.");
    XCTAssert([display.text isEqualToString:kDisplayTextThankYou], @"Customer was not thanked after purchase.");
    XCTAssert([self coinSlotIsEmpty], @"Inserted coins were not emptied out after purchase.");
    XCTAssert([self displayTextIsValidInitialValue], @"Display was not reset to valid inital value after purchase.");

}

- (void)testSelectCandyWithoutEnoughMoney {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeDime amount:2];
    
    NSDecimalNumber *actualPrice = [inventory selectItem:kInventoryItemCandy];
    
    NSDecimalNumber *expectedPrice = [NSDecimalNumber decimalNumberWithDecimal:[@0.65 decimalValue]];
    NSString *expectedPriceText = [NSNumberFormatter localizedStringFromNumber:expectedPrice numberStyle:NSNumberFormatterCurrencyStyle];
    NSString *expectedText = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, expectedPriceText];
    
    XCTAssertEqual(NSOrderedSame, [actualPrice compare:expectedPrice], @"Item price query returned incorrect amount.");
    XCTAssert([display.text isEqualToString:expectedText], @"Item price was not displayed after selection.");
    NSString *currentAmountText = [NSNumberFormatter localizedStringFromNumber:coinSlot.insertedCoins.value numberStyle:NSNumberFormatterCurrencyStyle];
    XCTAssert([display.text isEqualToString:currentAmountText], @"Display was not reset to current credit.");
}

- (void)testSelectCandyWithEnoughMoney {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");;
    
    [self dropCoin:kCoinTypeQuarter amount:4];
    [self dropCoin:kCoinTypeDime];
    [self dropCoin:kCoinTypeNickel];
    
    NSDecimalNumber *actualPrice = [inventory selectItem:kInventoryItemCandy];
    
    NSDecimalNumber *expectedPrice = [NSDecimalNumber decimalNumberWithDecimal:[@0.65 decimalValue]];
    
    XCTAssertEqual(NSOrderedSame, [actualPrice compare:expectedPrice], @"Item price query returned incorrect amount.");
    XCTAssert([display.text isEqualToString:kDisplayTextThankYou], @"Customer was not thanked after purchase.");
    XCTAssert([self coinSlotIsEmpty], @"Inserted coins were not emptied out after purchase.");
    XCTAssert([self displayTextIsValidInitialValue], @"Display was not reset to valid inital value after purchase.");
}

#pragma mark - Helper Methods

- (BOOL)displayTextIsValidInitialValue {
    NSString *displayText = [NSString stringWithString:display.text];
    BOOL isInsertCoin = ([displayText isEqualToString:kDisplayTextInsertCoin]);
    BOOL valid = isInsertCoin;
    return valid;
}

- (BOOL)coinSlotIsEmpty {
    return coinSlot.insertedCoins.coins == 0 && coinSlot.insertedCoins.value == [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
}

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

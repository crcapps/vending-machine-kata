//
//  VendingMachineKataTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinSlot.h"
#import "Display.h"
#import "CoinData.h"
#import "Inventory.h"
#import "CoinBank.h"
#import "CoinBag.h"

@interface VendingMachineKataTests : XCTestCase

@end

@implementation VendingMachineKataTests

CoinSlot *coinSlot;
Display *display;
CoinData *coinDataTest;
Inventory *inventory;
CoinBank *coinBank;
CoinBag *aBag;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
    coinBank = [CoinBank new];
    display = [[Display alloc] initWithBank: coinBank];
    coinDataTest = [CoinData new];
    inventory = [Inventory new];
    aBag = [CoinBag new];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Sanity Checks

- (void)testClassesExist {
    XCTAssertNotNil(coinSlot, @"CoinSlot class doesn't exist!");
    XCTAssertNotNil(coinDataTest, @"CoinData class doesn't exist!");
    XCTAssertNotNil(display, @"Display class doesn't exist!");
    XCTAssertNotNil(inventory, @"Inventory class doesn't exist!");
    XCTAssertNotNil(coinBank, @"CoinBank class doesn't exist!");
}

- (void)testMakeInvalidSelection {
    XCTAssertThrows([inventory selectItem:NSIntegerMax]);
}

- (void)testAddInvalidItemToInventory {
    [inventory addItem:NSIntegerMax];
    NSInteger invalidItemCount = [inventory quantityForItem:NSIntegerMax];
    XCTAssertEqual(invalidItemCount, 0, @"Inventory allowed adding an invalid item");
}

- (void)testSlotDropBadCoin {
    [coinSlot dropCoinWithDiameter:nil mass:nil thickness:nil];
    XCTAssert(coinSlot.insertedCoins.coins == 0, @"Bad coin was not rejected!");
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
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    
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
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    
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
    XCTAssert([self displayTextIsValidInitialValue],@"Display not initialzed to valid inital value");
    
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
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    
    [self dropCoin:kCoinTypePenny];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSInteger expectedAcceptedCount = 0;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 1;
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a penny but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a penny but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a penny but it was assigned a value.");
    XCTAssert([self displayTextIsValidInitialValue], @"Display was not reset to valid initial value.");
}

- (void)testCoinSlotDroppedSlug {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    
    [self dropCoin:kCoinTypeSlug];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]];
    NSInteger expectedAcceptedCount = 0;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 0; //Because we should totally be ignoring slugs.
    NSInteger actualRejectedCount = coinSlot.returnedCoins.coins;
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(expectedAcceptedCount, actualAcceptedCount, @"Dropped a slug but the wrong number were in the value bag.");
    XCTAssertEqual(expectedRejectedCount, actualRejectedCount, @"Dropped a slug but the wrong number were in the return bag.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue], @"Dropped a slug but it was assigned a value.");
    XCTAssert([self displayTextIsValidInitialValue], @"Display was not reset to valid initial value.");
}

- (void)testDropFourQuarters {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    
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
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    [self dropCoin:kCoinTypePenny amount:2];
    [self dropCoin:kCoinTypeNickel amount:5];
    [self dropCoin:kCoinTypeSlug amount:3];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSString *expectedText = [NSNumberFormatter localizedStringFromNumber:expectedValue numberStyle:NSNumberFormatterCurrencyStyle];
    NSInteger expectedAcceptedCount = 8; // The pennies and slugs shouldn't end up in the value bag.
    NSDecimalNumber *actualValue = coinSlot.insertedCoins.value;
    NSInteger actualAcceptedCount = coinSlot.insertedCoins.coins;
    NSInteger expectedRejectedCount = 2;
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

- (void)testSelectItemWithoutEnoughMoney {
    [inventory addItem:kInventoryItemCola];
    
    [self dropCoin:kCoinTypeDime amount:2];
    
    NSDecimalNumber *currentValue = coinSlot.insertedCoins.value;
    
    NSDecimalNumber *actualPrice = [inventory selectItem:kInventoryItemCola];
    
    NSDecimalNumber *expectedPrice = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSString *expectedPriceText = [NSNumberFormatter localizedStringFromNumber:expectedPrice numberStyle:NSNumberFormatterCurrencyStyle];
    NSString *expectedText = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, expectedPriceText];
    
    XCTAssertEqual(NSOrderedSame, [actualPrice compare:expectedPrice], @"Item price query returned incorrect amount.");
    XCTAssert([display.text isEqualToString:expectedText], @"Item price was not displayed after selection.");
    NSString *currentAmountText = [NSNumberFormatter localizedStringFromNumber:coinSlot.insertedCoins.value numberStyle:NSNumberFormatterCurrencyStyle];
    XCTAssert([display.text isEqualToString:currentAmountText], @"Display was not reset to current credit.");
    XCTAssertEqual(NSOrderedSame, [coinSlot.insertedCoins.value compare:currentValue], @"Inserted credit changed without making a purchase.");
    XCTAssertEqual(NSOrderedSame, [coinBank.bankedCoins.value compare:[NSDecimalNumber zero]], @"Coins were banked without purchase complete!");
}

- (void)testSelectItemBeforeInsertingCoins {
    [inventory addItem:kInventoryItemCola];
    
    NSDecimalNumber *actualPrice = [inventory selectItem:kInventoryItemCola];
    
    NSDecimalNumber *expectedPrice = [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]];
    NSString *expectedPriceText = [NSNumberFormatter localizedStringFromNumber:expectedPrice numberStyle:NSNumberFormatterCurrencyStyle];
    NSString *expectedText = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, expectedPriceText];
    
    XCTAssertEqual(NSOrderedSame, [actualPrice compare:expectedPrice], @"Item price query returned incorrect amount.");
    XCTAssert([display.text isEqualToString:expectedText], @"Item price was not displayed after selection.");
    XCTAssert([self displayTextIsValidInitialValue], @"Display was not reset to valid inital value after selection.");
    
}

- (void)testSelectItemWithEnoughMoney {
    [inventory addItem:kInventoryItemChips];
    
    [self dropCoin:kCoinTypeQuarter amount:2];
    
    NSDecimalNumber *actualPrice = [inventory selectItem:kInventoryItemChips];
    
    NSDecimalNumber *expectedPrice = [NSDecimalNumber decimalNumberWithDecimal:[@0.50 decimalValue]];
    
    XCTAssertEqual(NSOrderedSame, [actualPrice compare:expectedPrice], @"Item price query returned incorrect amount.");
    XCTAssert([display.text isEqualToString:kDisplayTextThankYou], @"Customer was not thanked after purchase.");
    XCTAssert([self coinSlotIsEmpty], @"Inserted coins were not emptied out after purchase.");
    XCTAssert([self displayTextIsValidInitialValue], @"Display was not reset to valid inital value after purchase.");
    XCTAssertEqual(NSOrderedSame, [coinBank.bankedCoins.value compare:expectedPrice], @"Coins were not banked after purchase complete!");
}

#pragma mark - Make Change Tests

/*
 As a vendor
 I want customers to receive correct change
 So that they will use the vending machine again
 */

// Aah, The Vending Machine Change Making Problem!
// How shall we solve thee, O well known challenge?
// Do we use a greedy algorithm? Dynamic Programming?
// Check the implementation to find out!

- (void)testMakeChangeForEvenDollarItemWithEnoughInBank {
    [inventory addItem:kInventoryItemCola];
    
    [coinBank.bankedCoins addCoin:[CoinData dime]];
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:2];
    [self dropCoin:kCoinTypeQuarter amount:5];
    
    [inventory selectItem:kInventoryItemCola];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.25 decimalValue]];
    
    XCTAssert([self coinSlotIsEmpty], @"Inserted coins were not emptied out after purchase.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:coinSlot.returnedCoins.value],
                   @"Machine did not return correct Change!");
}

- (void)testMakeChangeForOddItemWithEnoughInBank {
    [inventory addItem:kInventoryItemCandy];
    
    [coinBank.bankedCoins addCoin:[CoinData dime]];
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:2];
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    
    [inventory selectItem:kInventoryItemCandy];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.10 decimalValue]];
    NSDecimalNumber *actualValue = coinSlot.returnedCoins.value;
    
    XCTAssert([self coinSlotIsEmpty], @"Inserted coins were not emptied out after purchase.");
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:actualValue],
                   @"Machine did not return correct Change!");
}

- (void)testMakeChangeWithoutEnoughInBank {
    [inventory addItem:kInventoryItemCandy];
    
    [coinBank.bankedCoins addCoin:[CoinData nickel]];
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    
    [inventory selectItem:kInventoryItemCandy];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.75 decimalValue]];
    
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:coinSlot.insertedCoins.value],
                   @"Machine allowed purchase without being able to make change (i.e. ate the money!)");
}

- (void)testMakeChangeWithEmptyBank {
    [inventory addItem:kInventoryItemCandy];
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    
    [inventory selectItem:kInventoryItemCandy];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.75 decimalValue]];
    
    XCTAssertEqual(NSOrderedSame, [expectedValue compare:coinSlot.insertedCoins.value],
                   @"Machine allowed purchase without being able to make change (i.e. ate the money!)");
}

#pragma mark - Return Coins Tests

/*
 As a customer
 I want to have my money returned
 So that I can change my mind about buying stuff from the vending machine
 */

- (void)testReturnCoinsNothingInserted {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    
    [coinBank.bankedCoins addCoin:[CoinData quarter] amount:3];
    
    NSDecimalNumber *expectedBankValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.75 decimalValue]];
    NSDecimalNumber *expectedReturnedCoinsValue = [NSDecimalNumber zero];
    NSDecimalNumber *expectedInsertedCoinsValue = [NSDecimalNumber zero];
    
    [coinSlot returnCoins];
    
    NSDecimalNumber *actualBankValue = coinBank.bankedCoins.value;
    NSDecimalNumber *actualReturnedCoinsValue = coinSlot.returnedCoins.value;
    NSDecimalNumber *actualInsertedCoinsValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(NSOrderedSame, [expectedBankValue compare:actualBankValue], @"Coin Return somehow affected the bank.");
    XCTAssertEqual(NSOrderedSame, [expectedReturnedCoinsValue compare:actualReturnedCoinsValue], @"Coin return with empty inserted bag dispensed coins.");
    XCTAssertEqual(NSOrderedSame, [expectedInsertedCoinsValue compare:actualInsertedCoinsValue], @"Coin Return with empty inserted bag altered inserted bag.");
    XCTAssert([self displayTextIsValidInitialValue], @"Display not reset to valid inital value");
}

- (void)testReturnCoinsWithSomeCoinsInserted {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    [self dropCoin:kCoinTypeQuarter amount:3];
    [self dropCoin:kCoinTypeDime amount:3];
    
    [coinBank.bankedCoins addCoin:[CoinData quarter] amount:3];
    
    NSDecimalNumber *expectedBankValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.75 decimalValue]];
    NSDecimalNumber *expectedReturnedCoinsValue = [NSDecimalNumber decimalNumberWithDecimal:[@1.05 decimalValue]];
    NSDecimalNumber *expectedInsertedCoinsValue = [NSDecimalNumber zero];
    
    [coinSlot returnCoins];
    
    NSDecimalNumber *actualBankValue = coinBank.bankedCoins.value;
    NSDecimalNumber *actualReturnedCoinsValue = coinSlot.returnedCoins.value;
    NSDecimalNumber *actualInsertedCoinsValue = coinSlot.insertedCoins.value;
    
    XCTAssertEqual(NSOrderedSame, [expectedBankValue compare:actualBankValue], @"Coin Return somehow affected the bank.");
    XCTAssertEqual(NSOrderedSame, [expectedReturnedCoinsValue compare:actualReturnedCoinsValue], @"Coin return didn't dispense the right coinage.");
    XCTAssertEqual(NSOrderedSame, [expectedInsertedCoinsValue compare:actualInsertedCoinsValue], @"Coin Return didn't empty inserted bag.");
    XCTAssert([self displayTextIsValidInitialValue], @"Display not reset to valid inital value");
}

#pragma mark - Sold Out Methods

- (void)testBuySoldOutItemWithNoMoneyInserted {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    
    [inventory selectItem:kInventoryItemCola];
    
    XCTAssert([display.text isEqualToString:kDisplayTextSoldOut], @"Display doesn't indicate sold out value");
    
    XCTAssert([self displayTextIsValidInitialValue], @"Display not reset to valid inital value");
}

- (void)testBuySoldOutItemWithMoneyInserted {
    XCTAssert([self displayTextIsValidInitialValue], @"Display not initialzed to valid inital value");
    
    [self dropCoin:kCoinTypeQuarter amount:4];
    
    [inventory selectItem:kInventoryItemCola];
    XCTAssert([display.text isEqualToString:kDisplayTextSoldOut], @"Display doesn't indicate sold out value");
    
    NSString *currentAmountText = [NSNumberFormatter localizedStringFromNumber:coinSlot.insertedCoins.value numberStyle:NSNumberFormatterCurrencyStyle];
    XCTAssert([display.text isEqualToString:currentAmountText], @"Display was not reset to current credit.");}

#pragma mark - Exact Change Only Tests

/*
 As a customer
 I want to be told when exact change is required
 So that I can determine if I can buy something with the money I have before inserting it
 */

- (void)testInitialExactChangeOnly {
    XCTAssertFalse([display.text isEqualToString:kDisplayTextInsertCoin], @"Insert coins message was not initialized when no coins were in bank.");
    
    XCTAssert([display.text isEqualToString:kDisplayTextExactChangeOnly], @"Exact Change message was not initialized when no coins were in bank.");
    
    [coinSlot returnCoins];
    
    XCTAssertFalse([display.text isEqualToString:kDisplayTextInsertCoin], @"Insert coins message was displayed when no coins were in bank.");
    
    XCTAssert([display.text isEqualToString:kDisplayTextExactChangeOnly], @"Exact Change message was not displayed when no coins were in bank.");
    
    
}

- (void)testInitialInsertCoins {
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:3];
    XCTAssertFalse([display.text isEqualToString:kDisplayTextExactChangeOnly], @"Exact Change message was displayed when coins were in bank.");
    XCTAssert([display.text isEqualToString:kDisplayTextInsertCoin], @"Insert coins message was displayed with sufficient minimum funds in bank.");
    
    [inventory addItem:kInventoryItemCandy quantity:2];
    
    [coinSlot returnCoins];
    
    XCTAssertFalse([display.text isEqualToString:kDisplayTextExactChangeOnly], @"Exact Change message was displayed when coins were in bank.");
    XCTAssert([display.text isEqualToString:kDisplayTextInsertCoin], @"Insert coins message was displayed with sufficient minimum funds in bank.");
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    
    [inventory selectItem:kInventoryItemCandy]; // Oh Candy, you are the problem child.
    // Well, it worked.  This whole thing is about you.
    
    XCTAssert([display.text isEqualToString:kDisplayTextThankYou], @"Customer was not thanked after purchase.");
    
    NSDecimalNumber *expectedPrice = [inventory selectItem:kInventoryItemCandy];
    
    NSString *expectedPriceText = [NSNumberFormatter localizedStringFromNumber:expectedPrice numberStyle:NSNumberFormatterCurrencyStyle];
    NSString *expectedText = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, expectedPriceText];
    XCTAssert([display.text isEqualToString:expectedText], @"Item price was not displayed after selection.");
    
    XCTAssert([display.text isEqualToString:kDisplayTextExactChangeOnly], @"Exact Change message was not displayed when no coins were in bank.");
    
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    
    NSDecimalNumber *expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.75 decimalValue]];
    expectedText = [NSNumberFormatter localizedStringFromNumber:expectedValue numberStyle:NSNumberFormatterCurrencyStyle];
    
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
    
    [inventory selectItem:kInventoryItemCandy];
    
    XCTAssert([display.text isEqualToString:kDisplayTextExactChangeOnly], @"Exact Change message was not displayed when no coins were in bank.");
    
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
    
    [coinSlot returnCoins];
    
    XCTAssert([display.text isEqualToString:kDisplayTextExactChangeOnly], @"Exact Change message was not displayed when no coins were in bank.");
    
    
    [self dropCoin:kCoinTypeNickel amount:3];
    
    expectedValue = [NSDecimalNumber decimalNumberWithDecimal:[@0.15 decimalValue]];
    expectedText = [NSNumberFormatter localizedStringFromNumber:expectedValue numberStyle:NSNumberFormatterCurrencyStyle];
    
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
    
    expectedText = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, expectedPriceText];
    
    [inventory selectItem:kInventoryItemCandy];
    
    XCTAssert([display.text isEqualToString:expectedText], @"Item price was not displayed after selection.");
    
    expectedText = [NSNumberFormatter localizedStringFromNumber:expectedValue numberStyle:NSNumberFormatterCurrencyStyle];
    
    XCTAssert([expectedText isEqualToString:display.text], @"Display does not display the correct amount.");
    
    [coinSlot returnCoins];
    
    XCTAssert([display.text isEqualToString:kDisplayTextExactChangeOnly], @"Exact Change message was not displayed when no coins were in bank.");
}

#pragma mark - Helper Methods

- (BOOL)displayTextIsValidInitialValue {
    NSString *displayText = display.text;
    BOOL isInsertCoin = [displayText isEqualToString:kDisplayTextInsertCoin];
    BOOL isExactChangeOnly = [displayText isEqualToString:kDisplayTextExactChangeOnly];
    BOOL valid = isInsertCoin || isExactChangeOnly;
    return valid;
}

- (BOOL)coinSlotIsEmpty {
    return ([coinSlot.insertedCoins.value compare:[NSDecimalNumber decimalNumberWithDecimal:[@0.00 decimalValue]]] == NSOrderedSame);
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

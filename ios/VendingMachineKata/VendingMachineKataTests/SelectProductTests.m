//
//  SelectProductTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinSlot.h"
#import "CoinBag.h"
#import "CoinBank.h"
#import "CoinData.h"
#import "Inventory.h"
#import "Display.h"
#import "NSDecimalNumber+Currency.h"
#import "Notifications.h"

/**
 Select Product
 
 As a vendor
 I want customers to select products
 So that I can give them an incentive to put money in the machine
 
 There are three products: cola for $1.00, chips for $0.50, and candy for $0.65. When the respective button is pressed and enough money has been inserted, the product is dispensed and the machine displays THANK YOU. If the display is checked again, it will display INSERT COINS and the current amount will be set to $0.00. If there is not enough money inserted then the machine displays PRICE and the price of the item and subsequent checks of the display will display either INSERT COINS or the current amount as appropriate.
 */


@interface SelectProductTests : XCTestCase

@end

@implementation SelectProductTests

CoinSlot *coinSlot;
CoinBank *coinBank;
Inventory *inventory;
Display *display;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
    coinBank = [CoinBank new];
    inventory = [Inventory new];
    display = [Display new];
}

- (void)testItDispensesTheCorrectProductAndTheCustomerIsThanked {
    NSLog(@"** When the respective button is pressed and enough money has been inserted, the product is dispensed and the machine displays THANK YOU.");
    
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:3];
    
    [inventory addItem:kInventoryItemCandy quantity:1];
    
    [self dropCoin:kCoinTypeQuarter amount:2];
    [self dropCoin:kCoinTypeDime amount:1];
    [self dropCoin:kCoinTypeNickel amount:1];
    
    [inventory selectItem:kInventoryItemCandy];;
    
    NSString *text = display.text;
    XCTAssert([text isEqualToString:kDisplayTextThankYou], @"*** Customer was not thanked!  Display shows %@ instead", text);
}

- (void)testItDisplaysTheCorrectMessageWhenCheckedAgainAfterPurchaseAndTheCreditIsResetToZero {
    NSLog(@"** If the display is checked again, it will display INSERT COINS and the current amount will be set to $0.00.");
    
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:3];
    
    [inventory addItem:kInventoryItemCandy quantity:1];
    
    NSDecimalNumber *decimalZero = [NSDecimalNumber zero];
    
    [self dropCoin:kCoinTypeQuarter amount:2];
    [self dropCoin:kCoinTypeDime amount:1];
    [self dropCoin:kCoinTypeNickel amount:1];
    
    [inventory selectItem:kInventoryItemCandy];
    
    NSString *text = display.text;
    
    NSComparisonResult compare = [coinSlot.insertedCoins.value compare:decimalZero];
    
    XCTAssert([text isEqualToString:kDisplayTextThankYou], @"*** Customer was not thanked!  Display shows %@ instead", text);
    XCTAssertEqual(NSOrderedSame, compare, @"*** Inserted coin value was not reset after selection!  Expected %@ but got %@", decimalZero, coinSlot.insertedCoins.value);
    XCTAssert([self itDisplaysValidInitialValue], @"*** Display was not reset to valid initial value after dispensing item!");
}

- (void)testItDisplaysTheCorrectMessageWhenCheckedWithInsufficientCreditAndDisplasThePriceThenTheCorrectMessage {
    NSLog(@"** If there is not enough money inserted then the machine displays PRICE and the price of the item and subsequent checks of the display will display either INSERT COINS or the current amount as appropriate.");
    
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:3];
    
    NSString *expectedCreditText = @"$0.75";
    
    [inventory addItem:kInventoryItemCola quantity:1];
    
    NSString *priceString = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, @"$1.00"];
    
    [inventory selectItem:kInventoryItemCola];
    
    NSString *displayText = display.text;
    
    XCTAssert([priceString isEqualToString:displayText], @"*** Price was not displayed after selection!  Expected %@ but got %@", priceString, displayText);
    XCTAssert([self itDisplaysValidInitialValue], @"*** Display was not reset to valid initial value after selection!");
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    
    [inventory selectItem:kInventoryItemCola];
    
    displayText = display.text;
    
    XCTAssert([priceString isEqualToString:displayText], @"*** Price was not displayed after selection!  Expected %@ but got %@", priceString, displayText);
    
    displayText = display.text;
    
    XCTAssert([expectedCreditText isEqualToString:displayText], @"*** Credit was not displayed after selection!  Expected %@ but got %@", expectedCreditText, displayText);
}

#pragma mark - Helper Methods

- (BOOL)itDisplaysValidInitialValue {
    BOOL initialValueIsValid = NO;
    
    if ([display.text isEqualToString:kDisplayTextInsertCoin] || [display.text isEqualToString:kDisplayTextExactChangeOnly]) {
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

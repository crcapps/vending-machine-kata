//
//  SoldOutTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinSlot.h"
#import "CoinBag.h"
#import "CoinData.h"
#import "Inventory.h"
#import "Display.h"
#import "CoinBank.h"

/**
 Sold Out
 
 As a customer
 I want to be told when the item I have selected is not available
 So that I can select another item
 
 When the item selected by the customer is out of stock, the machine displays SOLD OUT. If the display is checked again, it will display the amount of money remaining in the machine or INSERT COIN if there is no money in the machine.
 */

@interface SoldOutTests : XCTestCase

@end

@implementation SoldOutTests

CoinSlot *coinSlot;
Inventory *inventory;
Display *display;
CoinBank *coinBank;

- (void)setUp {
    [super setUp];
    coinBank = [CoinBank new];
    coinSlot = [CoinSlot new];
    inventory = [Inventory new];
    display = [Display new];
}

- (void)testItDisplaysTheCorrectMessageWhenTheItemSelectedIsSoldOut {
    NSLog(@"** When the item selected by the customer is out of stock, the machine displays SOLD OUT.");
    
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:3];
    
    [self dropCoin:kCoinTypeQuarter amount:4];
    
    [inventory selectItem:kInventoryItemCola];
    
    NSString *displayText = [NSString stringWithString:display.text];
    
    XCTAssert([displayText isEqualToString:kDisplayTextSoldOut], @"*** Display shows wrong text!  Expected %@ but got %@", kDisplayTextSoldOut, displayText);
}

- (void)testItDisplaysTheCorrectMessageWhenCheckedAgainAfterASoldOutSelection {
    NSLog(@"** If the display is checked again, it will display the amount of money remaining in the machine or INSERT COIN if there is no money in the machine.");
    
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:3];
    
    [inventory selectItem:kInventoryItemCola];
    
    NSString *displayText = [NSString stringWithString:display.text];
    NSString *expectedCreditText = @"$1.00";
    
    XCTAssert([displayText isEqualToString:kDisplayTextSoldOut], @"*** Display shows wrong text!  Expected %@ but got %@", kDisplayTextSoldOut, displayText);
    
    XCTAssert([self itDisplaysValidInitialValue], @"*** Display was not reset to valid initial value after selection!");
    
    [self dropCoin:kCoinTypeQuarter amount:4];
    
    displayText = [NSString stringWithString:display.text];
    
    XCTAssert([displayText isEqualToString:expectedCreditText], @"*** Display doesn't show correct inserted credit.  Expected %@ but got %@", expectedCreditText, displayText);
    
    [inventory selectItem:kInventoryItemCola];
    
    displayText = [NSString stringWithString:display.text];
        
    XCTAssert([displayText isEqualToString:kDisplayTextSoldOut], @"*** Display shows wrong text!  Expected %@ but got %@", kDisplayTextSoldOut, displayText);
    
    displayText = [NSString stringWithString:display.text];
    XCTAssert([displayText isEqualToString:expectedCreditText], @"*** Display was not reset to inserted credit!  Expected %@ but got %@", expectedCreditText, displayText);
}

#pragma mark - Helper Methods

- (BOOL)itDisplaysValidInitialValue {
    BOOL initialValueIsValid = NO;
    
    if ([display.text isEqualToString:kDisplayTextInsertCoin]) {
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

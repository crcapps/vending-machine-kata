//
//  MakeChangeTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinSlot.h"
#import "CoinData.h"
#import "CoinBag.h"
#import "CoinBank.h"
#import "Inventory.h"
#import "NSDecimalNumber+Currency.h"

@interface MakeChangeTests : XCTestCase

@end

/**
 Make Change
 
 As a vendor
 I want customers to receive correct change
 So that they will use the vending machine again
 
 When a product is selected that costs less than the amount of money in the machine, then the remaining amount is placed in the coin return.
 */


@implementation MakeChangeTests

CoinSlot *coinSlot;
CoinBank *coinBank;
Inventory *inventory;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
    coinBank = [CoinBank new];
    inventory = [Inventory new];
}

- (void)testItReturnsTheCorrectChangeWhenCreditExceedsPriceOfSelection {
    NSLog(@"** When a product is selected that costs less than the amount of money in the machine, then the remaining amount is placed in the coin return.");
    
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:3];
    
    [inventory addItem:kInventoryItemCandy quantity:1];
    
    [self dropCoin:kCoinTypeQuarter amount:3];
    
    [inventory selectItem:kInventoryItemCandy];
    
    NSDecimalNumber *expectedChange = [NSDecimalNumber decimalNumberWithNumber:@0.10];
    NSComparisonResult compare = [expectedChange compare:coinSlot.returnedCoins.value];
    
    XCTAssertEqual(NSOrderedSame, compare, @"*** The wrong amount of change was dispensed.  Expected %@ but got %@", expectedChange.localizedCurrencyString, coinSlot.returnedCoins.localizedValueString);
}

#pragma mark - Helper Methods

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

//
//  InventoryTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/18/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Inventory.h"
#import "NSDecimalNumber+Currency.h"

@interface InventoryTests : XCTestCase

@end

@implementation InventoryTests

Inventory *inventory;

- (void)setUp {
    [super setUp];
    inventory = [Inventory new];
}

- (void)testItReturnsCorrectValueForSelectedItems {
    [inventory addItem:kInventoryItemCola quantity:1];
    [inventory addItem:kInventoryItemChips quantity:1];
    [inventory addItem:kInventoryItemCandy quantity:1];
    
    NSDecimalNumber *expectedColaValue = [NSDecimalNumber decimalNumberWithNumber:@1.00];
    NSDecimalNumber *expectedChipsValue = [NSDecimalNumber decimalNumberWithNumber:@0.50];
    NSDecimalNumber *expectedCandyValue = [NSDecimalNumber decimalNumberWithNumber:@0.65];
    
    NSDecimalNumber *actualColaValue = [inventory selectItem:kInventoryItemCola];
    NSDecimalNumber *actualChipsValue = [inventory selectItem:kInventoryItemChips];
    NSDecimalNumber *actualCandyValue = [inventory selectItem:kInventoryItemCandy];
    
    NSComparisonResult colaCompare = [expectedColaValue compare:actualColaValue];
    NSComparisonResult chipsCompare = [expectedChipsValue compare:actualChipsValue];
    NSComparisonResult candyCompare = [expectedCandyValue compare:actualCandyValue];
    
    XCTAssertEqual(NSOrderedSame, colaCompare, @"*** Selecting Cola gave the wrong price.  Expected %@ but got %@", expectedColaValue, actualColaValue);
    XCTAssertEqual(NSOrderedSame, chipsCompare, @"*** Selecting Chips gave the wrong price.  Expected %@ but got %@", expectedChipsValue, actualChipsValue);
    XCTAssertEqual(NSOrderedSame, candyCompare, @"*** Selecting Candy gave the wrong price.  Expected %@ but got %@", expectedCandyValue, actualCandyValue);
    XCTAssertThrows([inventory selectItem:NSIntegerMax], @"*** Selecting an invalid item did not throw an error,");
}

@end

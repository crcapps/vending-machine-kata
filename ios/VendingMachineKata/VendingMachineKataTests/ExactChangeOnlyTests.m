//
//  ExactChangeOnlyTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Display.h"
#import "CoinBank.h"
#import "CoinData.h"
#import "CoinBag.h"

/**
 Exact Change Only
 
 As a customer
 I want to be told when exact change is required
 So that I can determine if I can buy something with the money I have before inserting it
 
 When the machine is not able to make change with the money in the machine for any of the items that it sells, it will display EXACT CHANGE ONLY instead of INSERT COINS.
 */

@interface ExactChangeOnlyTests : XCTestCase

@end

@implementation ExactChangeOnlyTests

Display *display;
CoinBank *coinBank;

- (void)setUp {
    [super setUp];
    display = [Display new];
    coinBank = [CoinBank new];
}

- (void)testItDisplaysTheCorrectMessageForAbilityToMakeChangeForAnyItem {
    NSLog(@"** When the machine is not able to make change with the money in the machine for any of the items that it sells, it will display EXACT CHANGE ONLY instead of INSERT COINS.");
    [coinBank.bankedCoins addCoin:[CoinData quarter] amount:1];
    NSString *displayText = [NSString stringWithString:display.text];
    XCTAssert([displayText isEqualToString:kDisplayTextExactChangeOnly], @"Display shows wrong test when bank cannot make change.  Expected %@ but got %@", kDisplayTextExactChangeOnly, displayText);
}

@end

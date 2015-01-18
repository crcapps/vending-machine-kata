//
//  CoinBankTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/18/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinBank.h"
#import "CoinData.h"
#import "CoinBag.h"
#import "NSDecimalNumber+Currency.h"

@interface CoinBankTests : XCTestCase

@end

@implementation CoinBankTests

CoinBank *coinBank;

- (void)setUp {
    [super setUp];
    coinBank = [CoinBank new];
}

- (void)testCanMakeChangeForAnything {
    CoinBag *bag = [CoinBag new];
    XCTAssertFalse(coinBank.canMakeChangeForAnything, @"*** Coin bank can somehow make change when empty!");
    [coinBank.bankedCoins addCoin:[CoinData dime] amount:1];
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:2];
    XCTAssert(coinBank.canMakeChangeForAnything, @"*** Coin bank can't make change when sufficient coinage banked!");
    [coinBank.bankedCoins emptyInto:bag];
    [coinBank.bankedCoins addCoin:[CoinData dime] amount:2];
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:1];
    XCTAssert(coinBank.canMakeChangeForAnything, @"*** Coin bank can't make change when sufficient coinage banked!");
    [coinBank.bankedCoins emptyInto:bag];
    [coinBank.bankedCoins addCoin:[CoinData nickel] amount:3];
    XCTAssert(coinBank.canMakeChangeForAnything, @"*** Coin bank can't make change when sufficient coinage banked!");
}

@end

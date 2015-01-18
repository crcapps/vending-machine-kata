//
//  CoinSlotTests.m
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

@interface CoinSlotTests : XCTestCase

@end

@implementation CoinSlotTests

CoinSlot *coinSlot;

- (void)setUp {
    [super setUp];
    coinSlot = [CoinSlot new];
}

- (void)testItReturnsCorrectCountForAcceptedCoins {
    [self dropCoin:kCoinTypeQuarter amount:2];
    [self dropCoin:kCoinTypeDime amount:2];
    [self dropCoin:kCoinTypeNickel amount:2];
    [self dropCoin:kCoinTypePenny amount:2];
    
    XCTAssertEqual(coinSlot.insertedCoins.coins, 6, @"*** Wrong number of coins accepted!  Expected %d but got %ld", 6, coinSlot.insertedCoins.coins);
}

- (void)testItReturnsCorrectCountForRejectedCoins {
    [self dropCoin:kCoinTypeNickel amount:2];
    [self dropCoin:kCoinTypePenny amount:2];
    
    XCTAssertEqual(coinSlot.insertedCoins.coins, 2, @"*** Wrong number of coins accepted!  Expected %d but got %ld", 2, coinSlot.insertedCoins.coins);
    XCTAssertEqual(coinSlot.returnedCoins.coins, 2, @"*** Wrong number of coins rejected!  Expected %d but got %ld", 2, coinSlot.returnedCoins.coins);
}

- (void)testItIgnoresInvalidCoins {
    [self dropCoin:kCoinTypeSlug amount:99];
    [self dropCoin:NSIntegerMax amount:99];
    
    XCTAssertEqual(coinSlot.insertedCoins.coins, 0, @"*** Wrong number of coins accepted!  Expected %d but got %ld", 0, coinSlot.insertedCoins.coins);
    XCTAssertEqual(coinSlot.returnedCoins.coins, 0, @"*** Wrong number of coins rejected!  Expected %d but got %ld", 0, coinSlot.returnedCoins.coins);
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

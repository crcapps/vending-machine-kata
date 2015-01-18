//
//  CoinDataTests.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CoinData.h"

@interface CoinDataTests : XCTestCase

@end

@implementation CoinDataTests

CoinData *coinData;

- (void)setUp {
    [super setUp];
    coinData = [CoinData new];
}

#pragma mark - Coin Recognition Tests

- (void)testItRecognizesQuarterAndReturnsCorrectObject {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@24.26 mass:@5.670 thickness:@1.75];
    
    XCTAssertEqual(kCoinTypeQuarter, coinData.coinType, "*** Quarter was not recognized! Recognizer returned %@ instead.", coinData.name);
    XCTAssertEqualObjects([CoinData quarter], coinData, @"*** Coin recognizer returned incorrect object!");
}

- (void)testItRecognizesDimeAndReturnsCorrectObject {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@17.91 mass:@2.268 thickness:@1.35];
    
    XCTAssertEqual(kCoinTypeDime, coinData.coinType, "*** Dime was not recognized! Recognizer returned %@ instead.", coinData.name);
    XCTAssertEqualObjects([CoinData dime], coinData, @"*** Coin recognizer returned incorrect object!");
}

- (void)testItRecognizesNickelAndReturnsCorrectObject {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@21.21 mass:@5.000 thickness:@1.95];
    
    XCTAssertEqual(kCoinTypeNickel, coinData.coinType, "*** Nickel was not recognized! Recognizer returned %@ instead.", coinData.name);
    XCTAssertEqualObjects([CoinData nickel], coinData, @"*** Coin recognizer returned incorrect object!");
}

- (void)testItRecognizesPennyAndReturnsCorrectObject {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@19.05 mass:@2.500 thickness:@1.52];
    
    XCTAssertEqual(kCoinTypePenny, coinData.coinType, "*** Penny was not recognized! Recognizer returned %@ instead.", coinData.name);
    XCTAssertEqualObjects([CoinData penny], coinData, @"*** Coin recognizer returned incorrect object!");
}

- (void)testItRecognizesSlugAndReturnsCorrectObject {
    CoinData *coinData = [CoinData identifyCoinForDiameter:@24.26 mass:@5.000 thickness:@1.52];
    
    XCTAssertEqual(kCoinTypeSlug, coinData.coinType, "*** Slug was not recognized! Recognizer returned %@ instead.", coinData.name);
    XCTAssertEqualObjects([CoinData slug], coinData, @"*** Coin recognizer returned incorrect object!");
}

- (void)testItReturnsSlugTypeForNilInputEdgeCase{
    CoinData *coinData = [CoinData identifyCoinForDiameter:nil mass:nil thickness:nil];
    
    XCTAssertEqual(kCoinTypeSlug, coinData.coinType, "*** Slug was not recognized! Recognizer returned %@ instead.", coinData.name);
    XCTAssertEqualObjects([CoinData slug], coinData, @"*** Coin recognizer returned incorrect object!");
}

@end

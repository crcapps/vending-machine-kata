//
//  CoinData.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Enumerates the types of coins recognized (or not) */
typedef NS_ENUM(NSInteger, CoinType) {
    kCoinTypeSlug,
    kCoinTypePenny,
    kCoinTypeNickel,
    kCoinTypeDime,
    kCoinTypeQuarter
};

/** Represents data about an identified coin */
@interface CoinData : NSObject

/** The type of coin */
@property (nonatomic)           CoinType    coinType;

/** The value of the coin */
@property (nonatomic)           NSDecimal   coinValue;

/** 
 Whether or not this coin is accepted by the machine
 Pennies and unrecognized, coin-like objects (AKA "slugs") by default.
 */
@property (nonatomic, readonly) BOOL        isAccepted;

/** Identify a coin given its physical characteristics and return the data for it */
+ (CoinData *)identifyCoinForDiameter:(NSNumber *)diameter mass:(NSNumber *)mass thickness:(NSNumber *)thickness;

/** Quarter singleton for NSCountedSet */
+ (CoinData *)quarter;

/** Dime singleton for NSCountedSet */
+ (CoinData *)dime;

/** Nickel singleton for NSCountedSet */
+ (CoinData *)nickel;

/** Penny singleton for NSCountedSet */
+ (CoinData *)penny;

/** Slug singleton for NSCountedSet */
+ (CoinData *)slug;

@end

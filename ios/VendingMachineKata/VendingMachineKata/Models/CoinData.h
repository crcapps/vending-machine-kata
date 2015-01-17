//
//  CoinData.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
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

/** The name of the coin */
@property (nonatomic, strong) NSString *name;

/** The type of coin */
@property (nonatomic) CoinType coinType;

/** The value of the coin */
@property (nonatomic) NSDecimal coinValue;

/**
 Whether or not this coin is accepted by the machine
 Pennies and unrecognized, coin-like objects (AKA "slugs") by default.
 */
@property (nonatomic, readonly) BOOL isAccepted;

/** Identify a coin given its physical characteristics and return the data for it */
+ (CoinData *)identifyCoinForDiameter:(NSNumber *)diameter mass:(NSNumber *)mass thickness:(NSNumber *)thickness;

/** Quarter singleton for CoinBag */
+ (CoinData *)quarter;

/** Dime singleton for CoinBag */
+ (CoinData *)dime;

/** Nickel singleton for CoinBag */
+ (CoinData *)nickel;

/** Penny singleton for CoinBag */
+ (CoinData *)penny;

/** Slug singleton for CoinBag */
+ (CoinData *)slug;

@end

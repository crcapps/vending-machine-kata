//
//  CoinRecognizer.h
//  VendingMachineKata
//
//  Created by CaseyRyanCapps on 1/7/15.
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
struct CoinData {
    CoinType coinType;
    NSDecimal coinValue;
    BOOL isAccepted;
};
typedef struct CoinData CoinData;

@interface CoinRecognizer : NSObject

/** Identify a coin given its physical characteristics and return the data for it */
+ (CoinData)identifyCoinForDiameter:(NSNumber *)diameter Mass:(NSNumber *)mass Thickness:(NSNumber *)thickness;

@end

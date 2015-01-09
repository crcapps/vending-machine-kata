//
//  CoinData.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinData.h"

@implementation CoinData

- (BOOL)isAccepted {
    // Reject pennies and slugs.
    BOOL isAccepted = (self.coinType != kCoinTypeSlug && self.coinType != kCoinTypePenny);
    return isAccepted;
}

+ (CoinData *)identifyCoinForDiameter:(NSNumber *)diameter mass:(NSNumber *)mass thickness:(NSNumber *)thickness {
    // Default to a slug to be careful.
    CoinType coinType = kCoinTypeSlug;
    
    CoinType diameterGuess = [self identifyCoinByDiameter:diameter];
    CoinType massGuess = [self identifyCoinBymass:mass];
    CoinType thicknessGuess = [self identifyCoinBythickness:thickness];
    
    // Consensus rules here.
    if (diameterGuess == massGuess && massGuess == thicknessGuess) {
        coinType = diameterGuess;  // Pick any at this point...
    }
    
    return [self platoCaveCoinForCoinType:coinType];
}

+ (CoinType)coinTypeForNumber:(NSNumber *)number {
    // We err on the side of caution and return a slug by default.
    CoinType coinType = kCoinTypeSlug;
    if (number != nil) {
        coinType = [number integerValue];
    }
    return coinType;
}

+ (CoinType)identifyCoinByDiameter:(NSNumber *)diameter {
    static NSDictionary *diameters = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        diameters = @{
                      @24.26 : @(kCoinTypeQuarter),
                      @17.91 : @(kCoinTypeDime),
                      @21.21 : @(kCoinTypeNickel),
                      @19.05 : @(kCoinTypePenny)
                      };
    });
    NSNumber *coinTypeNumber = [diameters objectForKey:diameter];
    return [self coinTypeForNumber:coinTypeNumber];
}

+ (CoinType)identifyCoinBymass:(NSNumber *)mass {
    static NSDictionary *masses = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        masses = @{
                   @5.670 : @(kCoinTypeQuarter),
                   @2.268 : @(kCoinTypeDime),
                   @5.000 : @(kCoinTypeNickel),
                   @2.500 : @(kCoinTypePenny)
                   };
    });
    NSNumber *coinTypeNumber = [masses objectForKey:mass];
    return [self coinTypeForNumber:coinTypeNumber];
}

+ (CoinType)identifyCoinBythickness:(NSNumber *)thickness {
    static NSDictionary *thicknesses = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thicknesses = @{
                        @1.75 : @(kCoinTypeQuarter),
                        @1.35 : @(kCoinTypeDime),
                        @1.95 : @(kCoinTypeNickel),
                        @1.52 : @(kCoinTypePenny)
                        };
    });
    NSNumber *coinTypeNumber = [thicknesses objectForKey:thickness];
    return [self coinTypeForNumber:coinTypeNumber];
}

+ (NSDecimal)valueForCoinType:(CoinType)coinType {
    static NSDictionary *values = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        values = @{
                   @(kCoinTypeSlug) : @0.00,
                   @(kCoinTypePenny) : @0.01,
                   @(kCoinTypeNickel) : @0.05,
                   @(kCoinTypeDime) : @0.10,
                   @(kCoinTypeQuarter) : @0.25
                   };
    });
    NSNumber *valueNumber = [values objectForKey : @(coinType)];
    if (valueNumber == nil) {
        valueNumber = @0.00;
    }
    return [valueNumber decimalValue];
}

/*
 "Pennies! Nickels! Quarters! Dimes!
 Come to us while there's still time!"
 -- The Sirens, when Disney's Duck Tales was trying to be Homer's Odyssey
 */

+ (CoinData *)quarter {
    static CoinData *platoCaveQuarter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        platoCaveQuarter = [CoinData new];
        platoCaveQuarter.coinType = kCoinTypeQuarter;
        platoCaveQuarter.coinValue = [self valueForCoinType:kCoinTypeQuarter];
    });
    return platoCaveQuarter;
}

+ (CoinData *)dime {
    static CoinData *platoCaveDime = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        platoCaveDime = [CoinData new];
        platoCaveDime.coinType = kCoinTypeDime;
        platoCaveDime.coinValue = [self valueForCoinType:platoCaveDime.coinType];
    });
    return platoCaveDime;
}

+ (CoinData *)nickel {
    static CoinData *platoCaveNickel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        platoCaveNickel = [CoinData new];
        platoCaveNickel.coinType = kCoinTypeNickel;
        platoCaveNickel.coinValue = [self valueForCoinType:platoCaveNickel.coinType];
    });
    return platoCaveNickel;
}

+ (CoinData *)penny {
    static CoinData *platoCavePenny = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        platoCavePenny = [CoinData new];
        platoCavePenny.coinType = kCoinTypePenny;
        platoCavePenny.coinValue = [self valueForCoinType:platoCavePenny.coinType];
    });
    return platoCavePenny;
}

+ (CoinData *)slug {
    // I only made this method so I could go:
    // PLATO'S CAVE SLUG! IT'S COMING RIGHT FOR US! AAAHHH~
    // or
    // <DAVIDATTENBOROUGHORSTEPHENFRY>
    // ... and here we have the rare and reclusive Plato's Cave Slug...
    // </DAVIDATTENBOROUGHORSTEPHENFRY>
    static CoinData *platoCaveSlug = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        platoCaveSlug = [CoinData new];
        platoCaveSlug.coinType = kCoinTypeSlug;
        platoCaveSlug.coinValue = [self valueForCoinType:platoCaveSlug.coinType];
    });
    return platoCaveSlug;
}

+ (CoinData *)platoCaveCoinForCoinType:(CoinType)coinType {
    switch (coinType) {
        case kCoinTypeQuarter:
            return [self quarter];
        case kCoinTypeDime:
            return [self dime];
        case kCoinTypeNickel:
            return [self nickel];
        case kCoinTypePenny:
            return [self penny];
        default:
            return [self slug];
    }
}

@end

//
//  CoinSlot.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoinBag;

@interface CoinSlot : NSObject

/** Represents the collection of coins inserted into the slot */
@property (nonatomic, strong, readonly) CoinBag *insertedCoins;

/** Represents the collection of coins ejected into the return tray */
@property (nonatomic, strong, readonly) CoinBag *returnedCoins;

/** Represents a coin being dropped into the slot,
 reading the diameter and mass from hardware.
 */
- (void)dropCoinWithDiameter:(NSNumber *)diameter mass:(NSNumber *)mass thickness:(NSNumber *)thickness;

@end

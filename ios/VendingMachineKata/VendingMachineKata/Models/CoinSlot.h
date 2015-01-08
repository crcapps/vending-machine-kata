//
//  CoinSlot.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoinSlot : NSObject

/** The current total value of the inserted coins */
@property (nonatomic, strong, readonly) NSDecimalNumber  *currentTotalValue;

/** Represents the collection of coins inserted into the slot */
@property (nonatomic, strong, readonly) NSCountedSet *insertedCoins;

/** Represents a coin being dropped into the slot,
 reading the diameter and mass from hardware.
 Returns the value of the coin.
 */
- (NSDecimalNumber *)dropCoinWithDiameter:(NSNumber *)diameter Mass:(NSNumber *)mass Thickness:(NSNumber *)thickness;

@end

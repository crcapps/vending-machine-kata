//
//  NSCountedSet+CoinValue.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCountedSet (CoinValue)

/** Gives the value of all the coins in the bag
 This method is strongly typed and ignores all the
 gum wrappers and stuff people stick into the slot
 */
- (NSDecimalNumber *)value;

/** Counts all the coins in the bag and ignores the cruft. */
- (NSInteger)coins;

@end

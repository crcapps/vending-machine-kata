//
//  CoinBag.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/9/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoinData.h"

/** I really, really wanted to use NSCountedSet, I really did. :,(
 Oh well, doing this the old fashioned way. :\
 At least I had fun exploring a new data structure. :|
 */

@interface CoinBag : NSObject

/** Gives the value of all the coins in the bag
 */
- (NSDecimalNumber *)value;

/** Gives the string representation of the coins value
 formatted as a localized currency string.
 */
- (NSString *)valueText;

/** Counts all the coins in the bag. */
- (NSInteger)coins;

/** dumps all the coins from one bag into another UNSAFE DOESN'T CHECK ANYTHING */
- (void)emptyInto:(CoinBag *)bag;

/** adds a coin to the bag checking to see if it is accepted first
 DOES NOT CHECK SIGN OR BOUNDS
 */
- (void)addCoin:(CoinData *)coin;

/** adds some coins of a single type to the bag checking to see if it is accepted first
 DOES NOT CHECK SIGN OR BOUNDS
 */
- (void)addCoin:(CoinData *)coin amount:(NSInteger)amount;

/** removes some coins from the bag.  DOES NOT CHECK SIGN OR BOUNDS */
- (void)removeCoin:(CoinData *)coin;

/** The count of quarters in the bag. */
@property (nonatomic, readonly) NSInteger           quarters;

/** The count of nickels in the bag. */
@property (nonatomic, readonly) NSInteger           nickels;

/** The count of dimes in the bag. */
@property (nonatomic, readonly) NSInteger           dimes;

/** The count of pennies in the bag. */
@property (nonatomic, readonly) NSInteger           pennies;

/** The value of quarters in the bag. */
@property (nonatomic, readonly) NSDecimalNumber     *quartersValue;

/** The value of nickels in the bag. */
@property (nonatomic, readonly) NSDecimalNumber     *nickelsValue;

/** The value of dimes in the bag. */
@property (nonatomic, readonly) NSDecimalNumber     *dimesValue;

/** The value of the pennies in the bag. */
@property (nonatomic, readonly) NSDecimalNumber     *penniesValue;

@end

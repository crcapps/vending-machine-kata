//
//  CoinBag.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

// Realized the release message being sent when removing last of kind was probably why NSCountedSet was failing.

#import <Foundation/Foundation.h>

@class CoinData;

@interface CoinBag : NSObject

/** Gives the value of all the coins in the bag */
@property (nonatomic, strong, readonly) NSDecimalNumber *value;

/** Gives the string representation of the coins value
 formatted as a localized currency string.
 */
@property (nonatomic, strong, readonly) NSString *localizedValueString;

/** Counts all the coins in the bag. */
@property (nonatomic, readonly) NSInteger coins;

/** The count of quarters in the bag. */
@property (nonatomic, readonly) NSInteger quarters;

/** The count of nickels in the bag. */
@property (nonatomic, readonly) NSInteger nickels;

/** The count of dimes in the bag. */
@property (nonatomic, readonly) NSInteger dimes;

/** The count of pennies in the bag. */
@property (nonatomic, readonly) NSInteger pennies;

/** The value of quarters in the bag. */
@property (nonatomic, readonly) NSDecimalNumber *quartersValue;

/** The value of nickels in the bag. */
@property (nonatomic, readonly) NSDecimalNumber *nickelsValue;

/** The value of dimes in the bag. */
@property (nonatomic, readonly) NSDecimalNumber *dimesValue;

/** The value of the pennies in the bag. */
@property (nonatomic, readonly) NSDecimalNumber *penniesValue;

/** Transfers coins from one bag to another
 NOOP and returns NO if amount > available
 */
- (BOOL)transferCoin:(CoinData *)coin amount:(NSInteger)amount toBag:(CoinBag *)bag;

/** dumps all the coins from one bag into another */
- (void)emptyInto:(CoinBag *)bag;

/** adds some coins of a single type to the bag*/
- (void)addCoin:(CoinData *)coin amount:(NSInteger)amount;

/** Removes some coins from the bag.
 NOOP and returns NO if amount > available
 */
- (BOOL)removeCoin:(CoinData *)coin amount:(NSInteger)amount;

@end

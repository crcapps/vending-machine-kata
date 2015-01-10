//
//  Display.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoinBank;

extern NSString * const kDisplayTextInsertCoin;
extern NSString * const kDisplayTextThankYou;
extern NSString * const kDisplayTextPrice;
extern NSString * const kDisplayTextSoldOut;
extern NSString * const kDisplayTextExactChangeOnly;

@interface Display : NSObject

/** The text shown on the display */
@property (nonatomic, strong, readonly) NSString    *text;

@property (nonatomic, weak)             CoinBank    *bank;

- (instancetype)initWithBank:(CoinBank *)bank;

@end

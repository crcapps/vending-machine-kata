//
//  Display.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDisplayTextInsertCoin;
extern NSString * const kDisplayTextThankYou;
extern NSString * const kDisplayTextPrice;

@interface Display : NSObject

/** The text show on the display */
@property (nonatomic, strong, readonly) NSString    *text;

@end

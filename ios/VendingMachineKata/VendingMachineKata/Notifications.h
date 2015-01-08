//
//  Notifications.h
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Name of notification posted when a dropped coin is accepted */
extern NSString * const kNotificationCoinAccepted;

/** Name of notificaiton posted when an item is selected */
extern NSString * const kNotificationItemSelected;

/** Name of notificaiton posted when an item is selected with enough money inserted */
extern NSString * const kNotificationItemSelectedSufficientCredit;

/** Name of notification posted when an item is selected without enough money inserted */
extern NSString * const kNotificationItemSelectedInsufficientCredit;

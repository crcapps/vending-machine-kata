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

/** Name of notification posted when an item is selected but is not in stock */
extern NSString * const kNotificationItemSelectedOutOfStock;

/** Name of notification posted when an item is selected and is in stock */
extern NSString * const kNotificationItemSelectedInStock;

/** Name of notification posted when the purchase is completed */
extern NSString * const kNotificationPurchaseCompleted;

/** Name of the notification posted when the machine can't make change for a selection */
extern NSString * const kNotificationCannotMakeChangeForSelection;

/** Notification UserInfo key for price */
extern NSString * const kUserInfoKeyPrice;

/** Notification UserInfo key for credit */
extern NSString * const kUserInfoKeyCredit;

/** Notification UserInfo key for selected item */
extern NSString * const kUserInfoKeyItem;

/** Notification UserInfo key for change due */
extern NSString * const kUserInfoKeyChange;

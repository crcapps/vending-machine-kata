//
//  Notifications.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Notifications.h"

NSString * const kNotificationCoinAccepted = @"CoinWasAcceptedNotification";
NSString * const kNotificationItemSelected = @"ItemSelectedNotification";
NSString * const kNotificationItemSelectedSufficientCredit = @"SufficientCreditForSelectedItemNotification";
NSString * const kNotificationItemSelectedInsufficientCredit =  @"InsufficentCreditForSelectedItemNotification";
NSString * const kNotificationPurchaseCompleted = @"PurchaseCompletedNotification";
NSString * const kNotificationCannotMakeChangeForSelection = @"CannotMakeChangeForSelectionNotification";
NSString * const kNotificationCanMakeChangeForSelection = @"CanMakeChangeForSelectionNotification";
NSString * const kNotificationItemSelectedOutOfStock = @"SelectedItemOutOfStockNotification";
NSString * const kNotificationItemSelectedInStock = @"SelectedItemInStockNotification";
NSString * const kNotificationBankCoinsAndMakeChange = @"BankCoinsAndMakeChangeNotification";
NSString * const kNotificationChangeDispensed = @"DispensedChangeNotification";
NSString * const kNotificationCoinsReturned = @"CoinsReturnedNotification";
NSString * const kNotificationItemDispensed = @"ItemDispensedNotification";
NSString * const kUserInfoKeyText = @"text";
NSString * const kUserInfoKeyPrice = @"price";
NSString * const kUserInfoKeyCredit = @"credit";
NSString * const kUserInfoKeyItem = @"item";
NSString * const kUserInfoKeyChange = @"change";
NSString * const kUserInfoKeyCoins = @"coins";
NSString * const kUserInfoKeyQuantity = @"quantity";

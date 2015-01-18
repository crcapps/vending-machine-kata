//
//  Inventory.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/18/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Inventory.h"
#import "Notifications.h"
#import "NSDecimalNumber+Currency.h"

@interface Inventory ()

@end

@implementation Inventory

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canMakeChange:) name:kNotificationCanMakeChangeForSelection object:nil];
    }
    
    return self;
}

- (NSDictionary *)itemPrices {
    static NSDictionary *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = @{
                  @(kInventoryItemCola) : [NSDecimalNumber decimalNumberWithNumber:@1.00],
                  @(kInventoryItemChips) : [NSDecimalNumber decimalNumberWithNumber:@0.50],
                  @(kInventoryItemCandy) : [NSDecimalNumber decimalNumberWithNumber:@0.65]
                  };
    });
    
    return items;
}

- (NSDictionary *)itemNames {
    static NSDictionary *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = @{
                  @(kInventoryItemCola) : @"cola",
                  @(kInventoryItemChips) : @"chips",
                  @(kInventoryItemCandy) : @"candy"
                  };
    });
    
    return items;
}

- (NSMapTable *)itemQuantities {
    static NSMapTable *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = [@{
                   @(kInventoryItemCola) : @0,
                   @(kInventoryItemChips) : @0,
                   @(kInventoryItemCandy) : @0
                   } mutableCopy];
    });
    
    return items;
}

- (NSInteger)quantityForItem:(InventoryItem)item {
    NSInteger quantity = [[self.itemQuantities objectForKey:@(item)] integerValue];
    return quantity;
}

- (NSString *)nameForItem:(InventoryItem)item {
    NSString *name = [self.itemNames objectForKey:@(item)];
    return name;
}

- (void)addItem:(InventoryItem)item quantity:(NSInteger)quantity {
    if (quantity > 0 && [self.itemQuantities objectForKey:@(item)] != nil) {
        NSInteger onHand = [[self.itemQuantities objectForKey:@(item)] integerValue];
        onHand += quantity;
        [self.itemQuantities setObject:@(quantity) forKey:@(item)];
    }
}

- (NSDecimalNumber *)selectItem:(InventoryItem)item {
    NSDecimalNumber *itemPrice = [self.itemPrices objectForKey:@(item)];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kNotificationItemSelected
     object:self
     userInfo:@{
                kUserInfoKeyPrice : itemPrice,
                kUserInfoKeyItem : @(item),
                kUserInfoKeyQuantity : @([self quantityForItem:item]),
                kUserInfoKeyText : [self nameForItem:item]
                }];
    
    return itemPrice;
}

#pragma mark - Notification Handlers

- (void)canMakeChange:(NSNotification *)notification {
    InventoryItem item = [[notification.userInfo valueForKey:kUserInfoKeyItem] integerValue];
    NSString *itemString = [self.itemNames objectForKey:@(item)];
    NSInteger itemQuantity = [self quantityForItem:item];
    if (itemQuantity < 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationItemSelectedOutOfStock object:self userInfo:notification.userInfo];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationItemSelectedInStock object:self userInfo:notification.userInfo];
        itemQuantity--;
        [self.itemQuantities setObject:@(itemQuantity) forKey:@(item)];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kNotificationItemDispensed
         object:self
         userInfo:@{
                    kUserInfoKeyItem : @(item),
                    kUserInfoKeyText : itemString
                    }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

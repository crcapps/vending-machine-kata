//
//  Inventory.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Inventory.h"
#import "Notifications.h"

@implementation Inventory

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sufficientCredit:) name:kNotificationItemSelectedSufficientCredit object:nil];
    }
    
    return self;
}

- (NSDictionary *)itemPrices {
    static NSDictionary *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = @{
                  @(kInventoryItemCola) : [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]],
                  @(kInventoryItemChips) : [NSDecimalNumber decimalNumberWithDecimal:[@0.50 decimalValue]],
                  @(kInventoryItemCandy) : [NSDecimalNumber decimalNumberWithDecimal:[@0.65 decimalValue]]
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

- (void)addItem:(InventoryItem)item quantity:(NSInteger)quantity {
    if (quantity > 0) {
        NSInteger onHand = [[self.itemQuantities objectForKey:@(item)] integerValue];
        onHand += quantity;
        [self.itemQuantities setObject:@(quantity) forKey:@(item)];
    }
}

- (void)addItem:(InventoryItem)item {
    [self addItem:item quantity:1];
}

- (NSDictionary *)itemNames {
    static NSDictionary *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = @{
                  @(kInventoryItemCola) : @"Cola",
                  @(kInventoryItemChips) : @"Chips",
                  @(kInventoryItemCandy) : @"Candy"
                  };
    });
    
    return items;
}

- (NSDecimalNumber *)selectItem:(InventoryItem)item {
    NSDecimalNumber *itemPrice = [self.itemPrices objectForKey:@(item)];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kNotificationItemSelected
     object:self
     userInfo:@{
                kUserInfoKeyPrice : itemPrice,
                kUserInfoKeyItem : @(item)
                }];
    
    return itemPrice;
}

- (void)sufficientCredit:(NSNotification *)notification {
    InventoryItem item = [[notification.userInfo valueForKey:kUserInfoKeyItem] integerValue];
    [self dispenseProduct:item];
}

- (void)dispenseProduct:(InventoryItem)item {
    NSString *itemString = [self.itemNames objectForKey:@(item)];
    NSLog(@"Dispensed a %@", itemString);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

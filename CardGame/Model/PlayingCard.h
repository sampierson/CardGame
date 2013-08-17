//
//  PlayingCard.h
//  CardGame
//
//  Created by Sam Pierson on 8/17/13.
//  Copyright (c) 2013 Sam Pierson. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString * suit;
@property (nonatomic) NSInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end

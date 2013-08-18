//
//  PlayingCard.m
//  CardGame
//
//  Created by Sam Pierson on 8/17/13.
//  Copyright (c) 2013 Sam Pierson. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *)validSuits
{
  return @[@"♣", @"♥", @"♦", @"♠"];
}

+ (NSArray *)rankStrings
{
  return @[
    @"?", @"A", @"2", @"3", @"4", @"5",
    @"6", @"7", @"8", @"9", @"J", @"Q", @"K"
  ];
}

+ (NSUInteger)maxRank { return [self rankStrings].count - 1; }

- (void)setRank:(NSInteger)rank
{
  if (rank <= [PlayingCard maxRank]) {
    _rank = rank;
  }
}

@synthesize suit = _suit; // because we provide setter AND getter

- (void)setSuit:(NSString *)suit
{
  if ([[PlayingCard validSuits] containsObject:suit]) {
    _suit = suit;
  }
}

- (NSString *)suit
{
  return _suit ? _suit : @"?";
}

- (NSString *)contents
{
  return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards
{
  int score = 0;
  if ([otherCards count] == 1) {
    PlayingCard *otherCard = [otherCards lastObject];
    if ([otherCard.suit isEqualToString:self.suit]) {
      score = 1;
    } else if (otherCard.rank == self.rank) {
      score = 4;
    }
  }
  return score;
}

@end

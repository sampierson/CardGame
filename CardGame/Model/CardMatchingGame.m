//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Sam Pierson on 8/17/13.
//  Copyright (c) 2013 Sam Pierson. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
  self = [super init];
  if (self) {
    for (int i=0; i < count ; i++) {
      Card *card = [deck drawRandomCard];
      if (card) {
        self.cards[i] = card;
      } else {
        self = nil;
        break;
      }
    }
  }
  return self;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (NSString *)flipCardAtIndex:(NSUInteger)index{
  Card *card = [self cardAtIndex:index];
  NSString *message;
  if (card && !card.isUnplayable) {
    if (!card.isFaceUp) {
      for (Card *otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
          int matchScore = [card match:@[otherCard]];
          if (matchScore) {
            card.unplayable = YES;
            otherCard.unplayable = YES;
            self.score += matchScore * MATCH_BONUS;
            message = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",
                                card.contents, otherCard.contents, MATCH_BONUS];
          } else {
            otherCard.faceUp = NO;
            self.score -= MISMATCH_PENALTY;
            message = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty",
                       card.contents, otherCard.contents, MISMATCH_PENALTY];
          }
          break;
        }
      }
      self.score -= FLIP_COST;
    }
    if (!message) {
      if (card.isFaceUp) {
        message = @"";
      } else {
        message = [NSString stringWithFormat:@"Flipped up %@", card.contents];
      }
    }
    card.faceUp = !card.isFaceUp;
  }
  return message;
}

- (Card *)cardAtIndex:(NSUInteger)index{
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end

//
//  CardGameViewController.m
//  CardGame
//
//  Created by Sam Pierson on 8/17/13.
//  Copyright (c) 2013 Sam Pierson. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) NSInteger flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) UIImage *cardImage;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
  if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                        usingDeck:[[PlayingCardDeck alloc] init]];
  return _game;
}

- (UIImage *)cardImage
{
  if (!_cardImage) _cardImage = [UIImage imageNamed:@"playingCard.jpg"];
  return _cardImage;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
  _cardButtons = cardButtons;
  [self updateUI];
}

- (void)updateUI
{
  for (UIButton *cardButton in self.cardButtons) {
    Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    cardButton.selected = card.isFaceUp;
    if (cardButton.selected) {
      [cardButton setImage:nil forState:UIControlStateNormal];
    } else {
      [cardButton setImage:self.cardImage forState:UIControlStateNormal];
    }
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setFlipCount:(NSInteger)flipCount
{
  _flipCount = flipCount;
  self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", _flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
  NSString *message = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
  self.statusMessage.text = message;
  if (!sender.isSelected) self.flipCount++;
  [self updateUI];
}

@end

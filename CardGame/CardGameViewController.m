//
//  CardGameViewController.m
//  CardGame
//
//  Created by Sam Pierson on 8/17/13.
//  Copyright (c) 2013 Sam Pierson. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSInteger flipCount;

@end


@implementation CardGameViewController

- (void)setFlipCount:(NSInteger)flipCount
{
  _flipCount = flipCount;
  self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", _flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
  if (!sender.isSelected) {
    PlayingCardDeck *deck = [[PlayingCardDeck alloc] init];
    PlayingCard *card = (PlayingCard *)[deck drawRandomCard];
    [sender setTitle:[card contents] forState:UIControlStateSelected];
    self.flipCount++;
  }
  sender.selected = !sender.isSelected;
}

@end

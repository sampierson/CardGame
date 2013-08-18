//
//  Card.h
//  CardGame
//
//  Created by Sam Pierson on 8/17/13.
//  Copyright (c) 2013 Sam Pierson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString * contents;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;

- (int) match:(NSArray *)otherCards;
@end

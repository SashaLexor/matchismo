//
//  Card.h
//  Matchismo
//
//  Created by Lexor on 27.03.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *content;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnPlayable) BOOL unPlayable;

-(int)match: (NSArray *) otherCards;

@end

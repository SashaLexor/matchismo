//
//  Deck.h
//  Matchismo
//
//  Created by Lexor on 27.03.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

@property (strong,nonatomic) NSMutableArray *cards;

-(void)addCard:(Card *)card atTop: (BOOL) atTop;
-(Card *)drawRandomCard;

@end
 
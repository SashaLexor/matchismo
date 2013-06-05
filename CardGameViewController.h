//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Lexor on 27.03.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic) int startingCardCount; // ABSTRACT 
-(Deck *)createDeck; // ABSTRACT
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; //ABSTRACT

@end

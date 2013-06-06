//
//  SetViewConttrollerViewController.h
//  Matchismo
//
//  Created by Lexor on 12.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"
#import "SetGame.h"

@interface SetViewConttroller : UIViewController <UIAlertViewDelegate, UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *storyLable;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (strong, nonatomic) SetGame *game;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

- (IBAction)startNewGame;
+(NSArray *)validColor;
+(NSArray *)validShape;


@end

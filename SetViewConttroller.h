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

@interface SetViewConttroller : UIViewController <UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *storyLable;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayOfButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (strong, nonatomic) SetGame *game;

- (IBAction)startNewGame;
- (IBAction)flipCard:(UIButton *)sender;
+(NSArray *)validColor;
+(NSArray *)validShape;


@end

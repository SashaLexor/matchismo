//
//  SetViewConttrollerViewController.h
//  Matchismo
//
//  Created by Lexor on 12.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface SetViewConttroller : UIViewController

@property (nonatomic,strong)SetCard *card;
@property (weak, nonatomic) IBOutlet UILabel *storyLable;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrayOfButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

- (IBAction)startNewGame;

@end

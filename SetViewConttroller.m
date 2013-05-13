//
//  SetViewConttrollerViewController.m
//  Matchismo
//
//  Created by Lexor on 12.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "SetViewConttroller.h"
#import "SetDeck.h"

@interface SetViewConttroller ()

@property (nonatomic) SetDeck *deck;

@end

@implementation SetViewConttroller

-(SetDeck *)deck
{
    if (!_deck)
    {
        _deck = [[SetDeck alloc]init];
    }
    return _deck;
}

+(NSArray *)validColor
{
    return @[[UIColor greenColor], [UIColor redColor], [UIColor blueColor]];
}

+(NSArray *)validShape
{
    return @[@"■ ", @"▲ ", @"● "];
}

-(NSAttributedString *)contentOfCardAtIndex:(int) index
{
    float alpha = 0.0;
    NSMutableString *str = [NSMutableString stringWithString:[SetViewConttroller validShape][self.card.shape]];
    
    for (int i = 0; i < self.card.amount-1; i++)
    {
        str = [[str stringByAppendingString:[SetViewConttroller validShape][self.card.shape]]mutableCopy];
    }
    
    if (self.card.shade == 0) alpha = 0.0;
    if (self.card.shade == 1) alpha = 0.2;
    if (self.card.shade == 2) alpha = 1.0;
    
        
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : [[SetViewConttroller validColor][self.card.color]colorWithAlphaComponent:alpha], NSStrokeWidthAttributeName : @-8,NSStrokeColorAttributeName : [SetViewConttroller validColor][self.card.color]}]; // need setter for shape property
    return content;
}

-(SetCard *)card
{
    if (!_card)
    {
        _card = [[SetCard alloc]initWithDefault];
    }
    return _card;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)startNewGame
{
    self.card = [self.deck drawRandomCard];
    self.storyLable.attributedText = [self contentOfCardAtIndex:0];
    
}
@end

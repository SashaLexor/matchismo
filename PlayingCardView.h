//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Lexor on 04.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"


@interface PlayingCardView : CardView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

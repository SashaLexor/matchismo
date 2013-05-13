//
//  SetCard.h
//  Matchismo
//
//  Created by Lexor on 12.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetCard : NSObject

@property (nonatomic) int color;
@property (nonatomic) int shape;
@property (nonatomic) int amount;
@property (nonatomic) int shade;

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnPlayable) BOOL unPlayable;

+(int) maxAmount;
+(int) maxShade;
+(int) maxColor;
+(int) maxShape;

-(id)initWithDefault;


@end

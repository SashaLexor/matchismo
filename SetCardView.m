//
//  SetCardView.m
//  SuperCard
//
//  Created by Lexor on 28.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

-(void)setup
{
    //do initialization here
    self.shape = 2;
    self.amount = 3;
    self.color = 1;
    self.shade = 1;
    self.faceUp = YES;
}

-(void)awakeFromNib  // метод который вызывается автоматически после инициализации объектов из NIB-файла,
{                    //используется для конфигурирования объекта после создания аутлетов и actions
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [super drawRect:rect];
    
    [self drawShape: self.shape amount: self.amount color: self.color shade: self.shade];
   
    
   }

+(NSArray *)validAlpha
{
    return @[@0.0 , @0.25, @1.0];
}

+(NSArray *)validColor
{
    return @[[UIColor greenColor], [UIColor redColor], [UIColor blueColor]];
}

-(void)drawShape: (int) shape amount: (int) amount color: (int) color shade: (int) shade
{
    float alpha = [[SetCardView validAlpha][self.shade]floatValue];
    UIColor *strokeColor = [SetCardView validColor][self.color];
    UIColor *fillColor = [strokeColor colorWithAlphaComponent:alpha];

    
    float boundsX = self.bounds.size.width/100;
    float boundsY = self.bounds.size.height/100;
    
    if (self.shape == 0)
    {
        int plusY = 0;
        
        if (self.amount == 3)
        {
            for (int i = 0; i < self.amount; i++)
            {
                
                
                UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(15 * boundsX, 15 * boundsY + plusY, 70 * boundsX, 20 * boundsY) cornerRadius: 10 * boundsY];
                
                aPath.lineWidth = 2.0 ;
                
                [fillColor setFill];
                [strokeColor setStroke];
                
                [aPath stroke];
                [aPath fill];
                
                plusY = plusY + 25 * boundsY;
            }
        }
        else if (self.amount == 2)
        {
            for (int i = 0; i < self.amount; i++)
            {
                
                
                UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(15 * boundsX, 27 * boundsY + plusY, 70 * boundsX, 20 * boundsY) cornerRadius: 10 * boundsY];
                
                aPath.lineWidth = 2.0 ;
                
                [fillColor setFill];
                [strokeColor setStroke];
                
                [aPath stroke];
                [aPath fill];
                
                plusY = plusY + 25 * boundsY;
            }
        }
        else if (self.amount == 1)
        {
            UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(15 * boundsX, 40 * boundsY + plusY, 70 * boundsX, 20 * boundsY) cornerRadius: 10 * boundsY];
            
            aPath.lineWidth = 2.0 ;
            
            [fillColor setFill];
            [strokeColor setStroke];
            
            [aPath stroke];
            [aPath fill];

            
        }
    }
    else if (self.shape == 1)
    {
        int plusY = 0;

        if (self.amount == 1)
        {
            int startY = 40 * boundsY;
            int startX = 50 * boundsX;
            
            UIBezierPath *path = [[UIBezierPath alloc]init];
            
            [path moveToPoint:CGPointMake(startX, startY)];
            
            [path addLineToPoint:CGPointMake(startX + 35 * boundsX, startY + 10 * boundsY)];
            [path addLineToPoint:CGPointMake(startX, startY + 20 * boundsY)];
            [path addLineToPoint:CGPointMake(startX - 35 * boundsX, startY + 10 * boundsY)];
            [path closePath];
            
            [fillColor setFill];
            [strokeColor setStroke];
            
            [path stroke];
            [path fill];
        }
        else if (self.amount == 2)
        {
            for (int i = 0; i < self.amount; i++)
            {
                int startY = 27 * boundsY + plusY;
                int startX = 50 * boundsX;
                
                UIBezierPath *path = [[UIBezierPath alloc]init];
                
                [path moveToPoint:CGPointMake(startX, startY)];
                
                [path addLineToPoint:CGPointMake(startX + 35 * boundsX, startY + 10 * boundsY)];
                [path addLineToPoint:CGPointMake(startX, startY + 20 * boundsY)];
                [path addLineToPoint:CGPointMake(startX - 35 * boundsX, startY + 10 * boundsY)];
                [path closePath];
                
                [fillColor setFill];
                [strokeColor setStroke];
                
                [path stroke];
                [path fill];

                plusY = plusY + 25 * boundsY;
            }
        }
        else if (self.amount == 3)
        {
            for (int i = 0; i < self.amount; i++)
            {
                int startY = 15 * boundsY + plusY;
                int startX = 50 * boundsX;
                
                UIBezierPath *path = [[UIBezierPath alloc]init];
                
                [path moveToPoint:CGPointMake(startX, startY)];
                
                [path addLineToPoint:CGPointMake(startX + 35 * boundsX, startY + 10 * boundsY)];
                [path addLineToPoint:CGPointMake(startX, startY + 20 * boundsY)];
                [path addLineToPoint:CGPointMake(startX - 35 * boundsX, startY + 10 * boundsY)];
                [path closePath];
                
                [fillColor setFill];
                [strokeColor setStroke];
                
                [path stroke];
                [path fill];
                
                plusY = plusY + 25 * boundsY;
            }
        }
        
        

        
    }
    else if (self.shape == 2)
    {
        int plusY = 0;
        
        if (self.amount == 1)
        {
            int startY = 50 * boundsY;
            int startX = 15 * boundsX;
            
            UIBezierPath *path = [[UIBezierPath alloc]init];
            
            [path moveToPoint:CGPointMake(startX, startY)];
            
            [path addCurveToPoint:CGPointMake(startX + 70 * boundsX, startY - 5 * boundsY) controlPoint1:CGPointMake(startX + 30 * boundsX, startY - 30 * boundsY) controlPoint2:CGPointMake(startX + 40 * boundsX, startY + 10 * boundsY)];
            [path addCurveToPoint:CGPointMake(startX, startY) controlPoint1: CGPointMake(startX + 40 * boundsX, startY + 30 * boundsY) controlPoint2:CGPointMake(startX + 30 * boundsX, startY - 10 * boundsY)];
            
            [fillColor setFill];
            [strokeColor setStroke];
            
            [path stroke];
            [path fill];

        }
        else if (self.amount == 2)
        {
            for (int i = 0; i < self.amount; i++)
            {
                int startY = 40 * boundsY + plusY;
                int startX = 15 * boundsX;
                
                UIBezierPath *path = [[UIBezierPath alloc]init];
                
                [path moveToPoint:CGPointMake(startX, startY)];
                
                [path addCurveToPoint:CGPointMake(startX + 70 * boundsX, startY - 5 * boundsY) controlPoint1:CGPointMake(startX + 30 * boundsX, startY - 30 * boundsY) controlPoint2:CGPointMake(startX + 40 * boundsX, startY + 10 * boundsY)];
                [path addCurveToPoint:CGPointMake(startX, startY) controlPoint1: CGPointMake(startX + 40 * boundsX, startY + 30 * boundsY) controlPoint2:CGPointMake(startX + 30 * boundsX, startY - 10 * boundsY)];
                
                [fillColor setFill];
                [strokeColor setStroke];
                
                [path stroke];
                [path fill];
                
                plusY = plusY + 25 * boundsY;
            }
        }
        else if (self.amount == 3)
        {
            for (int i = 0; i < self.amount; i++)
            {
                int startY = 27 * boundsY + plusY;
                int startX = 15 * boundsX;
                
                UIBezierPath *path = [[UIBezierPath alloc]init];
                
                [path moveToPoint:CGPointMake(startX, startY)];
                
                [path addCurveToPoint:CGPointMake(startX + 70 * boundsX, startY - 5 * boundsY) controlPoint1:CGPointMake(startX + 30 * boundsX, startY - 30 * boundsY) controlPoint2:CGPointMake(startX + 40 * boundsX, startY + 10 * boundsY)];
                [path addCurveToPoint:CGPointMake(startX, startY) controlPoint1: CGPointMake(startX + 40 * boundsX, startY + 30 * boundsY) controlPoint2:CGPointMake(startX + 30 * boundsX, startY - 10 * boundsY)];
                
                [fillColor setFill];
                [strokeColor setStroke];
                
                [path stroke];
                [path fill];
                
                plusY = plusY + 25 * boundsY;
            }

        }
            
    }
    
}

@end

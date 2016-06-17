//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Devesh Shetty on 17/06/16.
//  Copyright © 2016 Devesh Shetty. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

#pragma mark - Properties
//indicates I will override the setter as well as the getter
@synthesize  faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

- (CGFloat)faceCardScaleFactor
{
    if(!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

-(void)setRank:(NSUInteger)rank{
    _rank = rank;
    //redraw when the value is changed
    [self setNeedsDisplay];
}

-(void)setSuit:(NSString *)suit{
    
    _suit = suit;
    //redraw
    [self setNeedsDisplay];
}

-(void)setFaceUp:(BOOL)faceUp{
    
    _faceUp = faceUp;
    //redraw
    [self setNeedsDisplay];
    
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;}
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor];}
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }


-(void)drawRect:(CGRect)rect{
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    //only draw interior to the rect, so we add a clip
    [roundedRect addClip];
    
    //set the fill color
    [[UIColor whiteColor] setFill];
    //fill the color
    UIRectFill(self.bounds);
    //set the stroke color
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    //UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"img1"]];
    
    if(self.faceUp){
        if( faceImage ){
            CGRect imageRect = CGRectInset(self.bounds,
                                       self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                       self.bounds.size.width * (1.0 - self.faceCardScaleFactor) );
            [faceImage drawInRect:imageRect];
        }else{
            [self drawPips];
        }
    
        [self drawCorners];
    }
    else{
        [[UIImage imageNamed: @"cardback"] drawInRect:self.bounds];
    }
}

- (void) drawPips{
}

- (NSString *)rankAsString{
    return @[@"?", @"A",@"2"][self.rank];
}

- (void)drawCorners{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize: cornerFont.pointSize * [self cornerScaleFactor]];
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes: @{NSFontAttributeName: cornerFont, NSParagraphStyleAttributeName: paragraphStyle}];
    
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect: textBounds];
    
    //draw it at bottom corner in a rotated format
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
}

#pragma mark - Initialization
- (void)setUp{
    self.backgroundColor = nil;
    self.opaque = NO;
    //redraw when view's bounds changes like when the screen rotates
    self.contentMode = UIViewContentModeRedraw;
    
    
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    [self setUp];
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    return self;
}


@end

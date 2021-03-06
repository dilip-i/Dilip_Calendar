//
//  FSCalendarCell.m
//  Pods
//
//  Created by Wenchao Ding on 12/3/15.
//
//

#import "FSCalendarCell.h"
#import "FSCalendar.h"
#import "FSCalendarExtensions.h"
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarConstants.h"

@interface FSCalendarCell ()

@property (readonly, nonatomic) UIColor *colorForCellFill;
//@property (assign, nonatomic) UIColor *colorForTitleLabel;
//@property (assign, nonatomic) UIColor *colorForUnselectedBar;
//@property (assign, nonatomic) UIColor *colorForSelectedBar;
@property (readonly, nonatomic) UIColor *colorForNoWorkBar;
@property (readonly, nonatomic) UIColor *colorForCellBorder;
@property (readonly, nonatomic) CGFloat borderRadius;

@end

@implementation FSCalendarCell

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{   
    CAShapeLayer *shapeLayer;
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 1.0;
    shapeLayer.borderColor = [UIColor clearColor].CGColor;
    shapeLayer.opacity = 0;
    [self.contentView.layer insertSublayer:shapeLayer below:_titleLabel.layer];
    self.shapeLayer = shapeLayer;
    
    
    self.clipsToBounds = NO;
    self.contentView.clipsToBounds = NO;
//    self.barSelectedView.translatesAutoresizingMaskIntoConstraints = NO;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleHeight = self.bounds.size.height;
    CGFloat diameter = MIN(self.bounds.size.height,self.bounds.size.width);
    diameter = diameter > FSCalendarStandardCellDiameter ? (diameter - (diameter-FSCalendarStandardCellDiameter)*0.5) : diameter;
    _shapeLayer.frame = CGRectMake((self.bounds.size.width-diameter)/2,
                                   (titleHeight-diameter)/2,
                                   diameter,
                                   diameter);

    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:_shapeLayer.bounds cornerRadius:CGRectGetWidth(_shapeLayer.bounds)*0.5*self.borderRadius].CGPath;
    if (!CGPathEqualToPath(_shapeLayer.path,path)) {
        _shapeLayer.path = path;
    }

//    CGFloat eventSize = _shapeLayer.frame.size.height/6.0;
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    if (self.window) { // Avoid interrupt of navigation transition somehow
        [CATransaction setDisableActions:YES]; // Avoid blink of shape layer.
    }
//    self.shapeLayer.opacity = 0;
//    [self.contentView.layer removeAnimationForKey:@"opacity"];
}

#pragma mark - Public

- (void)performSelecting
{
//    _shapeLayer.opacity = 1;
//
//#define kAnimationDuration FSCalendarDefaultBounceAnimationDuration
//
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    CABasicAnimation *zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    zoomOut.fromValue = @0.3;
//    zoomOut.toValue = @1.2;
//    zoomOut.duration = kAnimationDuration/4*3;
//    CABasicAnimation *zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    zoomIn.fromValue = @1.2;
//    zoomIn.toValue = @1.0;
//    zoomIn.beginTime = kAnimationDuration/4*3;
//    zoomIn.duration = kAnimationDuration/4;
//    group.duration = kAnimationDuration;
//    group.animations = @[zoomOut, zoomIn];
//    [_shapeLayer addAnimation:group forKey:@"bounce"];
    [self configureAppearance];
//
//#undef kAnimationDuration
    
}

#pragma mark - Private

- (void)configureAppearance
{
    if(self.isSelected){
        UIColor *textColor = self.colorForSelectedTitleLabel;
        if (![textColor isEqual:_titleLabel.textColor]) {
            _titleLabel.textColor = textColor;
        }
    }else{
        UIColor *textColor = self.colorForTitleLabel;
        if (![textColor isEqual:_titleLabel.textColor]) {
            _titleLabel.textColor = textColor;
        }
    }
//    UIColor *textColor = self.colorForTitleLabel;
//    if (![textColor isEqual:_titleLabel.textColor]) {
//        _titleLabel.textColor = textColor;
//    }
//    UIFont *titleFont = self.calendar.appearance.titleFont;
//    if (![titleFont isEqual:_titleLabel.font]) {
//        _titleLabel.font = titleFont;
//    }
    
    UIColor *borderColor = self.colorForCellBorder;
    UIColor *fillColor = self.colorForCellFill;
    
    BOOL shouldHideShapeLayer = !self.selected && !self.dateIsToday && !borderColor && !fillColor;
    
    if (_shapeLayer.opacity == shouldHideShapeLayer) {
        _shapeLayer.opacity = !shouldHideShapeLayer;
    }
    if (!shouldHideShapeLayer) {
        
        CGColorRef cellFillColor = self.colorForCellFill.CGColor;
        if (!CGColorEqualToColor(_shapeLayer.fillColor, cellFillColor)) {
            _shapeLayer.fillColor = cellFillColor;
        }
        
        CGColorRef cellBorderColor = self.colorForCellBorder.CGColor;
        if (!CGColorEqualToColor(_shapeLayer.strokeColor, cellBorderColor)) {
            _shapeLayer.strokeColor = cellBorderColor;
        }
        
        CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:_shapeLayer.bounds
                                                    cornerRadius:CGRectGetWidth(_shapeLayer.bounds)*0.5*self.borderRadius].CGPath;
        if (!CGPathEqualToPath(_shapeLayer.path, path)) {
            _shapeLayer.path = path;
        }
        
    }
    
    _barUnselectedView.backgroundColor = self.colorForUnselectedBar;
    _barSelectedView.backgroundColor = self.colorForSelectedBar;
    
    
}

- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary
{
    if (self.isSelected) {
        if (self.dateIsToday) {
            return dictionary[@(FSCalendarCellStateSelected|FSCalendarCellStateToday)] ?: dictionary[@(FSCalendarCellStateSelected)];
        }
        return dictionary[@(FSCalendarCellStateSelected)];
    }
    if (self.dateIsToday && [[dictionary allKeys] containsObject:@(FSCalendarCellStateToday)]) {
        return dictionary[@(FSCalendarCellStateNormal)]; //FSCalendarCellStateToday
    }
    if (self.placeholder && [[dictionary allKeys] containsObject:@(FSCalendarCellStatePlaceholder)]) {
        return dictionary[@(FSCalendarCellStatePlaceholder)];
    }
    if (self.weekend && [[dictionary allKeys] containsObject:@(FSCalendarCellStateWeekend)]) {
        return dictionary[@(FSCalendarCellStateWeekend)];
    }
    return dictionary[@(FSCalendarCellStateNormal)];
}

#pragma mark - Properties

- (UIColor *)colorForCellFill
{
    if (self.selected) {
        return self.preferredFillSelectionColor ?: [self colorForCurrentStateInDictionary:_appearance.backgroundColors];
    }
    return self.preferredFillDefaultColor ?: [self colorForCurrentStateInDictionary:_appearance.backgroundColors];
}

-(void)setColorForTitleLabel:(UIColor *)colorForTitleLabel{
    if(![_preferredTitleColor isEqual:colorForTitleLabel]){
            _preferredTitleColor = colorForTitleLabel;
        [self configureAppearance];
    }
}

- (UIColor *)colorForTitleLabel
{
//    if (self.selected) {
//        return self.preferredTitleSelectionColor ?: [self colorForCurrentStateInDictionary:_appearance.titleColors];
//    }
//    return self.preferredTitleDefaultColor ?: [self colorForCurrentStateInDictionary:_appearance.titleColors];
    return _preferredTitleColor;
}

-(void)setColorForSelectedTitleLabel:(UIColor *)colorForSelectedTitleLabel{
    if(![_preferredTitleSelectedColor isEqual:colorForSelectedTitleLabel]){
        _preferredTitleSelectedColor = colorForSelectedTitleLabel;
        [self configureAppearance];
    }
}

-(UIColor*)colorForSelectedTitleLabel{
    return _preferredTitleSelectedColor;
}

- (UIColor *)colorForCellBorder
{
    if (self.selected) {
        return _preferredBorderSelectionColor ?: _appearance.borderSelectionColor;
    }
    return _preferredBorderDefaultColor ?: _appearance.borderDefaultColor;
}

//Added by Dilip

-(void)setColorForUnselectedBar:(UIColor *)colorForUnselectedBar{
    if(![_preferredBarUnselectedColor isEqual:colorForUnselectedBar]){
        _preferredBarUnselectedColor = colorForUnselectedBar;
        [self configureAppearance];
    }
}

- (UIColor *)colorForUnselectedBar
{
    return _preferredBarUnselectedColor ?: _appearance.BarUnselectedColor;
}

-(void)setColorForSelectedBar:(UIColor *)colorForSelectedBar{
    if(![_preferredBarSelectedColor isEqual:colorForSelectedBar]){
        _preferredBarSelectedColor = colorForSelectedBar;
        [self configureAppearance];
    }
}

- (UIColor *)colorForSelectedBar
{
    return _preferredBarSelectedColor ?: _appearance.BarSelectedColor;
}

- (UIColor *)colorForNoWorkBar
{
    return _preferredBarNoWorkColor ?: _appearance.BarNoWorkColor;
}

//End Dilip

- (CGFloat)borderRadius
{
    return _preferredBorderRadius >= 0 ? _preferredBorderRadius : _appearance.borderRadius;
}

#define OFFSET_PROPERTY(NAME,CAPITAL,ALTERNATIVE) \
\
@synthesize NAME = _##NAME; \
\
- (void)set##CAPITAL:(CGPoint)NAME \
{ \
    BOOL diff = !CGPointEqualToPoint(NAME, self.NAME); \
    _##NAME = NAME; \
    if (diff) { \
        [self setNeedsLayout]; \
    } \
} \
\
- (CGPoint)NAME \
{ \
    return CGPointEqualToPoint(_##NAME, CGPointInfinity) ? ALTERNATIVE : _##NAME; \
}

OFFSET_PROPERTY(preferredTitleOffset, PreferredTitleOffset, _appearance.titleOffset);

#undef OFFSET_PROPERTY

-(void)setProgressBar:(CGFloat)progressBar{
    [self layoutIfNeeded];
//    if(progressBar<0){
//        _barSelectedViewTrailConstraint.constant = 0; //put any dummy value doesnt matter actually
//        _barUnselectedView.backgroundColor = self.colorForNoWorkBar;
//        _barSelectedView.backgroundColor = self.colorForNoWorkBar;
//    }else{
//        _barUnselectedView.backgroundColor = self.colorForUnselectedBar;
//        _barSelectedView.backgroundColor = self.colorForSelectedBar;
        _barSelectedViewTrailConstraint.constant = _barUnselectedView.frame.size.width * (1 - progressBar);
//    }
}

- (void)setCalendar:(FSCalendar *)calendar
{
    if (![_calendar isEqual:calendar]) {
        _calendar = calendar;
        _appearance = calendar.appearance;
        [self configureAppearance];
    }
}

@end


@implementation FSCalendarBlankCell

- (void)configureAppearance {}

@end




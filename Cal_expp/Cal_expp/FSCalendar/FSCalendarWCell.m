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

@interface FSCalendarWCell ()

@property (readonly, nonatomic) UIColor *colorForCellFill;
@property (readonly, nonatomic) UIColor *colorForTitleLabel;
@property (readonly, nonatomic) UIColor *colorForCellBorder;
@property (readonly, nonatomic) UIColor *colorForWUnselectedBar;
@property (readonly, nonatomic) UIColor *colorForWSelectedBar;
@property (readonly, nonatomic) UIColor *colorForWNoWorkBar;
@property (readonly, nonatomic) CGFloat borderRadius;

@end

@implementation FSCalendarWCell

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
    self.clipsToBounds = NO;
    self.contentView.clipsToBounds = NO;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

#pragma mark - Public

- (void)performSelecting
{
    [self configureAppearance];
}

#pragma mark - Private

- (void)configureAppearance
{
    UIColor *textColor = self.colorForTitleLabel;
    if (![textColor isEqual:_titleLabel.textColor]) {
        _titleLabel.textColor = textColor;
    }
    UIFont *titleFont = self.calendar.appearance.weeknoFont;
    if (![titleFont isEqual:_titleLabel.font]) {
        _titleLabel.font = titleFont;
    }
    
//    _barWUnselectedView.backgroundColor = self.colorForWUnselectedBar;
//    _barWSelectedView.backgroundColor = self.colorForWSelectedBar;
}

- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary
{
    if (self.isSelected) {
        if (self.weekIsToday) {
            return dictionary[@(FSCalendarWCellStateSelected|FSCalendarWCellStateToday)] ?: dictionary[@(FSCalendarWCellStateSelected)];
        }
        return dictionary[@(FSCalendarWCellStateSelected)];
    }
    if (self.weekIsToday && [[dictionary allKeys] containsObject:@(FSCalendarWCellStateToday)]) {
        return dictionary[@(FSCalendarWCellStateToday)];
    }
    if (self.placeholder && [[dictionary allKeys] containsObject:@(FSCalendarWCellStatePlaceholder)]) {
        return dictionary[@(FSCalendarWCellStatePlaceholder)];
    }
//    if (self.weekend && [[dictionary allKeys] containsObject:@(FSCalendarCellStateWeekend)]) {
//        return dictionary[@(FSCalendarCellStateWeekend)];
//    }
    return dictionary[@(FSCalendarWCellStateNormal)];
}
#pragma mark - Properties

- (UIColor *)colorForCellFill
{
    if (self.selected) {
        return self.preferredFillSelectionColor ?: [self colorForCurrentStateInDictionary:_appearance.backgroundColors];
    }
    return self.preferredFillDefaultColor ?: [self colorForCurrentStateInDictionary:_appearance.backgroundColors];
}

- (UIColor *)colorForTitleLabel
{
    return [self colorForCurrentStateInDictionary:_appearance.titleColors];
}

- (UIColor *)colorForCellBorder
{
    if (self.selected) {
        return _preferredBorderSelectionColor ?: _appearance.borderSelectionColor;
    }
    return _preferredBorderDefaultColor ?: _appearance.borderDefaultColor;
}

//Added by Dilip
- (UIColor *)colorForWUnselectedBar
{
    return _preferredBarWUnselectedColor ?: _appearance.BarWUnselectedColor;
}

- (UIColor *)colorForWSelectedBar
{
    return _preferredBarWSelectedColor ?: _appearance.BarWSelectedColor;
}

- (UIColor *)colorForWNoWorkBar
{
    return _preferredBarWNoWorkColor ?: _appearance.BarWNoWorkColor;
}

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
    CGFloat prg = _barWUnselectedView.frame.size.width * (1 - progressBar);
        _barWSelectedViewTrailConstraint.constant = prg;
    
    if(progressBar<0){
        _barWSelectedViewTrailConstraint.constant = 0; //put any dummy value doesnt matter actually
        _barWUnselectedView.backgroundColor = self.colorForWNoWorkBar;
        _barWSelectedView.backgroundColor = self.colorForWNoWorkBar;
    }else{
        _barWUnselectedView.backgroundColor = self.colorForWUnselectedBar;
        _barWSelectedView.backgroundColor = self.colorForWSelectedBar;
        CGFloat prg = _barWUnselectedView.frame.size.width * (1 - progressBar);
        _barWSelectedViewTrailConstraint.constant = prg;
    }
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




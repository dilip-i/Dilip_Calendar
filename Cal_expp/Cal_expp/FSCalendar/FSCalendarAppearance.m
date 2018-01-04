//
//  FSCalendarAppearance.m
//  Pods
//
//  Created by DingWenchao on 6/29/15.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//
//  https://github.com/WenchaoD
//

#import "FSCalendarAppearance.h"
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarExtensions.h"

@interface FSCalendarAppearance ()

@property (weak  , nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSMutableDictionary *backgroundColors;
@property (strong, nonatomic) NSMutableDictionary *titleColors;
@property (strong, nonatomic) NSMutableDictionary *borderColors;

@end

@implementation FSCalendarAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _titleFont = [UIFont systemFontOfSize:FSCalendarStandardTitleTextSize];
        _weekdayFont = [UIFont systemFontOfSize:FSCalendarStandardWeekdayTextSize];
        _weeknoFont = [UIFont systemFontOfSize:FSCalendarStandardWeeknoTextSize];
        _headerTitleFont = [UIFont systemFontOfSize:FSCalendarStandardHeaderTextSize];
        
        _headerTitleColor = FSCalendarStandardTitleTextColor;
        _headerDateFormat = @"MMMM yyyy";
        _headerMinimumDissolvedAlpha = 0.2;
        _weekdayTextColor = FSCalendarStandardTitleTextColor;
        _caseOptions = FSCalendarCaseOptionsHeaderUsesDefaultCase|FSCalendarCaseOptionsWeekdayUsesDefaultCase;
        
        _backgroundColors = [NSMutableDictionary dictionaryWithCapacity:11];
        _backgroundColors[@(FSCalendarCellStateNormal)]      = [UIColor clearColor];
        _backgroundColors[@(FSCalendarCellStateSelected)]    = FSCalendarStandardSelectionColor;
        _backgroundColors[@(FSCalendarCellStateDisabled)]    = [UIColor clearColor];
        _backgroundColors[@(FSCalendarCellStatePlaceholder)] = [UIColor clearColor];
        _backgroundColors[@(FSCalendarCellStateUnselectedBar)] = [UIColor lightGrayColor];
        _backgroundColors[@(FSCalendarCellStateSelectedBar)] = [UIColor blueColor];
        _backgroundColors[@(FSCalendarCellStateNoWorkBar)] = [UIColor clearColor];
        _backgroundColors[@(FSCalendarCellStateWUnselectedBar)] = [UIColor yellowColor];
        _backgroundColors[@(FSCalendarCellStateWSelectedBar)] = [UIColor redColor];
        _backgroundColors[@(FSCalendarCellStateWNoWorkBar)] = [UIColor clearColor];
        _backgroundColors[@(FSCalendarCellStateToday)]       = FSCalendarStandardTodayColor;
        
        _titleColors = [NSMutableDictionary dictionaryWithCapacity:10];
        _titleColors[@(FSCalendarCellStateNormal)]      = [UIColor blackColor];
        _titleColors[@(FSCalendarCellStateSelected)]    = [UIColor whiteColor];
        _titleColors[@(FSCalendarCellStateDisabled)]    = [UIColor grayColor];
        _titleColors[@(FSCalendarCellStatePlaceholder)] = [UIColor lightGrayColor];
        _titleColors[@(FSCalendarCellStateToday)]       = [UIColor whiteColor];
        _titleColors[@(FSCalendarWCellStateNormal)]      = [UIColor blackColor];
        _titleColors[@(FSCalendarWCellStateSelected)]    = [UIColor whiteColor];
        _titleColors[@(FSCalendarWCellStateDisabled)]    = [UIColor grayColor];
        _titleColors[@(FSCalendarWCellStatePlaceholder)] = [UIColor lightGrayColor];
        _titleColors[@(FSCalendarWCellStateToday)]       = [UIColor whiteColor];
        
        _borderColors[@(FSCalendarCellStateSelected)] = [UIColor clearColor];
        _borderColors[@(FSCalendarCellStateNormal)] = [UIColor clearColor];
        
        _borderRadius = 1.0;
        
        _borderColors = [NSMutableDictionary dictionaryWithCapacity:2];
        
#if TARGET_INTERFACE_BUILDER
        _fakeEventDots = YES;
#endif
        
    }
    return self;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    if (![_titleFont isEqual:titleFont]) {
        _titleFont = titleFont;
        [self.calendar configureAppearance];
    }
}

- (void)setWeekdayFont:(UIFont *)weekdayFont
{
    if (![_weekdayFont isEqual:weekdayFont]) {
        _weekdayFont = weekdayFont;
        [self.calendar configureAppearance];
    }
}

-(void)setWeeknoFont:(UIFont *)weeknoFont{
    if (![_weeknoFont isEqual:weeknoFont]) {
        _weeknoFont = weeknoFont;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderTitleFont:(UIFont *)headerTitleFont
{
    if (![_headerTitleFont isEqual:headerTitleFont]) {
        _headerTitleFont = headerTitleFont;
        [self.calendar configureAppearance];
    }
}

- (void)setTitleOffset:(CGPoint)titleOffset
{
    if (!CGPointEqualToPoint(_titleOffset, titleOffset)) {
        _titleOffset = titleOffset;
        [_calendar.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setTitleDefaultColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStateNormal)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStateNormal)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titleDefaultColor
{
    return _titleColors[@(FSCalendarCellStateNormal)];
}

- (void)setTitleSelectionColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStateSelected)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titleSelectionColor
{
    return _titleColors[@(FSCalendarCellStateSelected)];
}

- (void)setTitleTodayColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStateToday)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStateToday)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titleTodayColor
{
    return _titleColors[@(FSCalendarCellStateToday)];
}

- (void)setTitlePlaceholderColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStatePlaceholder)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStatePlaceholder)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titlePlaceholderColor
{
    return _titleColors[@(FSCalendarCellStatePlaceholder)];
}

- (void)setTitleWeekendColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStateWeekend)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStateWeekend)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)titleWeekendColor
{
    return _titleColors[@(FSCalendarCellStateWeekend)];
}

- (void)setWeekTitleDefaultColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarWCellStateNormal)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarWCellStateNormal)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)weekTitleDefaultColor
{
    return _titleColors[@(FSCalendarWCellStateNormal)];
}

- (void)setWeekTitleSelectionColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarWCellStateSelected)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarWCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)weekTitleSelectionColor
{
    return _titleColors[@(FSCalendarWCellStateSelected)];
}

- (void)setWeekTitleTodayColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarWCellStateToday)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarWCellStateToday)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)weekTitleTodayColor
{
    return _titleColors[@(FSCalendarWCellStateToday)];
}

- (void)setWeekTitlePlaceholderColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarWCellStatePlaceholder)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarWCellStatePlaceholder)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)weekTitlePlaceholderColor
{
    return _titleColors[@(FSCalendarWCellStatePlaceholder)];
}

- (void)setSelectionColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(FSCalendarCellStateSelected)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)selectionColor
{
    return _backgroundColors[@(FSCalendarCellStateSelected)];
}

- (void)setTodayColor:(UIColor *)todayColor
{
    if (todayColor) {
        _backgroundColors[@(FSCalendarCellStateToday)] = todayColor;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateToday)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)todayColor
{
    return _backgroundColors[@(FSCalendarCellStateToday)];
}

- (void)setTodaySelectionColor:(UIColor *)todaySelectionColor
{
    if (todaySelectionColor) {
        _backgroundColors[@(FSCalendarCellStateToday|FSCalendarCellStateSelected)] = todaySelectionColor;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateToday|FSCalendarCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)todaySelectionColor
{
    return _backgroundColors[@(FSCalendarCellStateToday|FSCalendarCellStateSelected)];
}

- (void)setBorderDefaultColor:(UIColor *)color
{
    if (color) {
        _borderColors[@(FSCalendarCellStateNormal)] = color;
    } else {
        [_borderColors removeObjectForKey:@(FSCalendarCellStateNormal)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)borderDefaultColor
{
    return _borderColors[@(FSCalendarCellStateNormal)];
}

- (void)setBorderSelectionColor:(UIColor *)color
{
    if (color) {
        _borderColors[@(FSCalendarCellStateSelected)] = color;
    } else {
        [_borderColors removeObjectForKey:@(FSCalendarCellStateSelected)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)borderSelectionColor
{
    return _borderColors[@(FSCalendarCellStateSelected)];
}

//Added by Dilip
- (void)setBarUnselectedColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(FSCalendarCellStateUnselectedBar)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateUnselectedBar)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)BarUnselectedColor
{
    return _backgroundColors[@(FSCalendarCellStateUnselectedBar)];
}

- (void)setBarSelectedColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(FSCalendarCellStateSelectedBar)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateSelectedBar)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)BarSelectedColor
{
    return _backgroundColors[@(FSCalendarCellStateSelectedBar)];
}

- (void)setBarWUnselectedColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(FSCalendarCellStateWUnselectedBar)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateWUnselectedBar)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)BarWUnselectedColor
{
    return _backgroundColors[@(FSCalendarCellStateWUnselectedBar)];
}

- (void)setBarNoWorkColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(FSCalendarCellStateNoWorkBar)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateNoWorkBar)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)BarNoWorkColor
{
    return _backgroundColors[@(FSCalendarCellStateNoWorkBar)];
}

- (void)setBarWSelectedColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(FSCalendarCellStateWSelectedBar)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateWSelectedBar)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)BarWSelectedColor
{
    return _backgroundColors[@(FSCalendarCellStateWSelectedBar)];
}

- (void)setBarWNoWorkColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(FSCalendarCellStateWNoWorkBar)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateWNoWorkBar)];
    }
    [self.calendar configureAppearance];
}

- (UIColor *)BarWNoWorkColor
{
    return _backgroundColors[@(FSCalendarCellStateWNoWorkBar)];
}

//End Dilip

- (void)setBorderRadius:(CGFloat)borderRadius
{
    borderRadius = MAX(0.0, borderRadius);
    borderRadius = MIN(1.0, borderRadius);
    if (_borderRadius != borderRadius) {
        _borderRadius = borderRadius;
        [self.calendar configureAppearance];
    }
}

- (void)setWeekdayTextColor:(UIColor *)weekdayTextColor
{
    if (![_weekdayTextColor isEqual:weekdayTextColor]) {
        _weekdayTextColor = weekdayTextColor;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderTitleColor:(UIColor *)color
{
    if (![_headerTitleColor isEqual:color]) {
        _headerTitleColor = color;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderMinimumDissolvedAlpha:(CGFloat)headerMinimumDissolvedAlpha
{
    if (_headerMinimumDissolvedAlpha != headerMinimumDissolvedAlpha) {
        _headerMinimumDissolvedAlpha = headerMinimumDissolvedAlpha;
        [self.calendar configureAppearance];
    }
}

- (void)setHeaderDateFormat:(NSString *)headerDateFormat
{
    if (![_headerDateFormat isEqual:headerDateFormat]) {
        _headerDateFormat = headerDateFormat;
        [self.calendar configureAppearance];
    }
}

- (void)setCaseOptions:(FSCalendarCaseOptions)caseOptions
{
    if (_caseOptions != caseOptions) {
        _caseOptions = caseOptions;
        [self.calendar configureAppearance];
    }
}

- (void)setSeparators:(FSCalendarSeparators)separators
{
    if (_separators != separators) {
        _separators = separators;
        [_calendar.collectionView.collectionViewLayout invalidateLayout];
    }
}

@end


@implementation FSCalendarAppearance (Deprecated)

- (void)setUseVeryShortWeekdaySymbols:(BOOL)useVeryShortWeekdaySymbols
{
    _caseOptions &= 15;
    self.caseOptions |= (useVeryShortWeekdaySymbols*FSCalendarCaseOptionsWeekdayUsesSingleUpperCase);
}

- (BOOL)useVeryShortWeekdaySymbols
{
    return (_caseOptions & (15<<4) ) == FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
}

- (void)setTitleVerticalOffset:(CGFloat)titleVerticalOffset
{
    self.titleOffset = CGPointMake(0, titleVerticalOffset);
}

- (CGFloat)titleVerticalOffset
{
    return self.titleOffset.y;
}

- (void)setCellShape:(FSCalendarCellShape)cellShape
{
    self.borderRadius = 1-cellShape;
}

- (FSCalendarCellShape)cellShape
{
    return self.borderRadius==1.0?FSCalendarCellShapeCircle:FSCalendarCellShapeRectangle;
}

- (void)setTitleTextSize:(CGFloat)titleTextSize
{
    self.titleFont = [UIFont fontWithName:self.titleFont.fontName size:titleTextSize];
}

- (void)setWeekdayTextSize:(CGFloat)weekdayTextSize
{
    self.weekdayFont = [UIFont fontWithName:self.weekdayFont.fontName size:weekdayTextSize];
}

- (void)setWeeknoTextSize:(CGFloat)weeknoTextSize
{
    self.weeknoFont = [UIFont fontWithName:self.weeknoFont.fontName size:weeknoTextSize];
}

- (void)setHeaderTitleTextSize:(CGFloat)headerTitleTextSize
{
    self.headerTitleFont = [UIFont fontWithName:self.headerTitleFont.fontName size:headerTitleTextSize];
}

- (void)invalidateAppearance
{
    [self.calendar configureAppearance];
}

- (void)setAdjustsFontSizeToFitContentSize:(BOOL)adjustsFontSizeToFitContentSize {}
- (BOOL)adjustsFontSizeToFitContentSize { return YES; }

@end



//
//  FSCalendarAppearance.h
//  Pods
//
//  Created by DingWenchao on 6/29/15.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//
//  https://github.com/WenchaoD
//

#import "FSCalendarConstants.h"

@class FSCalendar;

typedef NS_ENUM(NSInteger, FSCalendarCellState) {
    FSCalendarCellStateNormal             = 0,
    FSCalendarCellStateSelected           = 1,
    FSCalendarCellStatePlaceholder        = 1 << 1,
    FSCalendarCellStateDisabled           = 1 << 2,
    FSCalendarCellStateToday              = 1 << 3,
    FSCalendarCellStateWeekend            = 1 << 4,
    FSCalendarCellStateUnselectedBar      = 1 << 5,
    FSCalendarCellStateSelectedBar        = 1 << 6,
    FSCalendarCellStateWUnselectedBar     = 1 << 7,
    FSCalendarCellStateWSelectedBar       = 1 << 8,
    FSCalendarCellStateNoWorkBar          = 1 << 9,
    FSCalendarCellStateWNoWorkBar         = 1 << 10,
    FSCalendarWCellStateNormal            = 1 << 11,
    FSCalendarWCellStateSelected          = 1 << 12,
    FSCalendarWCellStatePlaceholder       = 1 << 13,
    FSCalendarWCellStateDisabled          = 1 << 14,
    FSCalendarWCellStateToday             = 1 << 15,
    FSCalendarCellStateTodaySelected = FSCalendarCellStateToday|FSCalendarCellStateSelected
};

typedef NS_ENUM(NSUInteger, FSCalendarSeparators) {
    FSCalendarSeparatorNone          = 0,
    FSCalendarSeparatorInterRows     = 1
};

typedef NS_OPTIONS(NSUInteger, FSCalendarCaseOptions) {
    FSCalendarCaseOptionsHeaderUsesDefaultCase      = 0,
    FSCalendarCaseOptionsHeaderUsesUpperCase        = 1
};

typedef NS_OPTIONS(NSUInteger, FSCalendarWeekDayTextCaseOptions) {
    
    FSCalendarCaseOptionsWeekdayUsesDefaultCase     = 0,
    FSCalendarCaseOptionsWeekdayUsesUpperCase       = 1,
    FSCalendarCaseOptionsWeekdayUsesSingleUpperCase = 2
};

/**
 * FSCalendarAppearance determines the fonts and colors of components in the calendar.
 *
 * @see FSCalendarDelegateAppearance
 */
@interface FSCalendarAppearance : NSObject

/**
 * The font of the day text.
 */
@property (strong, nonatomic) UIFont   *titleFont;

/**
 * The font of the weekday text.
 */
@property (strong, nonatomic) UIFont   *weekdayFont;

/**
 * The font of the weekno text.
 */
@property (strong, nonatomic) UIFont   *weeknoFont;

/**
 * The font of the month text.
 */
@property (strong, nonatomic) UIFont   *headerTitleFont;

/**
 * The offset of the day text from default position.
 */
@property (assign, nonatomic) CGPoint  titleOffset;

/**
 * The color of weekday text.
 */
@property (strong, nonatomic) UIColor  *weekdayNoColor;

/**
 * The color of month header text.
 */
@property (strong, nonatomic) UIColor  *headerTitleColor;

//Week day text color
@property (strong, nonatomic) UIColor  *weekdayTextColor;

//Week day text font
@property (strong, nonatomic) UIFont  *weekDayTextFont;

// 'w' color
@property (strong, nonatomic) UIColor  *wColor;

// 'w' font
@property (strong, nonatomic) UIFont  *wFont;

// 'w' backGroundcolor
@property (strong, nonatomic) UIColor  *wBackgroundColor;

/**
 * The date format of the month header.
 */
@property (strong, nonatomic) NSString *headerDateFormat;

/**
 * The alpha value of month label staying on the fringes.
 */
@property (assign, nonatomic) CGFloat  headerMinimumDissolvedAlpha;

/**
 * The day text color for unselected state.
 */
@property (strong, nonatomic) UIColor  *titleDefaultColor;

/**
 * The day text color for selected state.
 */
@property (strong, nonatomic) UIColor  *titleSelectionColor;

/**
 * The day text color for today in the calendar.
 */
@property (strong, nonatomic) UIColor  *titleTodayColor;

/**
 * The day text color for days out of current month.
 */
@property (strong, nonatomic) UIColor  *titlePlaceholderColor;

/**
 * The day text color for weekend.
 */
@property (strong, nonatomic) UIColor  *titleWeekendColor;

/**
 * The week no text color for unselected state.
 */
@property (strong, nonatomic) UIColor  *weekTitleDefaultColor;

/**
 * The week no text color for selected state.
 */
@property (strong, nonatomic) UIColor  *weekTitleSelectionColor;

/**
 * The week no text color for today week in the calendar.
 */
@property (strong, nonatomic) UIColor  *weekTitleTodayColor;

/**
 * The week no text color for weeks out of current month.
 */
@property (strong, nonatomic) UIColor  *weekTitlePlaceholderColor;

/**
 * The fill color of the shape for selected state.
 */
@property (strong, nonatomic) UIColor  *selectionColor;

/**
 * The fill color of the shape for selected week state.
 */
@property (strong, nonatomic) UIColor  *wSelectionColor;

/**
 * The fill color of the shape for today.
 */
@property (strong, nonatomic) UIColor  *todayColor;

/**
 * The fill color of the shape for today and selected state.
 */
@property (strong, nonatomic) UIColor  *todaySelectionColor;

/**
 * The border color of the shape for unselected state.
 */
@property (strong, nonatomic) UIColor  *borderDefaultColor;

/**
 * The border color of the shape for selected state.
 */
@property (strong, nonatomic) UIColor  *borderSelectionColor;

//Added by Dilip
@property (strong, nonatomic) UIColor  *BarUnselectedColor;
@property (strong, nonatomic) UIColor  *BarSelectedColor;
@property (strong, nonatomic) UIColor  *BarNoWorkColor;
@property (strong, nonatomic) UIColor  *BarWUnselectedColor;
@property (strong, nonatomic) UIColor  *BarWSelectedColor;
@property (strong, nonatomic) UIColor  *BarWNoWorkColor;
//End Dilip

/**
 * The border radius, while 1 means a circle, 0 means a rectangle, and the middle value will give it a corner radius.
 */
@property (assign, nonatomic) CGFloat borderRadius;

/**
 * The case options manage the case of month label and weekday symbols.
 *
 * @see FSCalendarCaseOptions
 */
@property (assign, nonatomic) FSCalendarWeekDayTextCaseOptions caseOptions;

/**
 * The line integrations for calendar.
 *
 */
@property (assign, nonatomic) FSCalendarSeparators separators;

#if TARGET_INTERFACE_BUILDER

// For preview only
@property (assign, nonatomic) BOOL      fakeSubtitles;
@property (assign, nonatomic) BOOL      fakeEventDots;
@property (assign, nonatomic) NSInteger fakedSelectedDay;

#endif

@end





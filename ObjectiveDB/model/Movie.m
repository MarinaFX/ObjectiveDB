//
//  Movie.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 21/03/22.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@implementation Movie

- (instancetype) initWithId: (NSNumber*)ID
                title:(NSString*)title
                overview:(NSString*)overview
                rating: (NSNumber*)rating {
    if (self = [super init]) {
        _ID = ID;
        _title = title;
        _overview = overview;
        _rating = rating;
    }
    return self;
}

- (instancetype) initWithId: (NSNumber*)ID
                title: (NSString*)title {
    return [self initWithId:ID title:title overview:nil rating:nil];
}

- (NSString*) description {
    NSString *descriptionString = [NSString stringWithFormat:@"Movie ID = %@;Movie title: %@; Movie rating = %@; Movie overview = %@;", _ID, _title, _rating, _overview];
    return descriptionString;
}

@end

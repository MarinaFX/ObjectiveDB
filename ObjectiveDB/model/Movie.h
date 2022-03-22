//
//  Movie.h
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 21/03/22.
//

#import <UIKit/UIKit.h>

#ifndef Header_h
#define Header_h


#endif /* Header_h */


@interface Movie : NSObject 
@property (atomic, retain) NSNumber *ID;
@property (atomic, retain) NSString *title;
@property (atomic, retain) NSString *overview;
@property (atomic, retain) NSNumber *rating;
@property (atomic, retain) UIImage *imageCover;

-(instancetype) initWithId: (NSNumber*)ID
           title:(NSString*)title
           overview:(NSString*)overview
           rating: (NSNumber*)rating;

-(instancetype) init: (NSNumber*)ID
               title: (NSString*)title;

-(NSString*) description;

@end
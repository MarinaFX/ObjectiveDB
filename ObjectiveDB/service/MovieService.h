//
//  MovieService.h
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 22/03/22.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

#ifndef MovieService_h
#define MovieService_h


#endif /* MovieService_h */

@interface MovieService : NSObject



/*! Completion block to fetch all movies */
typedef void (^FetchMoviesCompletionBlock) (BOOL success, NSMutableArray *movies);

/*! Completion block to fetch the movie poster */
typedef void (^FetchPosterCompletionBlock) (BOOL success, UIImage *image);


- (void) performAsyncMoviesDownloadWithType: (NSString*)type
        completionBlock: (FetchMoviesCompletionBlock) completionBlock;

- (void) performAsyncImageDownloadWithURL: (NSString *)URL
        completionBlock: (FetchPosterCompletionBlock) completionBlock;

@end


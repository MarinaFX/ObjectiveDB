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

/*! Completion block to fetch the movie poster*/
typedef void (^FetchPostercompletionBlock) (BOOL success, UIImage *image);

- (void) performAsyncImageDownloadsWithWithURL: (NSURL*)URL
        completionHandler: (FetchPostercompletionBlock)completionBlock;

@end


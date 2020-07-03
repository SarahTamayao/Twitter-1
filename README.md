# Project 3 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **25** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign in using OAuth login flow
- [x] User can Logout
- [x] User can view last 20 tweets from their home timeline
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh.
- [x] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] Using AutoLayout, the Tweet cell should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation.

The following **optional** features are implemented:

- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [x] User can view their profile in a *profile tab*
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
  - [ ] Profile view should include that user's timeline
- [x] User should display the relative timestamp for each tweet "8m", "7h"
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [x] Links in tweets are clickable.
- [x] User can tap the profile image in any tweet to see another user's profile
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [x] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 280) (**1 point**)
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [x] User sees embedded images in tweet if available
- [ ] User can switch between timeline, mentions, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Some how add a menu bar that extends from the side of the screen as another way to navigate
2. I used the app delegate to store the current user's info, but I'm curious about if there is a better way of sorying the info.

## Video Walkthrough

Here's a walkthrough of implemented user stories:
<img src='http://g.recordit.co/NQWPI6fVZU.gif' title='Video Walkthrough1' width='' alt='Video Walkthrough1' />
<img src='https://im4.ezgif.com/tmp/ezgif-4-7a93291590b1.gif' title='Video Walkthrough2' width='' alt='Video Walkthrough2' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
The tab bar controller was not showing up and I could not figure out why. Shout out to German and Charlie for helping me figure it out. There was also an issue with getting the tweet data to show. This was because I was treating an object like a dictionary when it was actually an array with a single element (which was a dictonary). I also had trouble with the tap gesture recognizer for the profile image, but I figured it out. 

There are still some issues with the login, when the user first logs in there is this "Warning: Attempt to present <UITabBarController: 0x7f911188fa00> on <SFAuthenticationViewController: 0x7f91118d2a00> whose view is not in the window hierarchy!" and cannot get to the timeline. However, if you relaunch the app, the timeline will show. I was not able to figure out this error.
## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

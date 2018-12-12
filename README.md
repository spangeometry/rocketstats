![RocketStats](https://github.com/spangeometry/rocketstats/raw/master/rocketstats/res/logo.png)
## iOS statistics for Rocket League

##### an in-progress SFSU student project

### Priority One Features (Must-haves)
- Users shall be able to check their in-game statistics:
    - ~~Wins~~ (Not actually that interesting...)
    - Goals and Goal/shot percentage
    - Assists
    - Saves
    - Shots
    - Number of MVP awards
- Users shall be able to check their rankings:
    - Competitive modes (doubles, standard, etc.)
    - Casual modes (rumble, dropshot, etc.)
- Users shall be able to set the default profile to view
- Users shall be able look up statistics for other players 
  
### Planned Features
- Users shall be able to create 'clubs':
    - Compare statistics between friends
- Users will be able to set 'favorite' players:
    - View statistics of other players via shortcut

##### Progress Tracker
- ☑ WrapAPI element created [here](https://wrapapi.com/api/serioussamix/rocketleague/statistics/0.0.1)
- ☐ Clean up tabbed branch
- ☑ Statistics completed (est. 1-2 hours)
    - ☑ Statistics vertical prototype created
    - ☑ Statistics horizontal prototype created
- ☑ Lookup completed (est. 1-2 hours)
    - ☑ User not found exception handled
    - ☑ "Enter" searches
- ☑ Settings page completed (est. 1-2 hours)
    - ☑ Default user takes effect
    - ☑ Default user persists after close
- ☑ Mockups completed (est. 1-2 hours)
    - ☑ "My statistics" mocked up
    - ☑ "Search" mocked up
    - ☐ ~~"Settings" mocked up~~ (using Settings bundle)
---
- ☐ Nice-to-haves (est. 4+ hours)
    - ☐ Clubs viewable
    - ☐ Clubs stored on Firebase
    - ☐ Favorites viewable
    - ☐ Favorites stored on phone
    - ☐ Login to determine defaults and clubs

#### Tech

RocketStats relies on the following resources:

* [WrapAPI v2](https://wrapapi.com) - Takes statistics from the Tracker Network's Rocket League page
* [Rocket League Tracker](https://rocketleague.tracker.network/) - Source for Rocket League Statistics

#### License
To be determined

# 20211222-TeddyDemilew-NYCSchools
JPMC Code Challenge

Notes for code reviewers:
- used MVVM + Coordinator pattern
- made API calls to fetch the NYC schools and SAT test takers data
- used Swift and Objective-C to showcase experience in both languages 
- created all UI programmatically. (Reason: In a team setting, developing UI programmatically helps avoiding Storyboards merge conflicts.)
- created three view controllers (for varity, I added tableView, mapView, and static screen)
    - HomeViewController - (Swift)
    - SatDataDetailsViewController - (Swift) 
    - MapViewController (Objective-C)
- added a search bar on the HomeViewController for the user to filter by zip code
- added unit tests (if I had more time, I would write more unit and UI tests)
- checked for memory and cpu usage - all normal
- added app icons; I had to remove other icons (notification, setting, splotlight) to reduce the compressed file size

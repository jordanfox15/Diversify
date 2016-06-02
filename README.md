# Diversify
Front End Repo: https://github.com/jordanfox15/Diversify-app

## Description
This is an app that was designed to fight intolerance and prejudice by linking together users who share similar interests but have different demographics.  For two weeks two users would be matched and could communicate by sending messages through the app in real time.  At the end of those two weeks all users would be provided a new match.

## Features
This is a decoupled app with a Rails API back-end and an Angular 1 front-end in separate repo's.  Users receive a match every two weeks and can message any of their matches in real time.

## Technologies Used
* Back End: Rails API, ActiveRecord, PostgreSQL, Sidekiq
* Front End: AngularJS, Socket.IO, Javascript, HTML5, CSS3
* Both: Redis

## Challenges We Faced
The main hurdle we had to clear during production was getting the front-end and back-end to seamlessly work together to produce a working app.  This was made more difficult because we had no experience with Angular at the start of the project.  Other challenges we worked through were implementing in-app real-time messaging and building the algorithm to match users together.

## Personal Contribution
My greatest contribution to the project was the matching algorithm located at Diversify/app/workers/match_worker.  It was a difficult process to make sure all users were matched every time the algorithm ran, with no repeat matches, given our parameters.  I also implemented a rake task so the entire process would run in the background at any time interval I chose, and a mailer so all users would get an email informing them they had a new match and who it was once all matches were complete.  A goal I did not get to was to match a new user once they had completed registration if there was currently an unmatched user from there being an odd number of total users.

## Team
  - Jordan Fox: jordanfox1551@gmail.com
  - Monique Williamson: moniquewill1@yahoo.com
  - Kevin Huang: kevin.ziwen.huang@gmail.com
  - Albert Hahn: xaphx@yahoo.com



<p align="center">
  <img src="assets/img/splash-screen.png" alt="Splash Screen" width="800" height="464">

  <h1 align="center"> ☝🏽 Stay In Touch</h1>


  <p align="center">
    A social media web app built with Rails
    <br />
    <a href="https://github.com/Rhelli/StayInTouch-Social-Media"><strong>Explore This Repository »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Rhelli/StayInTouch-Social-Media/archive/develop.zip">Download this repository</a>
    |
    <a href="https://github.com/Rhelli/StayInTouch-Social-Media/issues/new/choose">Report A Bug</a>
    |
    <a href="https://github.com/Rhelli/StayInTouch-Social-Media/fork">Fork It</a>
  </p>
</p>



## Table of Contents
  - [About Gitshoes](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-about-gitshoes)
    - [What Is It?](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#%EF%B8%8F-what-is-it)
    - [Why Is It?](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#%EF%B8%8F-why-is-it)
    - [Current State & Limitations](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-current-state--limitations)
  - [Showcase](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#%EF%B8%8F-showcase)
  - [The Nitty-Gritty](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-the-nitty-gritty)
    - [Languages & Technologies](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#languages--technologies)
    - [Ruby Gems](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#ruby-gems)
  - [How to Use Gitshoes](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-how-to-use-gitshoes)
    - [Requirements](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#requirements)
    - [Setup](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#setup)
    - [Running Gitshoes](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#running-with-gitshoes)
  - [Contributions, Issues and Forking](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-contributions-issues-and-forking)
  - [Final Thoughts & Futures](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-final-thoughts--futures)
  - [Creator](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-creator)
  - [Show Your Support!](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-show-your-support)
  - [Acknowledgements](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-acknowledgements)
  - [Notable Resources](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#-noteable-resources)
  - [Licensing](https://github.com/Rhelli/Shoes-Github-API/tree/feature/unit_testing#%EF%B8%8F-licensing)


## 🔰 The Project Brief

This is a project included in the Rails module to be completed by students of [Microverse]("https://www.microverse.org/).

This project sees us tackle a larger, more 'real-world' task in creating a social media web app with all the functionality we've come to expect from social media websites, namely; friendships, invites, posts, comments and likes.

As this project naturally has a larger remit than previous back-end centric projects that have come before, it is split up into 5 major milestones:
 1. Data Architecture & Planning
 2. Creation of friendship models & associations
 3. Improving efficiency of mutual friendship generation & handling
 4. Deployment to Heroku
 5. Final Touches & Styling

### 🔍 The Nitty Gritty
Posts, comments and likes had been handled for us in the project setup, thus the core challenges in this project were establishing an efficient friendship system whereby users could send invitations as well as receive invitations, all while maintaining a tidy database.

This enforced some ground rules as to how we should generated our models:
 - Users would have to have friendships as well as inverse friendships (where they are the friend of another)
 - Friendships would have to belong to users both as the creator of the friend request and also the receiver.

Subsequently, an additional medley of controller and helper functions would enable detection of friend request states and existence, enable creation and destruction of requests and allow for updating on friend request acceptance or decline.

### 🔬 Tools & Technology Used
Languages & Frameworks
 - Ruby 2.7.1
 - Ruby on Rails 6.0.3.1
 - SASS/CSS3

Gems of note
 - [Devise](https://github.com/heartcombo/devise)
 - [Faker](https://github.com/faker-ruby/faker)
 - [HIRB](https://github.com/cldwalker/hirb) MVP Award 🥇

Testing
 - [RSpec 3.9](https://rspec.info/)

Database
 - PostgreSQL

Linters & Quality Control
 - [Stickler CI](https://stickler-ci.com/)
 - [Rubocop 0.85.0](https://github.com/rubocop-hq/rubocop-rails)

Deployment
 - Heroku
 - AWS (static assets)


### 💻 Setup & Use

#### Setup
Setup should be fairly straightforward. You will have to ensure your machine is properly equipped to run the code first:
  1. Make sure you have both [Ruby](https://www.ruby-lang.org/en/documentation/installation/) and Ruby on Rails ([Mac](https://gorails.com/setup/osx/10.15-catalina) • [Linux](https://gorails.com/setup/ubuntu/19.10) • [Windows](https://gorails.com/setup/windows/10)) installed.
  2. Download this repository.
  3. **`cd`** into the root directory of wherever you download this repo. [What does 'cd' mean?](https://www.macworld.com/article/2042378/master-the-command-line-navigating-files-and-folders.html)
  4. Whilst at the root (home) directory of this project, enter **`bundle install`** to install the projects software dependencies.
  5. In your terminal window, enter **`rails server`** to start the server.
  6. Now navigate to [localhost:4000](localhost:4000) in your browser to start playing around with the webpages!

Alternatively if you'd like to confirm the entire project is passing testing:
  1. **`cd`** into this repository in your terminal
  2. Enter **`bundle exec rspec`** to run all tests


******

## 🎞️ Showcase

### Authentication & JSON Data
<p align="center>

<a href="assets/img/login-screen.gif"><img src="assets/img/login-screen.gif" alt="login screen" width="800" height="464"></a>

> Logging in with Gitshoes - Either get directed to the 'Create an Account' page or get directed to the Github Login, where the app is authorised via OAuth.


### Searching Github


<a href="assets/img/search-screen.gif"><img src="assets/img/search-screen.gif" alt="search screen" width="800" height="464"></a>

> Gitshoes uses 'Launchy' to search Github's code base

### The Information Window


<a href="assets/img/info-screen.gif"><img src="assets/img/info-screen.gif" alt="info screen" width="800" height="464"></a>

> A brief information screen detailing the what's and why's of Gitshoes.

</p>

*******

## 🥂 Contributions, Issues and Forking

Contributions, issues and feature requests are more than welcome! 

If you have any problems running or setting up Gitshoes, please submit it as a bug on the [issues page.](https://github.com/Rhelli/Shoes-Github-API/issues) right away!

If you want to make your own changes, modifications or improvements, go ahead and Fork it!
1. Fork it (https://github.com/queeksm/Tic-Tac-Toe/fork)
2. Create your working branch (git checkout -b [choose-a-name])
3. Commit your changes (git commit -am 'what this commit will fix/add/improve')
4. Push to the branch (git push origin [chosen-name])
5. Create a new Pull Request

## 🔮 Final Thoughts & Futures
Gitshoes is in it's infancy, and as such, it is lacking in the full suite of features that are first apparent to the user. However, as development progresses, I'd like to add the obvious features (such as making all the buttons fully functional) as well as a few others such as:

  **Login:**
  - Transfer OAuth to OAuth2 in complicance with Github's authentication standards
  - Allow for entirely in-app login
  - Login screen opens first before main window
  - Implementation of a 'Remember Me' feature to prevent having to log in every time the app is opened

  **Search:**
  - Simple radio/switch control for Google or Github Search

 **Functionality:**
  - Create Pull Requests
  - Create Issue
  - Profile Acitibity Statistics & Graphs
  
  **Thematic:**
  - Simple radio/switch control for day/night mode


## 👨🏽‍💻 Creator

Rory Hellier - [Github](https://github.com/Rhelli)

## 🖐🏼 Show Your Support!

Give a ⭐️ if you like this project!

## 🎩 Acknowledgements
 - Shoes3 for providing the GUI library
 - Github for their API

## 📚 Noteable Resources
  - [Shoes3 Manual](http://shoesrb.com/manual/Hello.html) - Starting with Shoes
  - [Shoes3 Wiki](https://github.com/shoes/shoes3/wiki) - Advanced Use of Shoes
  - [OAuth-Ruby-Quickstart](https://github.com/githubOAuth-Ruby-Quickstart) - An excellent guide to getting simple OAuth authentication started using Sinatra, rest-client and Octokit

## ⚖️ Licensing
This project is [MIT](https://github.com/queeksm/Tic-Tac-Toe/LICENSE.txt) licensed.

# MovieTouch

[![Build Status](https://app.bitrise.io/app/1d2ebb0208126084/status.svg?token=QbbHZ_0yoUwfRr92XegxRA&branch=development)](https://app.bitrise.io/app/1d2ebb0208126084) [![codebeat badge](https://codebeat.co/badges/8ef077cd-2ff5-4c24-a299-3ceb8df45b12)](https://codebeat.co/projects/github-com-thiagosantiago-movietouch-development)


## Language and Requirements

- Swift 4.2
- Xcode 10.1

## Architecture

The architecture chosen for this project was the Clean Swift.

![alt text](https://cdn-images-1.medium.com/max/2000/1*QV4nxWPd_sbGhoWO-X7PfQ.png)

To know more about the architecture click [**here**](https://hackernoon.com/introducing-clean-swift-architecture-vip-770a639ad7bf).

## Third-party Libraries

- The only third party framework is [**SDWebImage**](https://github.com/SDWebImage/SDWebImage) to do asynchronous image download and cache management.

## Project Features

#### Upcoming Movies

- [x] Show the list of upcoming movies.
- [x] Provide the possibility to search a movie.
- [x] Present for each listed movie the movie poster, movie title, genres and release date.
- [X] Load movies with pagination through an infinite scroll.

#### Movie Details

- [x] Show the details of the movie selected. 
_ [X] Present details of the movie like poster, title, genres, overview, release date and backdrop image.

## Unit Tests

- Router: **100%** of code coverage
- UpcomingMoviesWorker: **98.2%** of code coverage
- UpcomingMoviesInteractor: **91.4%** of code coverage

- **Total Project Coverage: 67.8%**

## Continuous Integration

- This repository is integrated with [**Bitrise**](https://www.bitrise.io) what means that every time that a Code Push, Pull Request or a Tag Push is made the CI will run a build and the tests for this, also when a merge occurs with the master the CI will run the build and the tests.
- The `Bitrise` label at this readme file shows quickly if the master is broken or if everything is fine(tests and build).

## Code Quality

- To keep the code quality I'm using the [**Codebeat**](https://codebeat.co)
- `Codebeat` provides automated code review helping you to easily identify weakness and code smells in your app.
- The `Codebeat` label at this readme file shows the code quality of the app.

## Build Instructions

- If you are thinking in cloned the repository, follow this steps below: 
<pre>$ git clone https://github.com/ThiagoSantiago/MovieTouch.git
$ cd MovieTouch
$ git checkout development
$ open MovieTouch.xcworkspace</pre>

- Or just clone or download the code and run it.

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/github_username/repo_name">
    <img src="CourtFinder/assets/logo_green.png" alt="Logo" width="150" height="150">
  </a>

<h3 align="center">Court Finder</h3>

  <p align="center">
    Simple mobile app for booking public tennis courts 🎾
  </p>
</div>

<!-- ABOUT THE PROJECT -->

## About The Project

Video Demo: https://youtu.be/JbOTHA6d370

Court Finder is a full stack mobile application built to help improve the process of finding available public tennis courts.

### Problem Background

The process of finding an available public tennis court during peak hours can sometimes be frustrating in Vancouver. The newly arrived players have to let the current players know that they are waiting to play the next game, which means that the current players have to finish their game within the next 30 minutes. During the peak hours, there can be multiple groups waiting on the same court and the newly arrived players often have to go around the courts interrupting multiple games to find a court with the least amount of waiting groups.
The process is inefficient for the following reasons:

- New players have to physically walk through the tennis courts with find a court with the smallest waiting time
- Games are interrupted as a result of newly arrived players looking for available courts
- There is a significant risk of human error (e.g. 2 groups can mistakenly reserve the "next game" at the same court)

Solution: Designing a mobile application to track waiting lists. The user would use the app upon arrival at the tennis courts to check court waiting times, check in or join a current court waiting list!

### Features

- User authentication (login, create account)
- Display real time waiting times information about tennis courts including availability, number of parties waiting, estimated time remaining
- Check in to play immediately on available courts
- Join a waiting list for a tennis court if currently occupied by other players
- Display latest court booking to user
- Cancel latest court booking

### Built With

- Primary language: JavaScript
- Back-end: Node.js, Next.js
- Front-end: React Native
- Database: PostgresSQL

<!-- GETTING STARTED -->

## Getting Started

To launch the app on your local environment, you will need Node.js, React Native, Postgres frameworks

- Installing expo
  sh
  npm install -g expo-cli
  
- Change the directory to your Expo app folder by using the cd command in the terminal. For example:

  sh
  cd path/to/your/expo/app
  

  Once you are in the correct directory, start the Expo development server by running the following command:

  sh
  expo start
  

- To run a Node.js server, you can follow these steps:
  Open a terminal or command prompt and navigate to the directory where the index.js file is located.
  sh
  node index.js
  
- Installing Postgres

  sh
    psql -U postgres
  

<!-- CONTRIBUTORS -->

## Contributors

- Nariman Muldashev (Back-end Developer / Product Manager)
- Kevin Lee (Front-end Developer / Product Manager)
- Valeriya Ten (UI/UX Designer)
- Deewai Abdullahi (Project Mentor)

<!-- CONTACT -->

## Contact

- Nariman Muldashev - muldashev11@gmail.com
- Kevin Lee - lee.kevin.ck@gmail.com
- Valeriya Ten - heyvalliet@gmail.com

Project Link: [https://github.com/NariM11/CourtFinder](https://github.com/NariM11/CourtFinder)

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments

- UBC BCS Students Association for organizing the project mentorship program
- Dapper Labs for providing mentor support to UBC BCS students
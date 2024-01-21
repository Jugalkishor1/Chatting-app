# Chatting app

## Description

This rails application is made by me in my training period. This is a simple Chat application. In this we can make friends and can communicate with them like facebook. For realtime chatting I have use Redis and action cable to show message without refreshing the page.
Also we can your Post and get likes and comments as well.


## Getting Started
To get a local copy up and running follow these simple example steps

## Prerequisites
To get this project up and running locally, you must already have ruby and necessary gems installed on your computer
- Ruby (3.0.4)
- Rails (6.1.7)
- PostgresSQL
- GIT & GITHUB
- Any Code Editor (VS Code, Brackets, etc)
- Redis server
- imagemagick

### 1. Installation

Clone the project using the following bash command in an appropriate location:

```
git clone https://github.com/Jugalkishor1/Chatting-app.git 
```

### 2. Go to the project directory.
	cd Chatting-app

### 3. Run this command get the necesary gems.
	bundle install

### 4. Database setup
	rails db:drop
	rails db:create
	rails db:migrate

### 5. Run the server
In the project directory, you can run the project by using following bash command:
```	
rails server
```

And now you can visit the site with the URL http://localhost:3000
 

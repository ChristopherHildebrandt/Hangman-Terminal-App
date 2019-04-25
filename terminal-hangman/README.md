# Terminal Hangman
https://github.com/vivecuervo7/terminal-hangman

## Purpose
Aim is to provide a player with a game of Hangman

## Functionality
Player will be able to choose to play a new game of a chosen difficulty, view the scoreboard or view the game's rules. If a player wins a game with a high enough score, he or she will be able to enter their name into an arcade style top ten leaderboard

## Instructions
After cloning the repo run the following command `bundle install` to install relevant gems. Navigate to root of project and run `ruby src/hangman.rb`. To navigate the interface, press the character with an underline to select that option

## Screenshots
Screenshots taken can be found in the img folder. 
Evidence included:
- forethought towards the overall structure of the code within the app
- Trello planning in order to achieve the stated outcome
- GitHub work flow and collaboration (use of command line)

## Future Enhancements
* Extend wordlist or incorporate a gem to achieve this end

## Accessibility Concerns
Currently only supports English

## Legal, Moral, Ethical, Cultural or Safety Concerns
Possible upsetting scenes for those who have witnessed a loved one being hanged

## Possible Social, Political, Cultural, Racial, Gender or International Issues
Currently don't have a way to filter profanity or unpleasant words being entered during name submission for the scoreboard

## Brainstorming
We decided to settle on using a wordlist to generate the words themselves, and the ability for it to categorize these words, and also filter longer or shorter words based on the requested difficulty. This ended up being a module, as it didn't require instantiation and having it a persistent entity made it useful.

We started working on the app with the intention of moving the common strings into a prompts file to avoid polluting our main scripts with long strings, which didn't require for it to be either a class or module. The other thing we did with regard to strings was to have a file with extensions to the String class that would allow us to color or emphasize text, remove the formatting or allow us to wrap text at a defined length.

There would be need for a navigation system, and we decided to use the STDIN.getch as a clean way to grab user input, which would alleviate the need to constantly validate user input before using it. This led to the design decision to use a navigation module to handle the getting of user input, as this separated the input behaviour from the main script, which was supposed to be handling the non-game related portion of the UI.

The scoreboard was an early design choice, as we wanted to give the game a challenging aspect. Scoring was to be based off the number of letter in the word, the number of remaining guesses, and the number of unrevealed letters before a word guess was made.

The game logic being split into it's own class was something that occured during development as we quickly realized that the main script was getting slightly out of control, and being able to instantiate a new game class would be easier than trying to handle resetting all the data. The game class was then intended to handle all game logic, including the display of the current game state to the terminal. It would not interact with the wordlist, as the word and category would be passed to it upon instantiation.

## User Stories
As far as user stories go, the only entity interacting with the app would be the player themself. In regards to the player, it was decided that the player could expect the following 
* View the game's rules
* View the game's scoreboard
* Start a new game of a chosen difficulty
* Guess letters one at a time, or attempt to guess a word
* Have a text-based or graphical feedback after making a guess
* Either win or lose a game based on the rules

Trello Evidence, please refer to img folder:
- Day1_trello_progress.png
- Day1_trello.png
- Day1_trello.png


## Future Development
There is merit to assuming a dev may wish to extend the word file in the future, and time allowing we will provide a file that may be appended to in order to extend the word list, that is read by the app and used for providing words. One thing a dev must consider is that the game requires at least one of each of the following - an easy word with 4 or fewer letters, a hard word with at least seven letters, and a medium word with a number of letters between the two specified numbers.

## Timeline
We intend to have a fully working Minimum Viable Product (MVP) by end of day 24/04/2019. This allows us time to ensure code is properly commented throughout, fix up any errors, test edge cases, and address completeness of documentation on the 25/04/2019.

Please refer to img folder:
- project_timeline.jpg

## Overall App Design
The basic flow works using the modules outlined above (Brainstorming) by first displaying the UI screens to allow the player to view the rules, scoreboard or start a new game. After choosing a new game and selecting the difficulty, an instance of the game class takes control of the UI (passing in the word and category on instantiation). The game class handles the logic for the game including taking user input, and continues to run until the player either wins or loses.

After a loss, the player is taken back to the menu, while a win will submit the score to the leaderboard. If the score is high enough to make the leaderboard's top ten scores, it will ask the user to enter their name, and insert their record accordingly. This is then displayed to the user (prints the output to the screen - does not clear screen or assume control of entire terminal output), and the user is able to navigate back to the menu.

### Below must be added to appease assignment requirements

Screenshots of Trello board(s), Slack, etc:
Please see img folder:

Day 1 Trello
- Day1_trello_progress.png
- Day1_trello.jpg.png

Day 2 Trello
- Day2_trello_done.png
- Day2_trello.png

Trello Other
- Colaboration_on_trello.png
- trello_git_progress.png
- Selected_idea.png
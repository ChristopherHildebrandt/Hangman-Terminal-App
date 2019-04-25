require_relative 'string_extensions.rb'
require 'artii'

# Holds all the regularly used strings throughout the app, to prevent code
#   being polluted with too many long strings of text
a = Artii::Base.new

HEADER = a.asciify("HANGMAN")
WELCOME = "Welcome to Hangman. Please choose from the following options (Please, type an underlined character).\n\t#{"N".underline}ew Game\n\t#{"S".underline}coreboard\n\t#{"R".underline}ules\n\t#{"E".underline}xit"
DEFINITION = "noun\nhang·​man | haŋ-mən"
RULES = "Definition: A Player is given a random word and can guess letters, one at a time, or attempt to guess the word itself. The player is provided with a hint of the words category. Six incorrect guesses will result is a loss, where revealing the entire word is a win."
SCORING = "Scoring after a win is as follows:\n\n- 500 points for each letter in the word\n- 200 points for each remaining guess\n- 350 points for each unrevealed letter"
CHOOSE_GUESS_TYPE = "What would you like to do?\n\t#{"R".underline}eveal a letter\n\t#{"T".underline}ry and guess the word"
BACK = "\t#{"B".underline}ack"
LINE_BREAK = "\n"
REVEAL_LETTER_PROMPT = "Please enter the character you'd like to reveal (type 'back' to cancel)"
GUESS_WORD_PROMPT = "Please enter the word you'd like to guess (type 'back' to cancel)"
LETTER_ALREADY_GUESSED = "Sorry, you've already tried to reveal this letter. Press any key to continue"
WORD_ALREADY_GUESSED = "Sorry, you've already tried to guess this word. Press any key to continue"
LETTER_TOO_LONG = "Please enter one character only. Press any key to continue"
WIN_TEXT = "Congratulations! You won, check the scoreboard to see where you've placed".green
LOSS_TEXT = "Too bad, you ran out of guesses. Press any key to continue".red
DIFFICULTY_SELECTION_PROMPT = "Please select your difficulty level\n\t#{"1".underline} - Easy\n\t#{"2".underline} - Medium\n\t#{"3".underline} - Hard"

ARTWORK = [
    "
     _______________
    |   ____________|
    |  | //      ||
    |  |//
    |  |/
    |  |
    |  |
    |  |
    |  |
    |  |
    |  |\\
    |  |\\\\
    |  |_\\\\______________
    |                    \\
    |_____________________\\",
    "
     _______________
    |   ____________|
    |  | //      _|_
    |  |//      {'_'}
    |  |/
    |  |
    |  |
    |  |
    |  |
    |  |
    |  |\\
    |  |\\\\
    |  |_\\\\______________
    |                    \\
    |_____________________\\",
    "
     _______________
    |   ____________|
    |  | //      _|_
    |  |//      {'_'}
    |  |/      |     |
    |  |       |     |
    |  |       |_____|
    |  |
    |  |
    |  |
    |  |\\
    |  |\\\\
    |  |_\\\\______________
    |                    \\
    |_____________________\\",
    "
     _______________
    |   ____________|
    |  | //      _|_
    |  |//      {'_'}
    |  |/      |     |
    |  |       |     |
    |  |       |_____|
    |  |       /  ^
    |  |      /  /
    |  |     /__/
    |  |\\
    |  |\\\\
    |  |_\\\\______________
    |                    \\
    |_____________________\\",
    "
     _______________
    |   ____________|
    |  | //      _|_
    |  |//      {'_'}
    |  |/      |     |
    |  |       |     |
    |  |       |_____|
    |  |       /  ^  \\
    |  |      /  / \\  \\
    |  |     /__/   \\__\\
    |  |\\
    |  |\\\\
    |  |_\\\\______________
    |                    \\
    |_____________________\\",
    "
     _______________
    |   ____________|
    |  | //      _|_
    |  |//     _{'_'}
    |  |/     /|     |
    |  |     / |     |
    |  |    /_/|_____|
    |  |       /  ^  \\
    |  |      /  / \\  \\
    |  |     /__/   \\__\\
    |  |\\
    |  |\\\\
    |  |_\\\\______________
    |                    \\
    |_____________________\\",
    "
     _______________
    |   ____________|
    |  | //      _|_
    |  |//     _{x_x}_
    |  |/     /|     |\\
    |  |     / |     | \\
    |  |    /_/|_____|\\_\\
    |  |       /  ^  \\
    |  |      /  / \\  \\
    |  |     /__/   \\__\\
    |  |\\
    |  |\\\\
    |  |_\\\\______________
    |                    \\
    |_____________________\\"
]
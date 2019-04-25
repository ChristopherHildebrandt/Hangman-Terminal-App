require_relative 'classes/wordlist.rb'
require_relative 'prompts.rb'
require_relative 'string_extensions.rb'
require_relative 'navigation.rb'
require_relative 'classes/game.rb'
require_relative 'classes/scoreboard.rb'
include WordList
include Navigation
include Scoreboard

# Handles the basic UI navigation, starting new game, showing scoreboard and displaying rules

def main
    WordList.define_words
    Scoreboard.load_from_file
    show_welcome_screen
end

def show_welcome_screen
    reset_screen
    puts WELCOME
    Navigation.add_to_valid_input(["N","S","R","E"])
    wait_for_input
end

def show_new_game_prompt
    reset_screen
    word = WordList.get_random_word_with_category(get_difficulty).split(',')
    game = Game.new(word[1], word[0]) # should move to Game taking control of ui
    show_welcome_screen
end

def get_difficulty
    puts DIFFICULTY_SELECTION_PROMPT
    Navigation.reset_valid_input
    Navigation.add_to_valid_input(["1","2","3"])
    return wait_for_input
    return difficulty
end

def show_game_rules
    reset_screen
    puts DEFINITION, LINE_BREAK
    puts RULES.wrap_at_length(100)
    puts LINE_BREAK, SCORING, LINE_BREAK, BACK
    Navigation.add_to_valid_input(["B"])
    wait_for_input
end
# ==================================================================================== Check Chris' =================
def show_scoreboard
    reset_screen
    Scoreboard.display_scoreboard
    puts LINE_BREAK, LINE_BREAK
    Navigation.add_to_valid_input(["B"])
    puts BACK
    wait_for_input
end
# ==================================================================================== Check Chris' ================

def wait_for_input # wait for user to enter a character, if valid, perform action
    case Navigation.wait_for_valid_input
        when "N" then show_new_game_prompt
        when "S" then show_scoreboard # class implmentation ========================== Check Chris'
        when "R" then show_game_rules
        when "E" then exit
        when "B" then show_welcome_screen
        when "1" then return 1
        when "2" then return 2
        when "3" then return 3
        when "4" then return 4
    end
end

def reset_screen # reset terminal to show just the game's header
    clear_terminal
    Navigation.reset_valid_input
    puts HEADER, LINE_BREAK
end

def clear_terminal
    puts "\e[H\e[2J"
end

main # run program
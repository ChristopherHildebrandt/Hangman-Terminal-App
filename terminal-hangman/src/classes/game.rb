require_relative '../prompts.rb'
require_relative '../string_extensions.rb'
require_relative 'scoreboard.rb'
include Scoreboard


# The Game (game.rb) handles the logic of the program, scoring, and retrieving a word and/or letter input from the user.
# The Game will end when a win or a loss condition is met. Finally the control of program flow ends and hangman.rb assumes control.

class Game
    def initialize(word, category)
        @remaining_guesses = 6
        @revealed_letters = []
        @guessed_words = []
        @word = word
        @word_to_display = "_" * @word.length # word to display to player, replace word itself with underscores, or "blanks", such that "dog" is represented as "___"
        @category = category
        show_choice_dialog
    end

    def show_choice_dialog
        reset_screen
        puts CHOOSE_GUESS_TYPE
        Navigation.add_to_valid_input(["R","T"])
        wait_for_input
    end

    def get_letter_to_reveal
        loop do # loop until a valid character or cancel string is entered
            reset_screen
            puts REVEAL_LETTER_PROMPT
            char = gets.strip.downcase # force lowercase (using.downcase) for comparison
            if char =~ /[a-z]/ # ensure character is a valid alphabet character
                if char.length == 1
                    if !@revealed_letters.include?(char) # validates if player has already guessed this letter
                        @revealed_letters << char
                        reveal_letter(char)
                        break
                    else
                        puts LETTER_ALREADY_GUESSED
                        STDIN.getch
                    end
                else
                    if char == "back" # cancel and move back to choice of revealing letter or guessing word
                        show_choice_dialog
                        break
                    end
                    puts LETTER_TOO_LONG
                    STDIN.getch
                end
            end
        end
    end

    def reveal_letter(char)
        if @word.include?(char) # check if letter exists in word
            for i in (0..@word.length - 1) do
                if @word[i].downcase == char
                    @word_to_display[i] = char.upcase # replace blank space (underscore) in displayed word with the appropriate character
                end
            end
        else
            @remaining_guesses -= 1 # decrement number of available guesses if nothing was revealed
        end
        check_end_conditions
    end

    def guess_word
        loop do
            reset_screen
            puts GUESS_WORD_PROMPT
            guess = gets.strip.downcase # force lowercase for comparison
            if guess == "back" # cancel and move back to choice of revealing letter or guessing word
                show_choice_dialog
                break
            elsif @guessed_words.include?(guess)
                puts WORD_ALREADY_GUESSED
                STDIN.getch
            elsif (@word == guess)
                @word_to_display = @word.upcase
                break
            else
                @guessed_words << guess
                @remaining_guesses -= 1
                break
            end
        end
        check_end_conditions
    end

    def check_end_conditions
        if @word == @word_to_display.downcase
            reset_screen(false)
            puts WIN_TEXT
            Scoreboard.submit_score(calculate_score)
        elsif @remaining_guesses == 0
            @word_to_display = @word.upcase
            reset_screen
            puts LOSS_TEXT
            #puts "The word you were trying to guess was #{@word.upcase}"
            STDIN.getch
        else
            show_choice_dialog
        end
    end

    def calculate_score
        score = 500 * @word.length
        score += 200 * @remaining_guesses
        score += 350 * @word_to_display.count('_')
        return score
    end

    def wait_for_input # wait for user to enter a character, if valid, perform action
        case Navigation.wait_for_valid_input
            when "R" then get_letter_to_reveal
            when "T" then guess_word
        end
    end

    def reset_screen(show_artwork = true) # reset terminal to show just the game's header
        clear_terminal
        Navigation.reset_valid_input
        puts HEADER, LINE_BREAK
        puts "Your word belongs to the category \"#{@category.capitalize}\"", LINE_BREAK
        puts "Remaining guesses: #{@remaining_guesses}", LINE_BREAK
        if show_artwork
            puts ARTWORK[6 - @remaining_guesses], LINE_BREAK
        end
        puts "\t#{@word_to_display.chars.join(' ')}", LINE_BREAK
    end

    def clear_terminal
        puts "\e[H\e[2J"
    end
end
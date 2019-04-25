require 'terminal-table'
require 'yaml'
require_relative 'game.rb'
require 'yaml'

#  This is the scoreboard; it is responsible for prompting user of their games outcome and whether or not they have made
# the top scores on the scoreboard. Scoreboard is responsible for adding the current users score to the list of top names
# and scores. Whilst, validating if new score is in the top 10 and above 1000pts. 



module Scoreboard
    @top_names_and_scores = []
    @sort_rows = []
    @calculate_scores

    # submit_score - responsible for prompting user outcome during win or a loss case.
    # submit_score - if above 1000 user gets prompted to add a name for a chance to see if they made the score board
    # if not user will see their score but will unfortunately have to try again, prompted to main menu
    # in the case STDIN.getch is waiting for user to type any key on the keyboard
    def submit_score(score)
        if score_high_enough?(score) # if your score is above the current lowest score you have the chance to be on the scoreboard
            puts "You scored #{score} points! Enter a name for the scoreboard."
            add_to_scoreboard(gets.strip.upcase, score)
            display_scoreboard
            puts "Press any key to return to the menu."
            STDIN.getch
        else
            puts "You scored #{score}, unfortunately not high enough for the scoreboard.\n Press any key to return to the menu."
            STDIN.getch
        end
    end

    # add_to_scoreboard - responsible for adding the current user's score and name (if supplied) to an array within the nested
    # array of top_names_and_scores
    def add_to_scoreboard(name, score)
        @top_names_and_scores.push([name == "" ? "DEFAULT" : name, score]) # ternary checks if user submitted empty name, replaces with "DEFAULT" if that's the case
        File.open("./scoreboard.yml", "w") { |file| file.write(@top_names_and_scores.to_yaml) }
    end

    # sort_scoreboard - responsible for making sure new user name and score is sorted by indexed position of score.
    # sort_scoreboard - .sort(&:last).reverse ; will sort last indexed position of the array (score)
    # sort_scoreboard - first(10) ; makes sure only top 10 are displayed
    def sort_scoreboard
        @sort_rows = @top_names_and_scores
        @sort_rows = @sort_rows.sort_by(&:last).reverse.first(10)
    end

    # display scoreboard - controlls the appearence of the scoreboard, its styling and where elements will be positioned
    # uses terminal-table Ruby Gem to style to table, including: a title, headings for each column (name, score), rows (name, score),
    # style width of scoreboard lines and positioning. Finally, putting a scoreboard to the terminal.
    def display_scoreboard
        @table = Terminal::Table.new
        @table.title = "H A N G M A N".green
        @table.headings = ['Name', 'Score']
        @table.rows = sort_scoreboard
        @table.style = {:width => 45}
        @table.align_column(1, :right)
        puts @table
    end

    # If scoreboard array is empty and there is a file with records held, load these
    def load_from_file
        if @top_names_and_scores.length == 0 && File.file?('./scoreboard.yml')
            @top_names_and_scores = YAML.load(File.read('./scoreboard.yml'))
        end
    end

    def score_high_enough?(score)
        sort_scoreboard
        if @top_names_and_scores.count < 10 || score > @top_names_and_scores[9][1]
            return true
        end
        return false
    end
end
require 'io/console'

# Module will store an array of "valid" characters, and will provide a method for
#   getting user input and returning the character pressed, while ignoring invalid
#   input. On three incorrect characters, will deliver a direct prompt to the user
#   to use one of the underlined characters

module Navigation
    @valid_chars = []

    def add_to_valid_input(chars_to_validate) # chars_to_validate:String[]
        @valid_chars = (@valid_chars + chars_to_validate).uniq
    end

    def remove_from_valid_input(chars_to_invalidate) # chars_to_invalidate:String[]
        @valid_chars.reject! { |x| chars_to_invalidate.include?(x) }
    end

    def reset_valid_input # removes all items from valid input
        @valid_chars.clear
    end

    def wait_for_valid_input # waits for user input and if matches a valid char, returns that. App will force exit if invalid values are entered 5 times to prevent hanging
        force_exit_counter = 3
        @valid_chars.each do |char| char.upcase! end
        loop do
            input = STDIN.getch.upcase
            if @valid_chars.include?(input)
                return input
            else
                # replace exit code with a prompt to ask user to enter one of the underlined characters
                # force_exit_counter > 1 ? force_exit_counter -= 1 : exit
                if force_exit_counter == 0
                    puts "Please enter one of the underlined characters"
                end
            end
        end
    end
end
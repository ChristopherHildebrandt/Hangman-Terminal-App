require 'yaml'

module WordList
    @words = {} # words:(String, String[]) 
    @used_words = []

    def define_words
        if File.file?('./words.yml')
            @words = YAML.load(File.read('./words.yml'))
        else
            File.open("./words.yml", "w") { |file| file.write(load_sample_words.to_yaml) }
        end
    end

    def load_sample_words
        @words["animals"] = ["dog", "cat", "mouse", "rabbit", "elephant", "lion", "tiger", "alligator", "hippopotamus", "pig", "tiger", "bear", "lizard", "alpaca", "agouti", "monkey", "baboon", "badger", "bat", "duck", "egret", "snake", "goose", "eagle", "heron", "vulture", "tortoise", "mongoose", "zebra", "yak"]
        @words["school"] = ["desk", "pencil", "laptop", "eraser", "ruler", "calculator", "whiteboard", "pen", "compass", "locker", "crayons", "markers", "binder", "folder", "highlighter", "backpack", "agenda", "planner"]
        @words["zodiac"] = ["Aquarius", "Aries", "Cancer", "Capricorn", "Gemini", "Leo", "libra", "pisces", "sagittarius", "scorpio", "taurus", "virgo"]
        return @words
    end

    def get_random_word_with_category(difficulty = 0) # difficulty:Integer
        # returns a string from wordlist formatted as "category,word"
        # use .select to filter words by length in relation to difficulty passed as parameter
        # will attempt to get a unique word up to three times, if it still returns the same
        # word, can assume no unique words remain and thus just return the previously used word
        attempts_for_unused_word = 0
        difficulty = [[0, difficulty].max, 3].min # forces difficulty to be either 0 at lowest, or 3 at highest
        loop do
            case difficulty 
                when 0 then length = 1..100 
                when 1 then length = 1..4
                when 2 then length = 4..7
                when 3 then length = 7..100
            end
            # selecting a category based on a keyword then shuffling the array and selection position 0
            category = @words.keys.shuffle[0] 
            selected_word = @words[category].select{ |word| length === word.length }.shuffle[0]
            if !@used_words.include?(selected_word) || attempts_for_unused_word > 3
                return "#{category},#{selected_word.downcase}"
            else
                attempts_for_unused_word += 1 
            end
        end
    end
end
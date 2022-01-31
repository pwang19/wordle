require 'colorize.rb'
require 'open-uri'

class WordleGame
    def initialize(word_length = nil, target_word = nil)
        words_list = 'https://assets.aaonline.io/fullstack/ruby/projects/ghost/dictionary.txt'
        @dict = open(words_list) {|f| f.read }.split("\n")
        @dict.filter! { |word| word.length == word_length } if !word_length.nil?
        target_word.nil? ? @target_word = @dict[rand(@dict.length)] : @target_word = target_word
        @guesses = 0
        @letters_not_guessed = ('a'..'z').to_a
    end

    def guess(guess_word)
        @guesses += 1
        guess_word.each_char { |char| @letters_not_guessed.delete(char) }
        return guess_word == @target_word
    end

    def valid_word?(word)
        @dict.include?(word)
    end

    def run
        puts "You have #{@target_word.length + 1} tries to guess a #{@target_word.length} letter word."
        loop do
            print 'guess --> '
            guess_word = gets.chomp.downcase
            print '          '
            if valid_word?(guess_word)
                print_guess_word(guess_word)
                break if guess(guess_word)
                p @letters_not_guessed
                if @guesses == @target_word.length + 1
                    puts "You lose! The word was: #{@target_word}"
                    break
                end
            else
                puts 'Word not in dictionary!'
            end
        end
    end

    def print_guess_word(guess_word)
        (0..@target_word.length).each do |index|
            if guess_word[index] == @target_word[index]
                print guess_word[index].to_s.colorize(:green)
            elsif @target_word.include?(guess_word[index])
                print guess_word[index].to_s.colorize(:blue)
            else
                print guess_word[index].to_s.colorize(:red)
            end
        end
        puts ''
    end
end

WordleGame.new(5).run if __FILE__ == $PROGRAM_NAME
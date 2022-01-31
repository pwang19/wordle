require 'wordle_game.rb'

describe 'Wordle' do
    let(:wordle) { WordleGame.new }
    let(:wordle4) { WordleGame.new(4) }
    let(:wordle_word) { WordleGame.new(4, 'word') }

    it 'initializes instance variables correctly' do
        expect(wordle.instance_variable_get(:@guesses)).to eq 0
        expect(wordle4.instance_variable_get(:@guesses)).to eq 0
        expect(wordle_word.instance_variable_get(:@guesses)).to eq 0

        expect(wordle.instance_variable_get(:@dict).length).to eq 39081
        expect(wordle4.instance_variable_get(:@dict).length).to eq 1942
        expect(wordle_word.instance_variable_get(:@dict).length).to eq 1942

        # expect(wordle.instance_variable_get(:@target_word).length).to eq  --> cannot be tested because it is a random word
        expect(wordle4.instance_variable_get(:@target_word).length).to eq 4
        expect(wordle_word.instance_variable_get(:@target_word)).to eq 'word'

        expect(wordle.instance_variable_get(:@letters_not_guessed)).to eq ('a'..'z').to_a
        expect(wordle4.instance_variable_get(:@letters_not_guessed)).to eq ('a'..'z').to_a
        expect(wordle_word.instance_variable_get(:@letters_not_guessed)).to eq ('a'..'z').to_a
    end

    context 'guess' do
        it 'increments guesses by 1 and removes each character of guess from @letters_not_guessed' do
            expect(wordle_word.guess('step')).to eq false
            expect(wordle_word.instance_variable_get(:@guesses)).to eq 1
            expect(wordle_word.instance_variable_get(:@letters_not_guessed)).to eq ["a", "b", "c", "d", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "q", "r", "u", "v", "w", "x", "y", "z"]
            expect(wordle_word.guess('word')).to eq true
            expect(wordle_word.instance_variable_get(:@guesses)).to eq 2
            expect(wordle_word.instance_variable_get(:@letters_not_guessed)).to eq ["a", "b", "c", "f", "g", "h", "i", "j", "k", "l", "m", "n", "q", "u", "v", "x", "y", "z"]
        end
    end

    context 'valid_word?' do
        it 'returns false if word is not in the dictionary list of words' do
            expect(wordle.valid_word?('fakeword')).to eq false
        end

        it 'returns false if word is not the same length as the target word' do
            expect(wordle4.valid_word?('false')).to eq false
        end

        it 'returns true if word is a real word with the same length as the target word' do
            expect(wordle4.valid_word?('true')).to eq true
            expect(wordle_word.valid_word?('true')).to eq true
        end

        it 'returns true if word is the target word' do
            expect(wordle_word.valid_word?('word')).to eq true
        end
    end


end
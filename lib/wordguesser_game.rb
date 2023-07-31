class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_reader :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

  def guess(letter)


    if not(letter =~ /^[a-zA-Z]$/)
      raise ArgumentError, "Is not a letter"
    
    elsif letter == ''
      raise ArgumentError, "Is not empty"

    elsif letter == nil
      raise ArgumentError, "Is not nil"
    end
    
    letter.downcase!

    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end

    if @word.include?(letter)
      @guesses += letter
      return true
    else
      @wrong_guesses += letter 
      return true
    end
  end

  def word_with_guesses
    display = ''

    @word.chars do |letter|
      if @guesses.include?(letter)
        display += letter
      else
        display += "-"
      end
    end
    return display
  end

  def check_win_or_lose

    if wrong_guesses.length >= 7 
      return :lose
    end

    @word.chars do |letter|
      if @guesses.include?(letter)
      else
        return :play
      end
    end
    return :win
  end

end

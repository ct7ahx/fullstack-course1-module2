#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content,         - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result
  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency
  end

  def calculate_word_frequency
    counts = Hash.new(0)
    words = content.downcase.split(" ").sort
    for word in words
      counts[word] += 1
    end
    @highest_wf_count = counts.max_by{|k,v| v}[1]
    @highest_wf_words = []
    @highest_wf_words = counts.select{|k,v| v == @highest_wf_count}.keys
    #puts "CHAVES #{@line_number} #{@highest_wf_words}"
    #puts @highest_wf_count
  end

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* highest_count_across_lines - a number with the value of the highest frequency of a word
  #* highest_count_words_across_lines - an array with the words with the highest frequency
  attr_reader :highest_count_across_lines, :highest_count_words_across_lines, :analyzers
  @@i = 0

  def initialize
    @analyzers = Array.new
    @linhas = Array.new
  end

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers
  #* calculate_line_with_highest_frequency() - determines which line of
  #text has the highest number of occurrence of a single word
  #* print_highest_word_frequency_across_lines() - prints the words with the 
  #highest number of occurrences and their count
  def analyze_file
    File.foreach('test.txt') do |line|
      @@i = @@i + 1
      #puts line
      new_line = LineAnalyzer.new(line, @@i)
      #puts new_line.highest_wf_count
      #puts "#{new_line.highest_wf_words} #{new_line.highest_wf_count}"
      @analyzers << new_line
    end
  end
  
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the highest number of occurences of a word across all lines
  #and stores this result in the highest_count_across_lines attribute.
  #* identifies the words that were used with the highest number of occurrences
  #and stores them in print_highest_word_frequency_across_lines.
  def calculate_line_with_highest_frequency()
    maximo = @analyzers.max_by(&:highest_wf_count)
    @highest_count_across_lines = maximo.highest_wf_count
    @highest_count_words_across_lines = []
    @analyzers.each do |linha|
      if linha.highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines << linha
      end
    end
    #puts "maximo dos maximos: #{@highest_count_across_lines}#{highest_count_words_across_lines.flatten}"
    #@highest_count_words_across_lines = Array.new
    #@analyzers.each do |analyzed| 
    #  @highest_count_words_across_lines << analyzed.highest_wf_words
    #end
  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the result in the following format
  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |line|
      puts "#{line.highest_wf_words} (appears in line #{line.line_number})"
    end
    #puts "[\"#{highest_count_words_across_lines}\"] (appears in line#)"
  end
end

sol = Solution.new
sol.analyze_file
sol.calculate_line_with_highest_frequency
sol.print_highest_word_frequency_across_lines

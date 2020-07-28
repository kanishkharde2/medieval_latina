require "medieval_latina/version"

class MedievalLatina
  def self.[](text)
    new(text).call
  end

  def initialize(text)
    @index = 0
    @text = text
  end

  def call
    array = []

    until index >= text.length
      substring = Substring.new(text, index)
      result = vowel(substring) || consonant(substring) || Result.new(substring.character, 1)
      array.push(result.substring)
      self.index = index + result.increment_by
    end

    array.join("")
  end

  private

  attr_accessor :index
  attr_reader :text

  CONSONENTS = {
    c: ->(rest) { SOFT_C.any? { |item| rest.start_with?(item) } ? "ch" : "k" },
    g: ->(rest) { SOFT_G.any? { |item| rest.start_with?(item) } ? "j" : "g" },
    j: ->(rest) { "y" }
  }
  CONSONENT_TEAMS = {qu: "kw"}
  SOFT_C = ["e", "i", "ae", "oe"]
  SOFT_G = SOFT_C
  VOWEL_TEAMS = {ae: "ay", oe: "ay", au: "ow"}
  VOWELS = {a: "ah", e: "ay", i: "ee", o: "oh", u: "oo"}

  Result = Struct.new(:substring, :increment_by)

  def consonant(substring)
    consonant_team = CONSONENT_TEAMS[substring.to_team]
    consonant = if CONSONENTS.key?(substring.character.intern)
      CONSONENTS[substring.character.intern].call(substring.rest)
    end

    if consonant_team
      Result.new(consonant_team, 2)
    elsif consonant
      Result.new(consonant, 1)
    end
  end

  def vowel(substring)
    vowel_team = VOWEL_TEAMS[substring.to_team]
    vowel = VOWELS[substring.character.intern]

    if vowel_team
      Result.new(vowel_team, 2)
    elsif vowel
      Result.new(vowel, 1)
    end
  end

  class Substring
    attr_reader :character, :rest

    def initialize(text, index)
      @character = text[index]
      @rest = text.chars.drop(index + 1).join
    end

    def to_team
      "#{character}#{rest.chars.first}".intern
    end
  end

  class Error < StandardError; end
end

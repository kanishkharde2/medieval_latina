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
      character = text[index]
      rest = text.chars.drop(index + 1).join
      result = vowel(character, rest.chars.first) || consonent(character, rest)
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
    j: ->(rest) { "y" }
  }
  SOFT_C = ["e", "i", "ae", "oe"]
  VOWEL_TEAMS = {ae: "ay", oe: "ay", au: "ow"}
  VOWELS = {a: "ah", e: "ay", i: "ee", o: "oh", u: "oo"}

  Result = Struct.new(:substring, :increment_by)

  def consonent(character, rest)
    consonent = if CONSONENTS.key?(character.intern)
      CONSONENTS[character.intern].call(rest)
    else
      character
    end

    Result.new(consonent, 1)
  end

  def vowel(character, next_character)
    vowel_team = VOWEL_TEAMS["#{character}#{next_character}".intern]
    vowel = VOWELS[character.intern]

    if vowel_team
      Result.new(vowel_team, 2)
    elsif vowel
      Result.new(vowel, 1)
    end
  end

  class Error < StandardError; end
end

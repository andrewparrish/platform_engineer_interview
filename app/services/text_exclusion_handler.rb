class TextExclusionHandler
  attr_reader :text

  def initialize(text)
    @text = text
    @excluded = nil
  end

  def exclude(num_to_exclude = rand(word_count - 1))
    return [] unless multiple_unique_words?
    @excluded ||= generate_exclusive_words(num_to_exclude)
  end

  private

  def generate_exclusive_words(num_to_exclude)
    @text.split.uniq.sample(num_to_exclude).reject(&:nil?)
  end

  def multiple_unique_words?
    word_count > 1
  end

  def word_count
    @text.split.uniq.count
  end
end
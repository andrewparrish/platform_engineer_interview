class WordFrequencyValidator
  def initialize(text, exclusion, freq, cookies = nil)
    # Clean out punctuation that shouldn't be counted
    @text = text.downcase.gsub(/[^a-z0-9\s]/i, '')
    @exclusion = exclusion
    @cookies = cookies
    @freq = downcased_freq(freq)
  end

  def valid?
    frequency_count_correct?
  end

  private

  def downcased_freq(freq)
    new_hash = {}
    freq.each_pair do |k, v|
      new_hash.merge!(k.downcase => v)
    end

    new_hash
  end

  def correct_freq_hash
    freq = Hash.new(0)
    (split_text - @exclusion).each do |word|
      freq[word] += 1
    end

    freq
  end

  def split_text
    @text.downcase.strip.split
  end

  def frequency_count_correct?
    correct_freq_hash.each do |k, v|
      return false unless @freq[k] && @freq[k] == v
    end
    true
  end
end
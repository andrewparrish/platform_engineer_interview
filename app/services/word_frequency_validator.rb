class WordFrequencyValidator
  def self.from_request_params(params, cookies = nil)
    self.new(params['text'], params['exclude'], params['answer'], cookies)
  end

  def initialize(text, exclusion, freq, cookies = nil)
    # Clean out punctuation that shouldn't be counted
    @text = text
    @exclusion = exclusion
    @cookies = cookies
    @freq = freq
  end

  def valid?
    valid_params? && client_didnt_cheat? && frequency_count_correct?
  end

  # Custom setters for clearing out capitalization/punctuation
  def text
    @text.downcase.gsub(/[^a-z0-9\s]/i, '')
  end

  def exclusion
    @exclusion.map { |str| str.downcase.gsub(/[^a-z0-9\s]/i, '') }
  end

  private

  def valid_params?
    text_valid? && exclusion_valid? && answer_valid?
  end

  def text_valid?
    @text.is_a?(String)
  end

  def exclusion_valid?
    @exclusion.is_a?(Array) && @exclusion.map(&:class).count { |klass| klass == String } == @exclusion.count
  end

  def answer_valid?
    @freq.is_a?(Hash)
  end

  def client_didnt_cheat?
    CookieHashHandler.new(text, exclusion).valid?(@cookies)
  end

  def downcased_freq
    new_hash = {}
    @freq.each_pair do |k, v|
      new_hash.merge!(k.downcase => v.to_i)
    end

    new_hash
  end

  def correct_freq_hash
    freq = Hash.new(0)
    (split_text - exclusion).each do |word|
      freq[word] += 1
    end

    freq
  end

  def split_text
    text.strip.split
  end

  def frequency_count_correct?
    correct_freq_hash == downcased_freq
  end
end
class WordFrequencyValidator
  def self.from_request_params(params, cookies = nil)
    self.new(params['text'], params['exclude'], params['answer'], cookies)
  end

  def initialize(text, exclusion, freq, cookies = nil)
    # Clean out punctuation that shouldn't be counted
    @text = text.downcase.gsub(/[^a-z0-9\s]/i, '')
    @exclusion = exclusion.map { |str| str.downcase.gsub(/[^a-z0-9\s]/i, '') }
    @cookies = cookies
    @freq = downcased_freq(freq)
    @cookie_handler = CookieHashHandler.new(text, exclusion)
  end

  def valid?
    client_didnt_cheat? && frequency_count_correct?
  end

  private

  def client_didnt_cheat?
    @cookie_handler.valid?(@cookies)
  end

  def downcased_freq(freq)
    new_hash = {}
    freq.each_pair do |k, v|
      new_hash.merge!(k.downcase => v.to_i)
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
    correct_freq_hash == @freq
  end
end
class TextSampler
  TEXT_FOLDER = 'app/texts'

  def initialize
    @file_count = Dir[File.join(TEXT_FOLDER, '**', '*')].count { |file| File.file?(file) }
  end

  def sample_file
    @file = File.new rand_file_path
  end

  def text

  end

  private

  def rand_file_path
    Dir[File.join(TEXT_FOLDER, "**", '*')][rand_num]
  end

  def rand_num
    rand(@file_count - 1)
  end
end
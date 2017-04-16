class TextSampler
  TEXT_FOLDER = 'app/texts'

  attr_reader :file

  def initialize
    @file_count = Dir[File.join(TEXT_FOLDER, '**', '*')].count { |file| File.file?(file) }
    @file = nil
  end

  def randomize_file
    @file = File.new rand_file_path
    self
  end

  def text
    @file.read if @file
  end

  private

  def rand_file_path
    Dir[File.join(TEXT_FOLDER, "**", '*')].sample
  end
end
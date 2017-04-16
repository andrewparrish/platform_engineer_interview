require_relative '../spec_helper'
require "./app/services/text_sampler"

describe TextSampler, type: :service do

  sampler = TextSampler.new

  it 'sample a random file' do
    expect(sampler.randomize_file.file).not_to be_nil
    expect(sampler.randomize_file.file.class).to eql File
    expect(sampler.randomize_file.file.path).to match /texts\/\d+/
  end

  it 'returns nil for text if no file has been sampled yet' do
    expect(TextSampler.new.text).to be_nil
  end

  it 'can read text of random file' do
    expect(sampler.text).not_to be_nil
    expect(sampler.text.class).to eql String
  end
end
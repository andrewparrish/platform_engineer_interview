require_relative '../spec_helper'
require "./app/services/text_sampler"

describe TextSampler, type: :service do

  sampler = TextSampler.new

  it 'sample a random file' do
    expect(sampler.sample_file).not_to be_nil
    expect(sampler.sample_file.class).to eql File
    expect(sampler.sample_file.path).to match /texts\/\d+/
  end
end
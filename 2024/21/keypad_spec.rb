require 'rspec'
require_relative 'keypad'

RSpec.describe Keypad do
  let(:described_object) { described_class.new(input) }
  let(:input) do
    <<~INPUT
      029A
      980A
      179A
      456A
      379A
    INPUT
  end
  let(:result) { 126_384 }

  it 'returns the correct result' do
    expect(described_object.part1).to eq(result)
  end

  xcontext 'with actual input' do
    let(:input) { actual }
    let(:result) { 34_393 }

    it 'returns the correct result' do
      expect(described_object.part1).to eq(result)
    end
  end

  xcontext 'with actual input part 2' do
    let(:input) { actual }
    let(:result) { 83_551_068_361_379 }

    it 'returns the correct result' do
      expect(described_object.part2).to eq(result)
    end
  end

  let(:actual) do
    <<~ACTUAL
      869A
      180A
      596A
      965A
      973A
    ACTUAL
  end
end

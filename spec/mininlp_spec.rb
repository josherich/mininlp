require 'mininlp'

RSpec.describe Mininlp do
  it "has a version number" do
    expect(Mininlp::VERSION).not_to be nil
  end

  it "exact same sentence should have 0 WER" do
    expect(Mininlp::WER.getDistance(['I', 'have', 'a', 'dream'], ['I', 'have', 'a', 'dream'])).to eq(0.0)
  end

  it "sentence with one insert should have 1.0 distance" do
    expect(Mininlp::WER.getDistance(['I', 'have', 'a', 'dream'], ['I', 'have', 'a', 'good', 'dream'])).to eq(1.0)
  end

  it "sentence with one delete should have 1.0 distance" do
    expect(Mininlp::WER.getDistance(['I', 'have', 'a', 'dream'], ['I', 'have', 'dream'])).to eq(1.0)
  end

  it "sentence with one substitute should have 1.0 distance" do
    expect(Mininlp::WER.getDistance(['I', 'have', 'a', 'dream'], ['I', 'have', 'two', 'dream'])).to eq(1.0)
  end

  it "chinese sentence 我爱你, 你爱我 should have 2.0 distance" do
    expect(Mininlp::WER.getDistance('我爱你'.split(''), '你爱我'.split(''))).to eq(2.0)
  end

  it "test on real sentence" do
    expect(Mininlp::WER.calculate('自如“甲醛门”调查：空置期形同虚设 篡改检测结果'.split(''), '【深度】自如“甲醛门”调查：空置期形同虚设，篡改检测结果'.split(''))).to be > 0.1
  end
end

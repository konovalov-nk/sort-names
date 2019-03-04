RSpec.describe SortNames do
  it 'has a version number' do
    expect(SortNames::VERSION).not_to be nil
  end

  describe "#run" do
    it "runs" do
      SortNames.run
    end
  end
end

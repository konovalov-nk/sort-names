RSpec.describe 'MergeSort' do
  subject { SortNames::Utility::MergeSort }

  let(:data) {
    [
        [
            %w(Adebayor Emmanuel 31 310-4951),
            %w(Aliadiere Jeremie 21 189-9207),
        ],
        [
            %w(Cech Petr 37 428-4820),
            %w(Cerny Radek 34 401-1042),
            %w(Clichy Gael 32 735-3308),
        ],
        [
            %w(Connolly Matthew 28 239-1471),
            %w(Crespo Hernan 37 177-7697),
            %w(Cudicini Carlo 25 471-4850),
        ],
    ].map(&:to_enum)
  }

  let(:result) {
    [
        %w(Adebayor Emmanuel 31 310-4951),
        %w(Aliadiere Jeremie 21 189-9207),
        %w(Cech Petr 37 428-4820),
        %w(Cerny Radek 34 401-1042),
        %w(Clichy Gael 32 735-3308),
        %w(Connolly Matthew 28 239-1471),
        %w(Crespo Hernan 37 177-7697),
        %w(Cudicini Carlo 25 471-4850),
    ]
  }

  it 'sorts the array properly' do
    expect(subject.process(*data).to_a).to eq(result)
  end

  # describe 'edge cases' do
    # it 'returns -1 for nil input' do
    #   expect(subject.solution(nil)).to eq(-1)
    # end
  # end
end

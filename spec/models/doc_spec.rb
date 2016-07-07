require 'rails_helper'

RSpec.describe Doc, :type => :model do
  let(:subject) { Doc::Creating.create(title: 'What Matters') }

  describe '#whats_next' do
    it 'returns items sorted by highest-ranking in both lists' do
      subj = subject.becomes(Doc::AddingItem)
      subj.add_item = {content: 'Run for president'}
      subj.add_item = {content: 'Watch a documentary'}
      subj.add_item = {content: 'Spread sustainable agriculture'}
      subj.add_item = {content: 'Fight pirates'}
      subj.add_item = {content: 'End poverty'}

      # sanity
      expect(subj.whats_next.map(&:content)).to eq([
        "Run for president",
        "Watch a documentary",
        "Spread sustainable agriculture",
        "Fight pirates",
        "End poverty"
      ])

      # a bit haphazard, I can't honestly say I grok how the formula is going to work,
      # but things changed...
      subj.lists.first.positions[4].update_attribute(:position, 0)
      subj.lists.first.positions[0].update_attribute(:position, 4)

      expect(subj.whats_next.map(&:content)).to eq([
        "Watch a documentary",
        "End poverty",
        "Spread sustainable agriculture",
        "Run for president",
        "Fight pirates"
      ])
    end
  end
end

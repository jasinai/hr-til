require 'rails_helper'

describe TwitterTimeMachine do

  context 'with candidate posts' do

    it 'returns the right post' do
      (5..11).each do |n|
        date = Date.new(2015, 1, n)
        FactoryGirl.create(:post,
          title: "Post published on #{date} with #{n} likes",
          body: "Content published on #{date} with #{n} likes",
          created_at: date,
          published_at: date,
          likes: n,
         )
      end

      result = described_class.tweet(Date.new(2016, 1, 5))
      expect(result).to eq Post.find_by(title: "Post published on 2015-01-11 with 11 likes")
    end
  end

  context 'with no candidate posts that are unliked' do
    it 'does nothing'
  end

  context 'with no posts' do
    it 'does nothing'
  end
end

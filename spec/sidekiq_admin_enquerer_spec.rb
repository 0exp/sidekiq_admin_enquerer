# frozen_string_literal: true

RSpec.describe 'Gem Version' do
  it 'has a version number' do
    expect(SidekiqAdminEnquerer::VERSION).not_to be nil
  end
end

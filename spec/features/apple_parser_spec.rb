require 'rails_helper'
require 'spec_helper'
require 'scraper'

describe Scraper do

  describe 'Correct working' do
    it 'with imei 013977000323877 got correct data' do
      Scraper.get_support_period('013977000323877').should eq ['Active', 'August 10, 2016']
    end

    it 'with this imei 013896000639712 get unsupported' do
      Scraper.get_support_period('013896000639712').should eq ['Expired', '']
    end

  end

  describe 'wrong imei' do

    it 'wrong imei' do
      expect{Scraper.get_support_period('019712')}.to raise_error
    end

  end


end
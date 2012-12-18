#!/usr/bin/env ruby
# Encoding: utf-8
#
# Author:: api.dklimkin@gmail.com (Danial Klimkin)
#
# Copyright:: Copyright 2012, Google Inc. All Rights Reserved.
#
# License:: Licensed under the Apache License, Version 2.0 (the "License");
#           you may not use this file except in compliance with the License.
#           You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#           Unless required by applicable law or agreed to in writing, software
#           distributed under the License is distributed on an "AS IS" BASIS,
#           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#           implied.
#           See the License for the specific language governing permissions and
#           limitations under the License.
#
# This example illustrates how to retrieve all the disapproved ads in a given
# ad group with AWQL. To add ads, run add_text_ads.rb.
#
# Tags: AdGroupAdService.query

require 'adwords_api'

def get_all_disapproved_ads_with_awql(ad_group_id)
  # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
  # when called without parameters.
  adwords = AdwordsApi::Api.new

  # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
  # the configuration file or provide your own logger:
  # adwords.logger = Logger.new('adwords_xml.log')

  ad_group_ad_srv = adwords.service(:AdGroupAdService, API_VERSION)

  # Get all the disapproved ads for this campaign.
  query = ('SELECT Id, DisapprovalReasons ' +
      'WHERE AdGroupId = %d AND CreativeApprovalStatus = DISAPPROVED ' +
      'ORDER BY Id') % ad_group_id

  response = ad_group_ad_srv.query(query)
  if response and response[:entries]
    ad_group_ads = response[:entries]
    puts 'Ad group ID %d has %d disapproved ad(s).' %
        [ad_group_id, ad_group_ads.length]
    ad_group_ads.each do |ad_group_ad|
      puts ("\tAd with ID %d and type '%s' was disapproved for the following " +
          + 'reasons:') % [ad_group_ad[:ad][:id], ad_group_ad[:ad][:xsi_type]]
      ad_group_ad[:ad][:disapproval_reasons].each do |reason|
        puts "\t\t%s" % reason
      end
    end
  else
    puts 'No disapproved ads found for ad group ID %d.' % ad_group_id
  end
end

if __FILE__ == $0
  API_VERSION = :v201206

  begin
    # ID of an ad group to get disapproved ads for.
    ad_group_id = 'INSERT_AD_GROUP_ID_HERE'.to_i
    get_all_disapproved_ads_with_awql(ad_group_id)

  # HTTP errors.
  rescue AdsCommon::Errors::HttpError => e
    puts 'HTTP Error: %s' % e

  # API errors.
  rescue AdwordsApi::Errors::ApiException => e
    puts 'Message: %s' % e.message
    puts 'Errors:'
    e.errors.each_with_index do |error, index|
      puts "\tError [%d]:" % (index + 1)
      error.each do |field, value|
        puts "\t\t%s: %s" % [field, value]
      end
    end
  end
end

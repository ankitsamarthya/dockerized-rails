# frozen_string_literal: true

namespace :sqs_subscriber do
  desc 'Initialize accounting_service subscriber'
  task subscribe_test: :environment do
    Rails.logger.info 'Starting AccountingService subscriber...'
    TestSubscriber.new.subscribe
  end
end

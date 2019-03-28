class TestSubscriber
  require 'aws-sdk-sqs'

  def initialize
    @sqs = Aws::SQS::Client.new(endpoint: ENV['SQS_ENDPOINT'], region: ENV['SQS_REGION'])
    @queue_url = @sqs.get_queue_url(queue_name: ENV['SQS_QUEUE_NAME']).queue_url
    @poller = Aws::SQS::QueuePoller.new(@queue_url)
  end

  def subscribe
    @poller.poll(
      max_number_of_messages: 10,
    ) do |messages|
      messages.each do |message|
        puts "Message received: #{message.inspect}"
        Rails.logger.info "Message received: #{message.inspect}"
      end
    end
  end
end

# aws --endpoint-url http://localhost:9324 sqs create-queue --queue-name newqueue
# aws --endpoint-url http://localhost:9324 sqs send-message --queue-url http://localhost:9324/queue/newqueue --message-body "Hello, queue"
# aws --endpoint-url http://localhost:9324 sqs receive-message --queue-url http://localhost:9324/queue/newqueue --wait-time-seconds 10

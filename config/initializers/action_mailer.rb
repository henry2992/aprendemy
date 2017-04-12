ActionMailer::DeliveryJob.rescue_from(SparkPostRails::DeliveryException) do |exception|

end
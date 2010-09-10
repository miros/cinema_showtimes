require 'metric_fu'

MetricFu::Configuration.run do |config|

    config.reek = { :dirs_to_reek => ['app', 'lib'] }

    config.metrics  = [:churn, :saikuro, :stats, :flog, :flay, :reek]
    #config.metrics  = [:reek]
    config.graphs   = [:stats, :flog, :flay, :reek]

end
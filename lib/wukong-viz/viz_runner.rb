require_relative('jsonizer')
module Wukong
  module Viz

    # Runs the wu-viz command.
    class VizRunner < Wukong::Local::LocalRunner

      usage "FLOW|PROCESSOR"

      description <<-EOF.gsub(/^ {8}/,'')

        wu-viz is a tool for creating intermediate representations of
        dataflows useful for visualization or static analysis.

        Dump a given dataflow as JSON:

          $ wu-viz some_flow

        Dump all known dataflows as JSON:

          $ wu-viz --all
      EOF
      
      include Logging


      # Validates that a dataflow was given.
      def validate
        return true if settings[:all]
        raise Error.new("Must provide a dataflow to visualize, via either the --run option or as the first argument, or provide the --all argument to see all flows.") unless processor
        raise Error.new("No such dataflow <#{processor}>") unless registered?(processor)
        raise Error.new("<#{processor}> is a processor, not a dataflow") unless Wukong.registry.retrieve(processor.to_sym).is_a?(Wukong::Dataflow::Builder)
      end

      # Prints out the 
      def run
        dataflows.each do |dataflow|
          puts MultiJson.dump(Jsonizer.new(dataflow).create)
        end
      end

      private
      
      def dataflows
        settings[:all] ? Wukong.registry.show.values.find_all { |val| val.class == Wukong::DataflowBuilder } : [Wukong.registry.retrieve(processor.to_sym) ]
      end

    end
  end
end

require 'wukong'

module Wukong
  # Creates intermediate representations of dataflows.
  module Viz
    include Plugin

    # Configure `settings` for Wukong-Viz.
    #
    # Will ensure that `wu-viz` has the same settings as `wu-local`.
    #
    # @param [Configliere::Param] settings the settings to configure
    # @param [String] program the currently executing program name
    def self.configure settings, program
      if program == 'wu-viz'
        Wukong::Local.configure(settings, 'wu-load')
        settings.define :all, :type => :boolean, :description => "Describe all dataflows", :default => false
      end
    end

    # Boot Wukong-Load from the resolved `settings` in the given
    # `dir`.
    #
    # @param [Configliere::Param] settings the resolved settings
    # @param [String] dir the directory to boot in
    def self.boot settings, dir
    end
    
  end
end

require_relative('wukong-viz/viz_runner')

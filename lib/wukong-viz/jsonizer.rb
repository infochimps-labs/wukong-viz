module Wukong
  module Viz
    class Jsonizer

      attr_accessor :dataflow

      def initialize(dataflow)
        self.dataflow = dataflow
      end

      def create
        {_id: dataflow.label, name: dataflow.label, stages: [], edges: []}.tap do |json|

          size = dataflow.stages.size
          
          dataflow.stages.each_with_index do |label_and_stage, index|
            stage_label, stage = label_and_stage
            
            stage_type = case index
                         when 0        then 'source'
                         when size - 1 then 'sink'
                         else               'decorator'
                         end
            
            stage_id = [dataflow.label, stage.label].map(&:to_s).join('.')
            json[:stages] << {
              _id:        stage_id,
              flow_id:    dataflow.label,
              stage_type: stage_type,
              stage_icon: 'wukong',
              name:       stage.label,
              doc:        stage.for_class.description
            }
            json[:stages] << {
              _id:        stage_id + '-cargo',
              flow_id:    dataflow.label,
              stage_type: 'cargo',
              schema:     {
                name: "fake_record",
                type: "fake_record",
                doc:  "A fake record",
                fields: [
                         {name: 'foo', type: 'int'},
                         {name: 'bar', type: 'int'}
                        ]
              }
            }
          end
          
          dataflow.links.each_with_index do |link, index|
            json[:edges] << {
              _id:        index.to_i + 101,
              from_id:    [dataflow.label, link.from].map(&:to_s).join('.'),
              into_id:    [dataflow.label, link.into].map(&:to_s).join('.')
            }
          end
        end
      end
      
    end
  end
end

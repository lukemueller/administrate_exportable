module AdministrateExportable
  module Exporter
    extend ActiveSupport::Concern

    included do
      exportable
    end

    class_methods do
      def exportable
        define_method(:export) do
          params = request.query_parameters || {}
          csv_data = ExporterService.csv(dashboard,
                                         resource_class,
                                         params[:start_date],
                                         params[:end_date])

          respond_to do |format|
            format.csv { send_data csv_data, filename: "#{resource_name.to_s.pluralize}-#{Date.today}.csv" }
          end
        end
      end
    end
  end
end

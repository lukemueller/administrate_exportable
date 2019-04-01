require 'rails_helper'

RSpec.describe 'Exporter Concern', type: :request do
  describe 'GET export' do
    it 'returns a csv file' do
      get export_admin_users_url(format: :csv)

      expect(response.header['Content-Type']).to include 'text/csv'
    end

    it 'calls ExporterService' do
      expect(AdministrateExportable::ExporterService).to receive(:csv)
        .with(an_instance_of(UserDashboard), User, nil, nil)

      get export_admin_users_url(format: :csv)
    end

    it 'calls ExporterService with start and end date' do
      start_date = DateTime.current - 1.week
      end_date = DateTime.current

      expect(AdministrateExportable::ExporterService).to receive(:csv)
        .with(an_instance_of(UserDashboard), User, start_date.to_s, end_date.to_s)

      get export_admin_users_url(params: {start_date: start_date, end_date: end_date}, format: :csv)
    end
  end
end

# frozen_string_literal: true
class NormalizerController < ApplicationController
  # POST /upload
  def upload
    file = normalizer_params[:file]
    file_ext = file.original_filename.split('.').last

    xlsx = Roo::Spreadsheet.open(file.path, extension: file_ext)

    addresses = []

    xlsx.sheet(0).each do |row|
      addresses << row[0]
    end

    geocoded_rows = geocode_addresses(addresses)
    create_and_send_xlsx(geocoded_rows)
  end

  private

  def normalizer_params
    params.permit(:file)
  end

  def geocode_addresses(addresses)
    rows_results = []

    # We will use a maximum of addresses/rows
    addresses = addresses.first(500)

    addresses.each_with_index do |address, index|
      # Geocoder could fail if the google requests limit is exceeded
      # so we redo the requests until google is able to geocode
      logger.info "ADDRESS #{index}: #{address}"

      begin
        coords = Geocoder.coordinates(address)

        row =
          if coords.nil?
            [address, nil, nil]
          else
            [address] + coords
          end

        rows_results << row
      rescue => error
        logger.info error.inspect
        redo
      end
    end

    rows_results
  end

  def create_and_send_xlsx(rows)
    package = Axlsx::Package.new
    workbook = package.workbook

    workbook.add_worksheet(name: 'Sheet1') do |sheet|
      rows.each do |row|
        sheet.add_row row
      end
    end

    filename = SecureRandom.hex

    package.serialize("tmp/#{filename}.xlsx")

    send_data(File.open("tmp/#{filename}.xlsx").read, filename: 'Coordenadas.xlsx')

    File.delete("tmp/#{filename}.xlsx")
  end
end

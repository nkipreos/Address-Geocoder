module ApplicationHelper

	def generateExcel(filename)
		file = Spreadsheet.open "#{filename}"
		(0..file.worksheet(0).last_row_index).to_a.each do |iter|
			coords = Geocoder.coordinates(file.worksheet(0).cell(iter,0))
			!coords.nil? ? file.worksheet(0).insert_row(iter,[file.worksheet(0).cell(iter,0), coords[0], coords[1]]) : file.worksheet(0).insert_row(iter,[file.worksheet(0).cell(iter,0), "", ""])
		end
		outname = Digest::SHA256.hexdigest(Time.now.to_s + rand(100).to_s)
		file.write("#{outname}.xls")
		"#{outname}.xls"
	end

end
